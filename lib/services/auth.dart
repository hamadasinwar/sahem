import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:pinput/pin_put/pin_put.dart';
import 'package:sahemapp/models/user.dart';
import 'package:sahemapp/pages/login_screen.dart';
import 'package:sahemapp/pages/main_page.dart';
import 'package:sahemapp/services/firestore.dart';
import 'package:sahemapp/utils/helpers.dart';

class Auth {

  static String checkIsLoggedIn(){
    if(FirebaseAuth.instance.currentUser != null){
      return MainPage.routeName;
    }
    return LogInScreen.routeName;
  }

  static void phoneAuth(BuildContext ctx, String verificationID, String pinCode) async {
    await FirebaseAuth.instance.signInWithCredential(
      PhoneAuthProvider.credential(
          verificationId: verificationID, smsCode: pinCode),
    );
  }

  static Future<bool?> loginUser(MyUser myUser, BuildContext context, bool isNewAccount) async{
    FirebaseAuth _auth = FirebaseAuth.instance;
    final controller = TextEditingController();
    _auth.verifyPhoneNumber(
      phoneNumber: myUser.phone??'',
      timeout: const Duration(seconds: 90),
      verificationCompleted: (phoneAuthCredential) {},
      verificationFailed: (error) {
        print(error);
      },
      codeSent: ( verificationId, forceResendingToken){
        showDialog(
            context: context,
            barrierDismissible: false,
            builder: (context) {
              return AlertDialog(
                backgroundColor: Theme.of(context).primaryColor,
                title: Text('ادخل رمز التحقق', style: Theme.of(context).textTheme.headline4),
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: <Widget>[
                    PinPut(
                      fieldsCount: 6,
                      textStyle:
                      const TextStyle(fontSize: 25.0, color: Colors.white),
                      eachFieldWidth: 40.0,
                      eachFieldHeight: 55.0,
                      controller: controller,
                      selectedFieldDecoration: decoration(context, Theme.of(context).accentColor),
                      disabledDecoration: decoration(context, Colors.grey),
                      followingFieldDecoration: decoration(context, Theme.of(context).accentColor),
                      submittedFieldDecoration: decoration(context, Theme.of(context).accentColor),
                      pinAnimationType: PinAnimationType.fade,
                    ),
                  ],
                ),
                actions: <Widget>[
                  ElevatedButton(
                    child: Text("تأكيد", style: Theme.of(context).textTheme.headline4,),
                    style: ButtonStyle(
                        backgroundColor: MaterialStateProperty.resolveWith((states) => Theme.of(context).accentColor)
                    ),
                    onPressed: () async{
                      final code = controller.text.trim();
                      AuthCredential credential = PhoneAuthProvider.credential(verificationId: verificationId, smsCode: code);
                      UserCredential result = await _auth.signInWithCredential(credential);
                      User? user = result.user;

                      if(user != null){
                        if(isNewAccount) {
                          var u = myUser;
                          u.id = user.uid;
                          u.phone = user.phoneNumber;
                          FirestoreServices.updateUser(myUser).then((value) {
                            Navigator.pop(context);
                            Navigator.of(context).pushReplacementNamed(MainPage.routeName);
                          });
                        }else{
                          Navigator.pop(context);
                          Navigator.of(context).pushReplacementNamed(MainPage.routeName);
                        }
                      }else{
                        print("Error");
                      }
                    },
                  )
                ],
              );
            }
        );
      },
      codeAutoRetrievalTimeout: (verificationId) {},
    );
  }
}
