import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:sahemapp/services/auth.dart';
import '../models/user.dart';
import '../utils/helpers.dart';
import 'login_screen.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({Key? key}) : super(key: key);
  static const routeName = "signup";

  @override
  _SignUpScreenState createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController phoneController = TextEditingController();
  final TextEditingController nameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  var visibilityIcon = Icons.visibility_off_rounded;
  bool visibility = true;
  String _currentSelectedValue = states.last;

  @override
  Widget build(BuildContext context) {
    final size = MediaQuery.of(context).size;
    final height = size.height;

    return Scaffold(
      backgroundColor: Theme.of(context).primaryColor,
      resizeToAvoidBottomInset: true,
      body: SingleChildScrollView(
        child: SafeArea(
          child: Container(
            padding: const EdgeInsets.symmetric(horizontal: 50, vertical: 25),
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
                  'إنشاء حساب',
                  style: Theme.of(context).textTheme.headline6,
                ),
                SizedBox(height: height * 0.03),
                Form(
                  key: _formKey,
                  child: Column(
                    children: [
                      buildTextField(context, 'رقم الموبايل', controller: phoneController),
                      const SizedBox(height: 10),
                      buildTextField(context, 'اسم المستخدم', controller: nameController),
                      const SizedBox(height: 10),
                      buildTextField(context, 'كلمة المرور', controller: passwordController),
                      const SizedBox(height: 10),
                      Padding(
                        padding: const EdgeInsets.symmetric(
                            horizontal: 10, vertical: 5),
                        child: Row(
                          children: [
                            Text(
                              "المحافظة",
                              style: Theme.of(context).textTheme.bodyText1,
                            ),
                          ],
                        ),
                      ),
                      Theme(
                        data: ThemeData(
                            canvasColor: Theme.of(context).primaryColor),
                        child: FormField<String>(
                          builder: (FormFieldState<String> state) {
                            return InputDecorator(
                              decoration: InputDecoration(
                                isDense: true,
                                contentPadding: const EdgeInsets.all(22),
                                enabledBorder: OutlineInputBorder(
                                  borderSide: const BorderSide(
                                      color: Colors.grey, width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                                focusedBorder: OutlineInputBorder(
                                  borderSide: BorderSide(
                                      color: Theme.of(context).accentColor,
                                      width: 2),
                                  borderRadius: BorderRadius.circular(15),
                                ),
                              ),
                              isEmpty: _currentSelectedValue == '',
                              child: DropdownButtonHideUnderline(
                                child: DropdownButton<String>(
                                  icon: Icon(
                                    Icons.arrow_downward_rounded,
                                    size: 30,
                                    color: Theme.of(context).accentColor,
                                  ),
                                  value: _currentSelectedValue,
                                  isDense: true,
                                  onChanged: (String? newValue) {
                                    setState(() {
                                      _currentSelectedValue = newValue ?? '';
                                      state.didChange(newValue);
                                    });
                                  },
                                  items: states.map((String value) {
                                    return DropdownMenuItem<String>(
                                      value: value,
                                      child: Text(
                                        value,
                                        style: Theme.of(context)
                                            .textTheme
                                            .bodyText1,
                                        overflow: TextOverflow.visible,
                                      ),
                                    );
                                  }).toList(),
                                ),
                              ),
                            );
                          },
                        ),
                      )
                    ],
                  ),
                ),
                //register button
                Padding(
                  padding: const EdgeInsets.all(15),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(18),
                    child: SizedBox(
                      height: 46,
                      width: 155,
                      child: ElevatedButton(
                        style: ButtonStyle(
                          backgroundColor: MaterialStateProperty.resolveWith(
                              (states) => Theme.of(context).accentColor),
                        ),
                        child: Text(
                          "تسجيل الدخول",
                          style: Theme.of(context).textTheme.headline5,
                        ),
                        onPressed: () async {
                          await Firebase.initializeApp();
                          if (_formKey.currentState?.validate() ?? false) {
                            var s = MyUser(
                                phone: phoneController.text,
                                name: nameController.text,
                                password: passwordController.text,
                                state: _currentSelectedValue);
                            await Auth.loginUser(s, context, true);
                          }
                        },
                      ),
                    ),
                  ),
                ),
                //already have account
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      "لديك حساب؟",
                      style: Theme.of(context).textTheme.headline4,
                    ),
                    TextButton(
                      onPressed: () {
                        Navigator.of(context)
                            .pushReplacementNamed(LogInScreen.routeName);
                      },
                      child: Text(
                        " سجل الدخول",
                        style: Theme.of(context).textTheme.bodyText2,
                      ),
                    ),
                  ],
                )
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget buildTextField(BuildContext ctx, String label, {TextEditingController? controller}) {
    var type = TextInputType.name;
    if(label == 'كلمة المرور'){
      type = TextInputType.visiblePassword;
    }else if(label == 'رقم الموبايل'){
      type = TextInputType.phone;
    }
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
          keyboardType: type,
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
            } else {
              if (label == 'كلمة المرور' && value.length < 8) {
                return 'كلمة المرور يجب أن تكون 8 حروف واكثر';
              } else if (label != 'كلمة المرور' && value.length < 10) {
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
