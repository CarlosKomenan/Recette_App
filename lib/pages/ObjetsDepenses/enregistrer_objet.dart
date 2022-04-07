// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, unused_field, unused_import, unused_local_variable, dead_code, unnecessary_this, prefer_typing_uninitialized_variables, non_constant_identifier_names, override_on_non_overriding_member, avoid_print

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recette_app/model/objetDepense_model.dart';
import 'package:recette_app/model/user_model.dart';
import 'package:recette_app/pages/Home.dart';

import 'list_objets.dart';

class AddTodoO extends StatefulWidget {
  const AddTodoO({Key? key}) : super(key: key);

  @override
  _AddTodoOState createState() => _AddTodoOState();
}

enum ButtonState { init, loading, done }

class _AddTodoOState extends State<AddTodoO> {
  ButtonState state = ButtonState.init;
  final TextEditingController _nomController = TextEditingController();
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  ObjetDepense objetDepenseModel = ObjetDepense();
  String? value;
  String? nom_depense;
  DateTime? maDateActuelle;
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 17),
        ),
      );

  @override
  void initState() {
    super.initState();
    maDateActuelle = DateTime.now();
    FirebaseFirestore.instance
        .collection("Utilisateur")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget buildSmallButton(isDone) {
    final color = isDone ? Colors.green : Colors.grey;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: isDone
            ? Icon(
                Icons.done,
                size: 40,
                color: Colors.white,
              )
            : CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  void Snackbar() {
    final snackBar = SnackBar(content: Text("Formulaire rafréchit"));
    ScaffoldMessenger.of(context).showSnackBar(snackBar);
  }

  void showToastAsync() async {
    await Fluttertoast.showToast(
      msg: "Objet de dépense enregistrer",
      fontSize: 18,
      gravity: ToastGravity.CENTER,
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ListObjet()));
  }

  void _refresh() {
    setState(() {
      _nomController.text = "";
      Snackbar();
      // _esController.text = "";
    });
  }

  Widget textItem(
      String labelText, TextEditingController controller, double hauteur) {
    return InkWell(
      onTap: () {
        setState(() {
          // refresh_Controller.text = contenu_champ_string;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 70,
          height: hauteur,
          child: TextFormField(
            autofocus: false,
            validator: (value) {
              //champ vide
              if (value!.isEmpty) {
                return "Veuillez renseigner le champ svp";
              }
              return null;
            },
            onSaved: (value) {
              controller.text = value!;
            },
            controller: controller,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
                hintText: labelText,
                labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1.5, color: Colors.blue)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.grey))),
          )),
    );
  }

  @override
  Future EnregistrerObjetDepense() async {
    if (_formKey.currentState!.validate()) {
      try {
        setState(() => state = ButtonState.loading);
        await Future.delayed(Duration(seconds: 2));
        setState(() => state = ButtonState.done);
        await Future.delayed(Duration(seconds: 2));
        setState(() => state = ButtonState.init);

        objetDepenseModel.Intitule = nom_depense;
        objetDepenseModel.Id_user = user!.uid;
        nom_depense = _nomController.text;
        FirebaseFirestore.instance.collection("ObjetDepense").add({
          "Intitule": nom_depense.toString(),
          "Id_user": loggedInUser.uid,
          "Date_creation": maDateActuelle,
        });
        showToastAsync();
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

  @override
  Widget build(BuildContext context) {
    bool isStretched = state == ButtonState.init;
    bool isDone = state == ButtonState.done;
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              tooltip: 'Retour Icon',
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListObjet()));
              },
            ),
            elevation: 2.0,
            backgroundColor: Colors.blue,
            centerTitle: false,
            title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListObjet()));
              },
              child: const Text(
                'Objet dépense ',
              ),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  EnregistrerObjetDepense();
                },
                child: isStretched
                    ? IconButton(
                        icon: Icon(Icons.done, color: Colors.white),
                        onPressed: null)
                    : buildSmallButton(isDone),
              ),
              InkWell(
                onTap: () {
                  _refresh();
                },
                child: Container(
                    child: IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: null)),
              ),
            ],
          ),
          body: SafeArea(
            child: Form(
              key: _formKey,
              autovalidateMode: AutovalidateMode.disabled,
              child: SingleChildScrollView(
                child: Container(
                  decoration: BoxDecoration(color: Colors.blue[50]),
                  width: MediaQuery.of(context).size.width,
                  height: MediaQuery.of(context).size.height,
                  child: Card(
                    margin: const EdgeInsets.fromLTRB(25, 20, 25, 200),
                    color: Colors.white,
                    shadowColor: Colors.blueGrey,
                    elevation: 3,
                    shape: const RoundedRectangleBorder(
                        // side: BorderSide(color: Colors.green, width: 3),
                        borderRadius: BorderRadius.all(Radius.circular(10))),
                    child: Center(
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.center,
                        children: [
                          SizedBox(
                            height: 30,
                          ),
                          Container(
                            child: Row(
                              children: [
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: Colors.grey,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                )),
                                Text(
                                  "Nom dépense *",
                                  style: TextStyle(
                                      fontSize: 16, color: Colors.black),
                                ),
                                Expanded(
                                    child: Container(
                                  height: 1,
                                  color: Colors.grey,
                                  margin: EdgeInsets.symmetric(horizontal: 20),
                                )),
                              ],
                            ),
                          ),
                          SizedBox(
                            height: 20,
                          ),
                          textItem("Entrer l'intitulé de la dépense",
                              _nomController, 55),
                          // textDate(),
                          SizedBox(
                            height: 20,
                          ),
                          // Container(
                          //   child: Row(
                          //     children: [
                          //       Expanded(
                          //           child: Container(
                          //         height: 1,
                          //         color: Colors.grey,
                          //         margin: EdgeInsets.symmetric(horizontal: 20),
                          //       )),
                          //       Text(
                          //         "Commentaire",
                          //         style:
                          //             TextStyle(fontSize: 16, color: Colors.black),
                          //       ),
                          //       Expanded(
                          //           child: Container(
                          //         height: 1,
                          //         color: Colors.grey,
                          //         margin: EdgeInsets.symmetric(horizontal: 20),
                          //       )),
                          //     ],
                          //   ),
                          // ),
                          // SizedBox(
                          //   height: 20,
                          // ),
                          // textItem("Entrer un commentaire s'il y a lieu",
                          //     _commentaireController, false, 100),
                        ],
                      ),
                    ),
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
