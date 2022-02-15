// ignore_for_file: file_names, unused_import, avoid_unnecessary_containers, sized_box_for_whitespace, dead_code, unused_element, unused_field, unused_local_variable, avoid_print, prefer_const_constructors, duplicate_ignore

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import 'package:firebase_auth/firebase_auth.dart' as firebase_auth;
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:recette_app/pages/SignUpPage.dart';

import 'HomePage.dart';

class SignInPage extends StatefulWidget {
  const SignInPage({Key? key}) : super(key: key);

  @override
  _SignInPageState createState() => _SignInPageState();
}

class _SignInPageState extends State<SignInPage> {
  firebase_auth.FirebaseAuth firebaseAuth = firebase_auth.FirebaseAuth.instance;
  final TextEditingController _emailController = TextEditingController();
  final TextEditingController _mdpController = TextEditingController();
  bool circular = false;
  AuthClass authClass = AuthClass();

  Widget buttonItem(
      String imagepath, String buttonName, double size, VoidCallback onTap) {
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
          try {
            firebase_auth.UserCredential userCredential =
                await firebaseAuth.signInWithEmailAndPassword(
                    email: _emailController.text,
                    password: _mdpController.text);
            setState(() {
              circular = false;
              print("Connecter");
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
                  : Text("Connexion",
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
            const Text("Connexion",
                style: TextStyle(
                    fontSize: 35,
                    color: Colors.white,
                    fontWeight: FontWeight.bold)),
            const SizedBox(
              height: 20,
            ),
            buttonItem("assets/google.svg", "Continuer avec google", 25, () {
              authClass.googleSignIn(context);
            }),
            const SizedBox(
              height: 15,
            ),
            buttonItem("assets/phone.svg", "Continuer avec votre téléphone", 30,
                () {}),
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
                Text("Vous n'avez pas de compte ? ",
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 14,
                    )),
                InkWell(
                  onTap: () {
                    Navigator.pushAndRemoveUntil(
                        context,
                        MaterialPageRoute(builder: (builder) => SignUpPage()),
                        (route) => false);
                  },
                  child: Text("Enregistrez-vous",
                      style: TextStyle(
                          color: Colors.white,
                          fontSize: 14,
                          fontWeight: FontWeight.bold)),
                ),
              ],
            ),
            const SizedBox(
              height: 10,
            ),
            const Text("Mot de passe oublié ?",
                style: TextStyle(
                    color: Colors.white,
                    fontSize: 15,
                    fontWeight: FontWeight.bold)),
          ],
        ),
      ),
    ));
  }
}
