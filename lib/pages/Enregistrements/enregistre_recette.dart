// ignore_for_file: unused_import, file_names, prefer_const_constructors, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field, avoid_returning_null_for_void, prefer_void_to_null, unused_local_variable, unused_element, non_constant_identifier_names, deprecated_member_use, prefer_equal_for_default_values, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/model/recette_model.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recette_app/model/user_model.dart';

import 'transition.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController dateinput = TextEditingController();
  // final TextEditingController _nomController = TextEditingController();
  final TextEditingController _prixController = TextEditingController();
  // final TextEditingController _esController = TextEditingController();
  int prix = 0;
  // int theorique_val = 0;

  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  RecetteModel recetteModel = RecetteModel();
  DateTime? maDate;
  // String contenu_champ_string = "";
  // int contenu_champ_number = 0;

  @override
  void initState() {
    super.initState();
    dateinput.text = ""; //set the initial value of text field
    maDate = DateTime.now();
    initializeDateFormatting('fr_FR', null).then((_) => AddTodo());
    FirebaseFirestore.instance
        .collection("Utilisateur")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget textItem(
      String labelText, TextEditingController controller, bool obscureText) {
    return InkWell(
      onTap: () {
        setState(() {
          // refresh_Controller.text = contenu_champ_string;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 70,
          height: 55,
          child: TextFormField(
            onChanged: (String string) {
              setState(() {
                // poids = string as double? tryParse(String string);
                // if (string.isEmpty) {
                //   contenu_champ_string = "";
                // } else {
                //   contenu_champ_string = string;
                // }
              });
            },
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
                labelText: labelText,
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

  Widget numberItem(String labelText, TextEditingController controller) {
    return InkWell(
      onTap: () {
        setState(() {});
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 70,
          height: 55,
          child: TextFormField(
            onChanged: (String string) {
              setState(() {
                // poids = string as double? tryParse(String string);
                // if (string.isEmpty) {
                //   contenu_champ_number = 0;
                // } else {
                //   contenu_champ_number = int.parse(string);
                // }
              });
            },
            keyboardType: TextInputType.number,
            controller: controller,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
                focusedBorder: OutlineInputBorder(
                  borderRadius: BorderRadius.circular(15),
                  borderSide: const BorderSide(width: 1.5, color: Colors.blue),
                ),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.grey))),
          )),
    );
  }

  Widget textDate() {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextField(
        onTap: () async {
          DateTime? choix = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime.now());

          if (choix != null) {
            // 'fr_FR' DateFormat.yMMMMd('en_US')
            String formattedDate_affichage =
                DateFormat.yMMMMd('fr_FR').format(choix);
            String formattedDate = DateFormat('dd-MM-yyyy').format(choix);
            print(formattedDate);
            setState(() {
              maDate = choix;
              // print(maDate);
              dateinput.text =
                  formattedDate_affichage; //set output date to TextField value.
            });
          } else {
            print('Date non selectionnée');
          }
        },
        readOnly: true,
        controller: dateinput,
        obscureText: false,
        style: const TextStyle(fontSize: 17, color: Colors.black),
        decoration: InputDecoration(
            labelText: 'Selectionner la date',
            labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 1.5, color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 1, color: Colors.grey))),
      ),
    );
  }

  void _refresh() {
    setState(() {
      dateinput.text = "";
      maDate = DateTime.now();
      // _nomController.text = "";
      _prixController.text = "";
      // _esController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    void SnackbarAsync() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      final snackBar =
          SnackBar(content: Text("Recette enregistrer avec succès"));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);

      await Future.delayed(Duration(seconds: 2));
    }

    void Snackbar() {
      final snackBar = SnackBar(content: Text("Formulaire rafréchit"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void showToast() => Fluttertoast.showToast(
          msg: "Formulaire rafréchit",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
        );

    void showToastAsync() async {
      await Fluttertoast.showToast(
        msg: "Recette enregistrer",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => AddTodo()));
    }

    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              tooltip: 'Retour Icon',
              onPressed: () {
                Navigator.of(context).push(
                    MaterialPageRoute(builder: (context) => Transition()));
              },
            ),
            elevation: 2.0,
            backgroundColor: Colors.blue,
            centerTitle: true,
            title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text(
                'Ma Recette',
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  setState(() {
                    // maDate = DateTime.parse(dateinput.text);
                    prix = int.parse(_prixController.text);
                    // recetteModel.Id_rec = recetteModel.Id_rec;
                    // recetteModel.Id_rec = ;
                    recetteModel.Prix = prix;
                    recetteModel.Date = maDate;
                    recetteModel.Id_user = user!.uid;
                    // theorique_val = int.parse(_siController.text);
                  });
                  FirebaseFirestore.instance.collection("Recette").add({
                    "Date": maDate,
                    "Id_user": loggedInUser.uid,
                    "Prix": prix,
                    // "Id_rec": recetteModel.Id_rec,
                  });
                  print("enregistrer");
                  showToastAsync();
                },
                child: IconButton(
                    icon: Icon(Icons.done, color: Colors.white),
                    onPressed: null),
              ),
              InkWell(
                onTap: () {
                  _refresh();
                  showToast();
                  print("rafrechis");
                },
                child: Container(
                  child: IconButton(
                      icon: Icon(Icons.refresh, color: Colors.white),
                      onPressed: null),
                ),
              ),
            ],
          ),
          body: SingleChildScrollView(
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
                              "Date du jour",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
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
                      textDate(),
                      SizedBox(
                        height: 20,
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
                              "Recette",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
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
                      numberItem(
                          "Entrer la recette en espèce", _prixController),
                      // SizedBox(
                      //   height: 20,
                      // ),
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
                      //         "Recette du site",
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
                      // numberItem("Entrer la recette du site", _siController),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
