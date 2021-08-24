import 'package:firedart/firedart.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import './pages/sign_up_screen.dart';
import './utils/helpers.dart';
import './pages/login_screen.dart';
import './pages/splash_screen.dart';
import 'pages/main_page.dart';
import 'pages/profile_screen.dart';
import 'pages/search_screen.dart';
import 'utils/constants.dart';

void main() {
  Firestore.initialize(Constants.projectId);
  runApp(const MyApp());
}

class MyApp extends StatelessWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      localizationsDelegates: const [
        GlobalCupertinoLocalizations.delegate,
        GlobalMaterialLocalizations.delegate,
        GlobalWidgetsLocalizations.delegate
      ],
      supportedLocales: const [Locale('ar')],
      locale: const Locale('ar'),
      theme: ThemeData(
        fontFamily: 'Jenine',
          primaryColor: HexColor.fromHex('23408B'),
          accentColor: HexColor.fromHex('17AF98'),
          canvasColor: HexColor.fromHex('F5F5F5'),
          textTheme: TextTheme(
            bodyText1: const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.w200),
            headline4 : const TextStyle(color: Colors.white, fontSize: 20, fontWeight: FontWeight.bold),
            bodyText2: TextStyle(color: HexColor.fromHex('17af98'), fontSize: 20, fontWeight: FontWeight.bold,
                fontStyle: FontStyle.italic),
            headline6: const TextStyle(color: Colors.white, fontSize: 40, fontWeight: FontWeight.w500),
            headline5: const TextStyle(color: Colors.white, fontSize: 25, fontWeight: FontWeight.w500),
            headline3: const TextStyle(fontSize: 50, fontWeight: FontWeight.w700),
            headline2: const TextStyle(fontSize: 35),
          ),),
      initialRoute: SplashScreen.routeName,
      routes: {
        SplashScreen.routeName: (context) => const SplashScreen(),
        LogInScreen.routeName: (context) => const LogInScreen(),
        SignUpScreen.routeName: (context) => const SignUpScreen(),
        MainPage.routeName: (context) => const MainPage(),
        SearchPage.routeName: (context) => const SearchPage(),
        ProfileScreen.routeName: (context) => const ProfileScreen(),
      },
      home: null,
    );
  }
}