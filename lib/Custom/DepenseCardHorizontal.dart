// ignore_for_file: file_names, unused_import, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print, non_constant_identifier_names, unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/ObjetsDepenses/list_objets.dart';
import 'package:recette_app/pages/ObjetsDepenses/recherche_objet.dart';
import 'package:recette_app/pages/view_data.dart';

class DepenseCardHorizontal extends StatelessWidget {
  final Map<String, dynamic> document;
  const DepenseCardHorizontal({
    Key? key,
    required this.document,
    required this.intitule,
  }) : super(key: key);
  final String intitule;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.symmetric(horizontal: 15, vertical: 0),
        child: Card(
          child: InkWell(
            onTap: () {
              DialogBoiteModif(context);
            },
            child: ListTile(
              leading: CircleAvatar(
                backgroundImage: AssetImage("assets/autre.jpg"),
              ),
              // leading: Icon(Icons.verified_user_outlined),
              title: Text(
                intitule,
                style: TextStyle(
                    fontWeight: FontWeight.bold,
                    fontSize: 15,
                    fontFamily: 'Poppins'),
              ),
              trailing: Icon(Icons.more_vert),
            ),
          ),
        ),
        // child: Row(
        //   children: [Text(intitule)],
        // )

        //   Container(
        //       decoration: BoxDecoration(
        //           color: Colors.white,
        //           borderRadius: BorderRadius.circular(8)),
        //       child: CircleAvatar(
        //         backgroundImage: AssetImage("assets/autre.jpg"),
        //         radius: 30,
        //       )),
        //   SizedBox(
        //     height: 10,
        //   ),
        //   Text(
        //     intitule,
        //     style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
        //   ),
      ),
    );
  }

  void DialogBoiteModif(BuildContext context) {
    // Create a AlertDialog.
    AlertDialog dialog = AlertDialog(
      title: Text("Oups !!!"),
      titleTextStyle: TextStyle(color: Colors.red, fontSize: 24),
      content: Row(children: [
        Icon(Icons.content_paste),
        SizedBox(width: 5, height: 5),
        Text("Voulez-vous modifier ?")
      ]),
      actions: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceAround,
          children: [
            ElevatedButton(
                child: Text("Modifier"),
                onPressed: () {
                  Navigator.of(context).pop(true);
                  // FirebaseFirestore.instance
                  //     .collection("Recette")
                  //     .doc(widget.id)
                  //     .delete()
                  //     .then((value) {});
                  // print("supprimer");
                  void showToastAsync(String text) async {
                    await Fluttertoast.showToast(
                      msg: text,
                      fontSize: 18,
                      gravity: ToastGravity.BOTTOM,
                    );
                    Navigator.of(context).push(
                        MaterialPageRoute(builder: (context) => ListObjet()));
                  }

                  showToastAsync("Dépense supprimée avec succès");
                }),
            ElevatedButton(
                child: Text("Annuler"),
                onPressed: () {
                  Navigator.of(context).pop(false); // Return false
                }),
          ],
        )
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
