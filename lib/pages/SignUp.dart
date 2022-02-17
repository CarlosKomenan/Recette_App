// ignore_for_file: unused_import, file_names, unused_field, avoid_print, prefer_const_constructors, non_constant_identifier_names, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recette_app/constant.dart';
import 'package:recette_app/model/domaine_model.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:recette_app/model/user_model.dart';

import 'SignIn.dart';

class SignUp extends StatefulWidget {
  const SignUp({Key? key}) : super(key: key);

  @override
  _SignUpState createState() => _SignUpState();
}

class _SignUpState extends State<SignUp> {
  final _auth = FirebaseAuth.instance;

  //our form key
  final _formKey = GlobalKey<FormState>();

  //Editing controller
  final NomEditingController = TextEditingController();
  final PrenomEditingController = TextEditingController();
  final emailEditingController = TextEditingController();
  final ContactEditingController = TextEditingController();
  final passwordEditingController = TextEditingController();
  final confirmPasswordEditingController = TextEditingController();
  final nomEntrepriseEditingController = TextEditingController();
  final PhotoEditingController = TextEditingController();
  bool loading = false;

  void Enregistrer(String email, String password, BuildContext context) async {
    if (_formKey.currentState!.validate()) {
      try {
        await _auth
            .createUserWithEmailAndPassword(email: email, password: password)
            .then((value) => {postDetailsToFirestore()})
            .catchError((e) {
          Fluttertoast.showToast(msg: e!.messsage);
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

  postDetailsToFirestore() async {
    FirebaseFirestore firebaseFirestore = FirebaseFirestore.instance;
    User? user = _auth.currentUser;
    UserModel userModel = UserModel();
    DomaineModel domaineModel = DomaineModel();

    userModel.Email = user!.email;
    userModel.uid = user.uid;
    userModel.Nom = NomEditingController.text;
    userModel.Prenom = PrenomEditingController.text;
    userModel.Contact = ContactEditingController.text;
    userModel.Photo = "NONE";
    userModel.Nom_entreprise = "NONE";
    userModel.Id_domaine = domaineModel.Id_domaine;

    await firebaseFirestore
        .collection("Utilisateur")
        .doc(user.uid)
        .set(userModel.toMap());
    Fluttertoast.showToast(msg: "Compte créer avec succès");

    Navigator.pushAndRemoveUntil(context,
        MaterialPageRoute(builder: (context) => MenuPage()), (route) => false);
  }

  bool isObscure = true;
  bool isObscure2 = true;

  @override
  Widget build(BuildContext context) {
    final Btn_enregistrer = Material(
      elevation: 3,
      color: Colors.blue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width - 70,
        onPressed: () async {
          Enregistrer(emailEditingController.text,
              passwordEditingController.text, context);
        },
        child: Text(
          "Enregistrer",
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );

    return GestureDetector(
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
                    Text("S'enregistrer",
                        style: TextStyle(
                            fontSize: 35,
                            color: Colors.black,
                            fontWeight: FontWeight.bold)),
                    SizedBox(height: 5),
                    Text("Créer un nouveau compte",
                        style: TextStyle(
                          fontSize: 15,
                          color: Colors.black,
                        )),
                    SizedBox(height: 30),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: NomEditingController,
                        validator: (value) {
                          //champ vide
                          if (value!.isEmpty) {
                            return "Veuillez renseigner ce champ svp";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          NomEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          prefixIcon: Icon(Icons.account_circle),
                          hintText: "Entrer votre nom",
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
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: PrenomEditingController,
                        validator: (value) {
                          //champ vide
                          if (value!.isEmpty) {
                            return "Veuillez renseigner ce champ svp";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          PrenomEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          prefixIcon: Icon(Icons.account_circle_outlined),
                          hintText: "Entrer votre prenom",
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
                        keyboardType: TextInputType.text,
                        textInputAction: TextInputAction.next,
                        controller: nomEntrepriseEditingController,
                        validator: (value) {
                          //champ vide
                          if (value!.isEmpty) {
                            return "Veuillez renseigner ce champ svp";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          nomEntrepriseEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          prefixIcon: Icon(Icons.business),
                          hintText: "Entrer le nom de votre entreprise",
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
                        controller: emailEditingController,
                        keyboardType: TextInputType.emailAddress,
                        onSaved: (value) {
                          emailEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.next,
                        validator: (value) {
                          //champ vide
                          if (value!.isEmpty) {
                            return "Veuillez renseigner ce champ svp";
                          }
                          //email validation
                          if (!RegExp("^[a-zA-Z0-9+_.-]+@[a-zA-Z0-9.-]+.[a-z]")
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
                        keyboardType: TextInputType.number,
                        textInputAction: TextInputAction.next,
                        controller: ContactEditingController,
                        validator: (value) {
                          RegExp regex = RegExp(
                            r'^.{10,}$',
                          );
                          //champ vide
                          if (value!.isEmpty) {
                            return "Veuillez entrer votre numéro de téléphone svp";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Entrer un numéro valide (10 chiffres)";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          ContactEditingController.text = value!;
                        },
                        decoration: InputDecoration(
                          contentPadding: EdgeInsets.all(8),
                          prefixIcon: Icon(Icons.phone),
                          hintText: "Entrer votre numéro de téléphone",
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
                        keyboardType: TextInputType.text,
                        controller: passwordEditingController,
                        validator: (value) {
                          RegExp regex = RegExp(
                            r'^.{6,}$',
                          );
                          //champ vide
                          if (value!.isEmpty) {
                            return "Veuillez renseigner votre mot de passe svp";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Entrer un mot de passe valide (Minimum 6 caractères)";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          passwordEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText: isObscure,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: Icon(Icons.lock_outline),
                            hintText: "Entrer un mot de passe",
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
                    SizedBox(height: 15),
                    SizedBox(
                      width: MediaQuery.of(context).size.width * 0.9,
                      child: TextFormField(
                        autofocus: false,
                        keyboardType: TextInputType.text,
                        controller: confirmPasswordEditingController,
                        validator: (value) {
                          RegExp regex = RegExp(
                            r'^.{6,}$',
                          );
                          //champ vide
                          if (value!.isEmpty) {
                            return "Veuillez confirmer votre mot de passe svp";
                          }
                          if (!regex.hasMatch(value)) {
                            return "Entrer un mot de passe valide (Min. 6 caractères)";
                          }
                          if (confirmPasswordEditingController.text !=
                              passwordEditingController.text) {
                            return "Le mot de passe ne correspond pas";
                          }
                          return null;
                        },
                        onSaved: (value) {
                          confirmPasswordEditingController.text = value!;
                        },
                        textInputAction: TextInputAction.done,
                        obscureText: isObscure2,
                        decoration: InputDecoration(
                            contentPadding: EdgeInsets.all(8),
                            prefixIcon: Icon(Icons.lock),
                            hintText: "Confirmer votre mot de passe",
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
                                  isObscure2 = !isObscure2;
                                });
                              },
                              child: Icon(isObscure2
                                  ? Icons.radio_button_off
                                  : Icons.radio_button_checked),
                            )),
                      ),
                    ),
                    SizedBox(
                      height: 25,
                    ),
                    Btn_enregistrer,
                    SizedBox(
                      height: 15,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        Text("Vous avez déjà un compte ? ",
                            style: TextStyle(
                              color: Colors.black,
                              fontSize: 14,
                            )),
                        InkWell(
                          onTap: () {
                            Navigator.pushAndRemoveUntil(
                                context,
                                MaterialPageRoute(
                                    builder: (builder) => SignIn()),
                                (route) => false);
                          },
                          child: Text("Se connecter",
                              style: TextStyle(
                                  color: Colors.black,
                                  fontSize: 16,
                                  fontWeight: FontWeight.bold)),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
            ),
          )),
        ));
  }
}
