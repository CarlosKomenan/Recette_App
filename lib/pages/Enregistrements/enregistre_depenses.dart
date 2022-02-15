// ignore_for_file: unused_import, file_names, prefer_const_constructors, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field, avoid_returning_null_for_void, prefer_void_to_null, unused_local_variable, unused_element, non_constant_identifier_names, deprecated_member_use, prefer_equal_for_default_values, unnecessary_this

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/pages/Enregistrements/enregistre_recette.dart';
import 'package:recette_app/pages/Enregistrements/transition.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recette_app/pages/model/user_model.dart';

class AddTodoD extends StatefulWidget {
  const AddTodoD({Key? key}) : super(key: key);

  @override
  _AddTodoDState createState() => _AddTodoDState();
}

class _AddTodoDState extends State<AddTodoD> {
  String dropdownvalue = 'Salaire';
  String? value;

  // List of items in our dropdown menu
  var items = [
    'Salaire',
    'Loyer',
    'Transport',
    'Farine',
    'Huile',
    'Lait',
    'Sucre',
    "Main d'oeuvre",
    'Ingrédients',
    'Bonus',
    "Carburant",
  ];

  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 17),
        ),
      );

  TextEditingController dateinput = TextEditingController();
  // final TextEditingController _nomController = TextEditingController();
  final TextEditingController _dateController = TextEditingController();
  // final TextEditingController _siController = TextEditingController();
  final TextEditingController _smeController = TextEditingController();
  int espece_val = 0;
  int theorique_val = 0;

  AuthClass authClass = AuthClass();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  // String contenu_champ_string = "";
  // int contenu_champ_number = 0;

  // @override
  // void initState() {
  //   super.initState();
  //   dateinput.text = ""; //set the initial value of text field
  //   initializeDateFormatting('fr_FR', null).then((_) => AddTodo());
  //   FirebaseFirestore.instance
  //       .collection("users")
  //       .doc(user!.uid)
  //       .get()
  //       .then((value) {
  //     this.loggedInUser = UserModel.fromMap(value.data());
  //     setState(() {});
  //   });
  // }

  // Widget textItem(
  //     String labelText, TextEditingController controller, bool obscureText) {
  //   return InkWell(
  //     onTap: () {
  //       setState(() {
  //         // refresh_Controller.text = contenu_champ_string;
  //       });
  //     },
  //     child: Container(
  //         width: MediaQuery.of(context).size.width - 70,
  //         height: 55,
  //         child: TextFormField(
  //           onChanged: (String string) {
  //             setState(() {
  //               // poids = string as double? tryParse(String string);
  //               // if (string.isEmpty) {
  //               //   contenu_champ_string = "";
  //               // } else {
  //               //   contenu_champ_string = string;
  //               // }
  //             });
  //           },
  //           controller: controller,
  //           obscureText: obscureText,
  //           style: const TextStyle(fontSize: 17, color: Colors.black),
  //           decoration: InputDecoration(
  //               labelText: labelText,
  //               labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
  //               focusedBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(15),
  //                   borderSide:
  //                       const BorderSide(width: 1.5, color: Colors.blue)),
  //               enabledBorder: OutlineInputBorder(
  //                   borderRadius: BorderRadius.circular(15),
  //                   borderSide:
  //                       const BorderSide(width: 1, color: Colors.grey))),
  //         )),
  //   );
  // }

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
            // var difference = DateTime.now();
            // print(difference);
            setState(() {
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
      // _nomController.text = "";
      // _siController.text = "";
      _smeController.text = "";
    });
  }

  @override
  Widget build(BuildContext context) {
    void SnackbarAsync() async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      final snackBar =
          SnackBar(content: Text("Dépenses enregistrer avec succès"));
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
        msg: "Dépenses enregistrer",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
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
                'Mes dépenses ',
              ),
            ),
            actions: [
              InkWell(
                onTap: () {
                  setState(() {
                    espece_val = int.parse(_smeController.text);
                    // theorique_val = int.parse(_siController.text);
                  });
                  // FirebaseFirestore.instance.collection("Recette").add({
                  //   "Date": dateinput.text,
                  //   "Id_user": loggedInUser.uid,
                  //   "Recette espece": espece_val,
                  //   "Recette site": theorique_val,
                  // });
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
                              "Type de dépenses",
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
                      Container(
                        width: MediaQuery.of(context).size.width - 70,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton<String>(
                          value: value,
                          isExpanded: true,
                          iconSize: 36,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          hint: Text(
                            "Selectionner dépense",
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value) =>
                              setState(() => this.value = value),
                        ),
                      ),
                      // Column(
                      //   mainAxisAlignment: MainAxisAlignment.center,
                      //   children: [
                      //     DropdownButton(
                      //       // Initial Value
                      //       value: dropdownvalue,

                      //       // Down Arrow Icon
                      //       icon: const Icon(Icons.keyboard_arrow_down),
                      //       elevation: 17,
                      //       style: const TextStyle(
                      //           color: Colors.deepPurple, fontSize: 17),
                      //       underline: Container(
                      //         height: 2,
                      //         color: Colors.deepPurpleAccent,
                      //       ),
                      //       // Array list of items
                      //       items: items.map((String items) {
                      //         return DropdownMenuItem(
                      //           value: items,
                      //           child: Text(items),
                      //         );
                      //       }).toList(),
                      //       // After selecting the desired option,it will
                      //       // change button value to selected value
                      //       onChanged: (String? newValue) {
                      //         setState(() {
                      //           dropdownvalue = newValue!;
                      //         });
                      //       },
                      //     ),
                      //   ],
                      // ),
                      // numberItem("Entrer la recette en espèce", _esController),
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
                              "Somme",
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
                      numberItem("Entrer la recette du site", _smeController),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
