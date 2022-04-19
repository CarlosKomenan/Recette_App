// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_import, unused_field, avoid_print, non_constant_identifier_names, unused_local_variable

import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_form_builder/flutter_form_builder.dart';
import 'package:flutter_spinkit/flutter_spinkit.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:form_builder_validators/form_builder_validators.dart';
import 'package:recette_app/constant.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:recette_app/pages/SignUp.dart';
import 'package:recette_app/pages/SignUpPage.dart';
import 'package:recette_app/widgets/custom_button.dart';

class SignIn extends StatefulWidget {
  const SignIn({Key? key}) : super(key: key);

  @override
  _SignInState createState() => _SignInState();
}

class _SignInState extends State<SignIn> {
  final _formKey = GlobalKey<FormState>();

  final TextEditingController emailController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final _auth = FirebaseAuth.instance;
  bool isLoading = false;

  void Connexion(String email, String password, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .signInWithEmailAndPassword(email: email, password: password)
            .then((uid) => {
                  Fluttertoast.showToast(msg: "Vous êtes connecté"),
                  // Navigator.of(context).pushReplacement(
                  //     MaterialPageRoute(builder: (context) => HomeScreen())),
                  Navigator.pushAndRemoveUntil(
                      context,
                      MaterialPageRoute(builder: (context) => Home()),
                      (route) => false)
                });
      } on FirebaseAuthException catch (e) {
        ScaffoldMessenger.of(context).showSnackBar(SnackBar(
          content: Text(e.message.toString()),
          backgroundColor: Colors.red,
        ));
      } catch (e) {
        print(e);
      }
    }
  }

  bool isObscure = true;

  @override
  Widget build(BuildContext context) {
    final loginButton = Material(
      elevation: 3,
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width - 50,
        onPressed: () async {
          if (isLoading) return;
          setState(() => isLoading = true);
          Future.delayed(Duration(seconds: 2), () {
            setState(() {
              isLoading = false;
            });
          });
          setState(() {
            Connexion(emailController.text, passwordController.text, context);
          });
        },
        child: isLoading
            ? Row(
                mainAxisAlignment: MainAxisAlignment.center,
                mainAxisSize: MainAxisSize.min,
                children: [
                  CircularProgressIndicator(
                    color: Colors.white,
                  ),
                  SizedBox(width: 25),
                  Text(
                    "Patienter svp...",
                    style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
                  )
                ],
              )
            // SpinKitCubeGrid(
            //     size: 140,
            //     color: Colors.white,
            //   )
            : Text(
                "Connexion",
                style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
              ),
      ),
    );

    return WillPopScope(
        onWillPop: _onWillPop,
        child: GestureDetector(
          onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
          child: Scaffold(
            //SafeArea rend la page dynamique, adaptative
            body: SafeArea(
                child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: Center(
                child: SingleChildScrollView(
                  child: Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Image(
                        image: AssetImage("assets/LogoCr3.png"),
                        height: 70,
                        width: 80,
                      ),
                      SizedBox(height: 10),
                      Text("Se connecter",
                          style: TextStyle(
                              fontSize: 35,
                              color: Colors.black,
                              fontWeight: FontWeight.bold)),
                      SizedBox(height: 5),
                      Text("Connectez-vous à votre compte",
                          style: TextStyle(
                            fontSize: 15,
                            color: Colors.black,
                          )),
                      SizedBox(height: 50),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          autofocus: false,
                          controller: emailController,
                          keyboardType: TextInputType.emailAddress,
                          onSaved: (value) {
                            emailController.text = value!;
                          },
                          textInputAction: TextInputAction.next,
                          validator: (value) {
                            //champ vide
                            if (value!.isEmpty) {
                              return "Veuillez renseigner le champ svp";
                            }
                            //email validation
                            if (!RegExp(
                                    "^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
                                .hasMatch(value)) {
                              return "Entrer un email valide svp";
                            }
                            return null;
                          },
                          decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: Icon(Icons.email),
                            hintText: "Entrer votre email",
                            hintStyle: kHintStyle,
                            fillColor: Colors.grey[200],
                            filled: true,
                            enabledBorder: kOutlineBorder,
                            focusedBorder: kOutlineBorder,
                            errorBorder: kOutlineErrorBorder,
                            focusedErrorBorder: kOutlineErrorBorder,
                          ),
                        ),
                      ),
                      SizedBox(height: 15),
                      SizedBox(
                        width: MediaQuery.of(context).size.width * 0.9,
                        child: TextFormField(
                          autofocus: false,
                          controller: passwordController,
                          validator: (value) {
                            RegExp regex = RegExp(
                              r'^.{6,}$',
                            );
                            //champ vide
                            if (value!.isEmpty) {
                              return "Veuillez renseigner votre mot de passe svp";
                            }
                            if (!regex.hasMatch(value)) {
                              return "Entrer un mot de passe valide (Min. 6 caractères)";
                            }
                            return null;
                          },
                          onSaved: (value) {
                            passwordController.text = value!;
                          },
                          textInputAction: TextInputAction.done,
                          obscureText: isObscure,
                          decoration: InputDecoration(
                              contentPadding: EdgeInsets.all(8),
                              prefixIcon: Icon(Icons.lock),
                              hintText: "Entrer votre mot de passe",
                              hintStyle: kHintStyle,
                              fillColor: Colors.grey[200],
                              filled: true,
                              enabledBorder: kOutlineBorder,
                              focusedBorder: kOutlineBorder,
                              errorBorder: kOutlineErrorBorder,
                              focusedErrorBorder: kOutlineErrorBorder,
                              suffixIcon: InkWell(
                                onTap: () {
                                  setState(() {
                                    isObscure = !isObscure;
                                  });
                                },
                                child: Icon(isObscure
                                    ? Icons.radio_button_off
                                    : Icons.radio_button_checked),
                              )),
                        ),
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      loginButton,
                      SizedBox(
                        height: 15,
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          Text("Vous n'avez pas de compte ? ",
                              style: TextStyle(
                                color: Colors.black,
                                fontSize: 14,
                              )),
                          InkWell(
                            onTap: () {
                              Navigator.pushAndRemoveUntil(
                                  context,
                                  MaterialPageRoute(
                                      builder: (builder) => SignUp()),
                                  (route) => false);
                            },
                            child: Text("Créer un compte",
                                style: TextStyle(
                                    color: Colors.black,
                                    fontSize: 16,
                                    fontWeight: FontWeight.bold)),
                          ),
                        ],
                      ),
                      SizedBox(
                        height: 25,
                      ),
                      Image(
                        image: AssetImage("assets/background.png"),
                        height: 200,
                        width: 230,
                      ),
                    ],
                  ),
                ),
              ),
            )),
          ),
        ));
  }

  Future<bool> _onWillPop() async {
    return (await showDialog(
            context: context,
            builder: (context) => AlertDialog(
                  title: Text("Quitter l'application"),
                  content: Row(children: [
                    Icon(Icons.warning, size: 30, color: Colors.red),
                    SizedBox(width: 15, height: 0),
                    Text("Êtes-vous sûres ??"),
                  ]),
                  actions: <Widget>[
                    TextButton(
                        onPressed: () {
                          SystemNavigator.pop();
                        },
                        child: Text(
                          "OUI",
                          style: TextStyle(color: Colors.red),
                        )),
                    TextButton(
                        onPressed: () {
                          Navigator.of(context).pop(false);
                        },
                        child: Text(
                          "NON",
                          style: TextStyle(color: Colors.black54),
                        ))
                  ],
                ))) ??
        false;
  }
}
