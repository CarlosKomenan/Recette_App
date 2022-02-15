// ignore_for_file: file_names, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code, unused_element, unused_field, avoid_print, non_constant_identifier_names, prefer_const_constructors, duplicate_ignore, unused_local_variable, avoid_web_libraries_in_flutter

import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:recette_app/Service/Auth_service.dart';
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:recette_app/pages/PhoneAuthPage.dart';
import 'package:recette_app/pages/SignInPage.dart';

class SignUpPage extends StatefulWidget {
  const SignUpPage({Key? key}) : super(key: key);

  @override
  _SignUpPageState createState() => _SignUpPageState();
}

class _SignUpPageState extends State<SignUpPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  Widget buttonItem(
      String imagepath, String buttonName, double size, VoidCallback onTap) {
    //VoidCallback en lieu et plave de function
    return InkWell(
        onTap: onTap,
        child: Container(
          height: 60,
          width: MediaQuery.of(context).size.width - 60,
          child: Card(
            elevation: 8,
            shape: RoundedRectangleBorder(
                borderRadius: BorderRadius.circular(15),
                side: const BorderSide(width: 1, color: Colors.grey)),
            color: Colors.black,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                SvgPicture.asset(
                  imagepath,
                  height: size,
                  width: size,
                ),
                const SizedBox(
                  width: 15,
                ),
                Text(buttonName,
                    style: const TextStyle(color: Colors.white, fontSize: 17))
              ],
            ),
          ),
        ));
  }

  Widget textItem(
      String labelText, TextEditingController controller, bool obscureText) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: MediaQuery.of(context).size.width - 70,
          height: 55,
          child: TextFormField(
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(fontSize: 17, color: Colors.white),
            decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(fontSize: 17, color: Colors.white),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1.5, color: Colors.amber)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.grey))),
          )),
    );
  }

  Widget colorButton() {
    return InkWell(
        onTap: () async {
          setState(() {
            circular = true;
          });
          try {
            firebase_auth.UserCredential userCredential =
                await firebaseAuth.createUserWithEmailAndPassword(
                    email: _emailController.text,
                    password: _mdpController.text);
            // print(userCredential.user?.email);
            setState(() {
              circular = false;
              print("Enregistrer");
            });
            Navigator.pushAndRemoveUntil(
                context,
                MaterialPageRoute(builder: (builder) => MenuPage()),
                (route) => false);
          } catch (e) {
            final snackBar = SnackBar(content: Text(e.toString()));
            ScaffoldMessenger.of(context).showSnackBar(snackBar);
            setState(() {
              circular = false;
            });
          }
        },
        child: Container(
            width: MediaQuery.of(context).size.width - 90,
            height: 60,
            decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(20),
                gradient: const LinearGradient(colors: [
                  Color(0xfffd746c),
                  Color(0xffff9068),
                  Color(0xfffd746c)
                ])),
            child: Center(
              // ignore: prefer_const_constructors
              child: circular
                  ? const CircularProgressIndicator()
                  : Text("S'enregistrer",
                      style: TextStyle(color: Colors.white, fontSize: 20)),
            )));
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: SingleChildScrollView(
      child: Container(
        height: MediaQuery.of(context).size.height,
        width: MediaQuery.of(context).size.width,
        color: Colors.black,
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            const Text("S'enregistrer",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            buttonItem("assets/google.svg", "Continuer avec google", 25,
                () async {
              await authClass.googleSignIn(context);
            }),
            const SizedBox(
              height: 15,
            ),
            buttonItem("assets/phone.svg", "Continuer avec votre téléphone", 30,
                () {
              Navigator.push(context,
                  MaterialPageRoute(builder: (builder) => PhoneAuthPage()));
            }),
            const SizedBox(
              height: 15,
            ),
            const Text("Ou",
                style: TextStyle(color: Colors.white, fontSize: 18)),
            const SizedBox(
              height: 15,
            ),
            textItem("Email", _emailController, false),
            const SizedBox(
              height: 15,
            ),
            textItem("Mot de passe", _mdpController, true),
            const SizedBox(
              height: 30,
            ),
            colorButton(),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Text("Avez-vous déja un compte ?",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => SignInPage()),
                        (route) => false);
                  },
                  child: Text("Connectez-vous",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                )
              ],
            )
          ],
        ),
      ),
    ));
  }
}
