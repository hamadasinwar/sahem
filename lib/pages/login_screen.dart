import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahemapp/services/auth.dart';
import '../models/user.dart';
import '../pages/sign_up_screen.dart';
import '../services/firestore.dart';
import '../utils/helpers.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({Key? key}) : super(key: key);
  static const routeName = "login";

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  var visibilityIcon = Icons.visibility_off_rounded;
  bool visibility = true;
  final _formKey = GlobalKey<FormState>();

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: false,
      body: FutureBuilder<List<MyUser>>(
        future: FirestoreServices().users,
        builder: (context, snapshot) {
          return Container(
            padding: const EdgeInsets.symmetric(horizontal: 50),
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Hero(
                  tag: 'login',
                  child: Image.asset(
                    'assets/images/logo3.png',
                    height: 200,
                  ),
                ),
                const SizedBox(height: 10),
                Text(
                  'تسجيل الدخول',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: height * 0.05),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(context, 'رقم الموبايل', controller: phoneController),
                      const SizedBox(height: 10),
                      buildTextField(context, 'كلمة المرور', controller: passwordController),
                    ],
                  ),
                ),
                //login button
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(15),
                    child: SizedBox(
                      height: 46,
                      width: 155,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Theme.of(context).accentColor),
                        ),
                        onPressed: ()async {
                          if(_formKey.currentState?.validate()??false){
                            for(var user in snapshot.data!){
                              if(phoneController.text == user.phone && passwordController.text == user.password){
                                await Auth.loginUser(user, context, false);

                                //Navigator.of(context).pushReplacementNamed(MainPage.routeName);
                              }
                            }
                          }
                        },
                        child: Text(
                          "دخول",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                      ),
                    ),
                  ),
                ),
                //register??
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "لا تمتلك حساب؟",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context).pushReplacementNamed(SignUpScreen.routeName);
                      },
                      child: Text(
                        " سجل الآن",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                )
              ],
            ),
          );
        }
      ),
    );
  }

  Widget buildTextField(BuildContext ctx, String label, {TextEditingController? controller}) {
    return Column(
      children: [
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
          child: Row(
            children: [
              Text(
                label,
                style: Theme.of(ctx).textTheme.bodyText1,
              ),
            ],
          ),
        ),
        TextFormField(
          obscureText: label == "كلمة المرور" ? visibility : false,
          keyboardType: label == "كلمة المرور"
              ? TextInputType.visiblePassword
              : TextInputType.phone,
          controller: controller,
          style: Theme.of(ctx).textTheme.bodyText1,
          cursorColor: Colors.white,
          decoration: InputDecoration(
              suffixIcon: label == "كلمة المرور"
                  ? IconButton(
                      onPressed: () {
                        setState(() {
                          visibility = !visibility;
                          if (visibility) {
                            visibilityIcon = Icons.visibility_off_rounded;
                          } else {
                            visibilityIcon = Icons.visibility_rounded;
                          }
                        });
                      },
                      icon: Icon(
                        visibilityIcon,
                        color: Theme.of(context).accentColor,
                      ),
                    )
                  : null,
              isDense: true,
              contentPadding: const EdgeInsets.all(22),
              enabledBorder: textFieldBorder(Colors.grey),
              focusedBorder: textFieldBorder(Theme.of(ctx).accentColor),
              errorBorder: textFieldBorder(Colors.red[600]!),
              focusedErrorBorder: textFieldBorder(Colors.red[600]!),
              errorStyle: TextStyle(
                  color: Colors.red[600], fontWeight: FontWeight.bold)),
          validator: (value) {
            if (value == null || value.isEmpty) {
              return 'الرجاء ملء الحقول';
            }else{
              if(label == 'كلمة المرور' && value.length<8){
                return 'كلمة المرور يجب أن تكون 8 حروف واكثر';
              }else if(label != 'كلمة المرور' && value.length<10){
                return 'رقم موبايل خاطئ';
              }
            }
            return null;
          },
        ),
      ],
    );
  }
}
