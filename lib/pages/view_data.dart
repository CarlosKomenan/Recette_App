// ignore_for_file: unused_import, file_names, prefer_const_constructors, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field, avoid_returning_null_for_void, prefer_void_to_null, unused_local_variable, unused_element, non_constant_identifier_names, deprecated_member_use, prefer_equal_for_default_values, prefer_const_constructors_in_immutables

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'HomePage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ViewData extends StatefulWidget {
  ViewData({Key? key, required this.document, required this.id})
      : super(key: key);
  final Map<String, dynamic> document;
  final String id;

  @override
  _ViewDataState createState() => _ViewDataState();
}

class _ViewDataState extends State<ViewData> {
  TextEditingController dateinput = TextEditingController();
  // late TextEditingController _nomController;
  late TextEditingController _dateController;
  late TextEditingController _siController; //Contrôleur pour le site
  late TextEditingController _esController; //Contrôleur en espèce
  int espece_val = 0;
  int theorique_val = 0;
  bool edit = false;

  @override
  void initState() {
    // dateinput.text = ""; //set the initial value of text field
    super.initState();
    initializeDateFormatting('fr_FR', null).then((_) => ViewData(
          document: {},
          id: '',
        ));
    // Affichage du nom
    print(widget.document['Nom']);
    print(widget.document['Date']);
    // String nom = widget.document["Nom"] ?? " Non disponible";
    // _nomController = TextEditingController(text: nom);
    // Affichage de la date
    _dateController = TextEditingController(text: widget.document['Date']);
    dateinput.text = _dateController.text;
    // Affichage du montant en espèce
    String espece = widget.document['Recette espece'].toString();
    _esController = TextEditingController(text: espece);
    // Affichage du montant théorique
    String theorique = widget.document['Recette site'].toString();
    _siController = TextEditingController(text: theorique);
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
            String formattedDate_affichage =
                DateFormat.yMMMMd('fr_FR').format(choix);
            String formattedDate = DateFormat('dd-MM-yyyy').format(choix);
            print(formattedDate);
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

  // void _refresh() {
  //   setState(() {
  //     dateinput.text = "";
  //     _nomController.text = "";
  //     _siController.text = "";
  //     _esController.text = "";
  //   });
  // }

  @override
  Widget build(BuildContext context) {
    void SnackbarAsync(String text) async {
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => HomePage()));
      final snackBar = SnackBar(content: Text(text));
      ScaffoldMessenger.of(context)
        ..removeCurrentSnackBar()
        ..showSnackBar(snackBar);

      await Future.delayed(Duration(seconds: 2));
    }

    void Snackbar() {
      final snackBar = SnackBar(content: Text("Formulaire rafréchit"));
      ScaffoldMessenger.of(context).showSnackBar(snackBar);
    }

    void showToast(String text) => Fluttertoast.showToast(
          msg: "text",
          fontSize: 18,
          gravity: ToastGravity.BOTTOM,
        );

    void showToastAsync(String text) async {
      await Fluttertoast.showToast(
        msg: text,
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
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              },
            ),
            elevation: 2.0,
            backgroundColor: Colors.blue,
            centerTitle: false,
            title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => const HomePage()));
              },
              child: const Text(
                'Modification recette',
              ),
            ),
            actions: [
              Row(
                children: [
                  IconButton(
                    icon: Icon(Icons.edit,
                        color: edit ? Colors.green : Colors.white),
                    onPressed: () {
                      setState(() {
                        print(edit);
                        espece_val = int.parse(_esController.text);
                        theorique_val = int.parse(_siController.text);
                        edit = !edit;
                        print(edit);
                      });
                      FirebaseFirestore.instance
                          .collection("Recette")
                          .doc(widget.id)
                          .update({
                        "Date": dateinput.text,
                        // "Nom": _nomController.text,
                        "Recette espece": espece_val,
                        "Recette site": theorique_val,
                      });
                      print("Modifier");
                      showToastAsync("Recette modifiée avec succès");
                    },
                  ),
                  IconButton(
                    icon: Icon(Icons.delete, color: Colors.red),
                    onPressed: () {
                      setState(() {
                        espece_val = int.parse(_esController.text);
                        theorique_val = int.parse(_siController.text);
                        DialogBoiteModif(context);
                        // showToastAsync("Recette supprimée avec succès");
                      });
                    },
                  )
                ],
              )
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
                      //         "Nom enregistreur",
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
                      SizedBox(
                        height: 20,
                      ),
                      // textItem("Entrer votre nom", _nomController, false),
                      // SizedBox(
                      //   height: 20,
                      // ),
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
                              "Recette du site",
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
                      numberItem("Entrer la recette en espèce", _esController),
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
                              "Recette en espèce",
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
                      numberItem("Entrer la recette du site", _siController),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }

  void DialogBoiteModif(BuildContext context) {
    // Create a AlertDialog.
    AlertDialog dialog = AlertDialog(
      title: Text("Supprimer"),
      titleTextStyle: TextStyle(color: Colors.red, fontSize: 24),
      content: Row(children: [
        // Icon(Icons.iconAction, size: 30, color: Colors.red)
        Icon(Icons.warning, size: 30, color: Colors.red),
        SizedBox(width: 5, height: 5),
        Text("Voulez-vous supprimer?")
      ]),
      actions: [
        ElevatedButton(
            child: Text("Oui"),
            onPressed: () {
              Navigator.of(context).pop(true);
              FirebaseFirestore.instance
                  .collection("Recette")
                  .doc(widget.id)
                  .delete()
                  .then((value) {});
              print("supprimer");

              void showToastAsync(String text) async {
                await Fluttertoast.showToast(
                  msg: text,
                  fontSize: 18,
                  gravity: ToastGravity.BOTTOM,
                );
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => HomePage()));
              }

              showToastAsync("Recette supprimée avec succès");
            }),
        ElevatedButton(
            child: Text("Retour"),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false
            }),
      ],
    );

    // Call showDialog function.
    Future futureValue = showDialog(
        context: context,
        builder: (BuildContext context) {
          return dialog;
        });
    futureValue.then((value) {
      print("Return value: " + value.toString()); // true/false
    });
  }
}
