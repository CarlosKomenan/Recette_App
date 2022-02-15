// ignore_for_file: prefer_const_constructors, unused_import

// ignore: prefer_typing_uninitialized_variables

import 'package:firebase_core/firebase_core.dart';
import 'package:flutter/material.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:recette_app/Service/Auth_service.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:recette_app/pages/PhoneAuthPage.dart';
import 'package:recette_app/pages/SignIn.dart';
import 'package:recette_app/pages/SignUpPage.dart';
import 'package:flutter/services.dart';
import 'pages/HomePage.dart';
import 'pages/SignInPage.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Firebase.initializeApp();
  // SystemChrome.setPreferredOrientations([
  //   DeviceOrientation.portraitUp,
  // ]);
  runApp(const MyApp());
}

class MyApp extends StatefulWidget {
  const MyApp({Key? key}) : super(key: key);

  @override
  _MyAppState createState() => _MyAppState();
}

class _MyAppState extends State<MyApp> {
  Widget currentPage = SignIn();
  AuthClass authClass = AuthClass();

  @override
  void initState() {
    super.initState();
    checkLogin();
  }

  void checkLogin() async {
    String? token = await authClass.getToken();
    if (token != null) {
      setState(() {
        currentPage = SignIn();
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      home: Home(),
      debugShowCheckedModeBanner: false,
    );
  }
}
