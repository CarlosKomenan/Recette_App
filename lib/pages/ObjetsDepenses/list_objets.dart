// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, unused_import, non_constant_identifier_names, unused_local_variable

import 'package:flutter/material.dart';
import 'package:recette_app/Custom/DepenseCard.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recette_app/Custom/TodoCard.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/pages/DetailsPage.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:recette_app/pages/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';
import '../Home.dart';
import 'package:recette_app/pages/view_data.dart';
import 'enregistrer_objet.dart';
import 'recherche_objet.dart';

class ListObjet extends StatefulWidget {
  const ListObjet({Key? key}) : super(key: key);

  @override
  _ListObjetState createState() => _ListObjetState();
}

class _ListObjetState extends State<ListObjet> {
  // AuthClass authClass = AuthClass();

  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("ObjetDepense")
      .orderBy("Date_creation", descending: true)
      .snapshots();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.blue[50],
      appBar: AppBar(
        leading: IconButton(
          icon: Icon(Icons.arrow_back_ios_new_outlined),
          tooltip: 'Retour Icon',
          onPressed: () {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => Home()));
          },
        ),
        actions: [
          Padding(
            padding: const EdgeInsets.only(right: 20),
            child: Ink(
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  Navigator.of(context).push(MaterialPageRoute(
                      builder: (context) => rechercheObjet()));
                },
              ),
            ),
          )
        ],
        elevation: 2.0,
        backgroundColor: Colors.blue,
        centerTitle: true,
        title: InkWell(
          onTap: () {
            Navigator.push(
                context, MaterialPageRoute(builder: (context) => Home()));
          },
          child: const Text(
            'Mes objets dépenses ',
          ),
        ),
      ),
      body: Center(
        child: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                return Text("Aucun fichier existant");
              }
              return GridView.builder(
                itemCount: (snapshot.data as QuerySnapshot).docs.length,
                itemBuilder: (context, index) {
                  Map<String, dynamic> document =
                      (snapshot.data as QuerySnapshot).docs[index].data()
                          as Map<String, dynamic>;
                  return Padding(
                      padding: const EdgeInsets.all(6.0),
                      child: DepenseCard(
                        // iconObjet: document[index]["icon"],
                        intitule: document["Intitule"], document: document,
                      ));
                },
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                    crossAxisCount: 3),
              );
            }),
      ),
      floatingActionButton: FloatingActionButton.extended(
        onPressed: () {
          Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AddTodoO(),
              ));
        },
        icon: Icon(Icons.library_add),
        backgroundColor: Colors.blue,
        label: Text("Nouveau"),
      ),
    );
  }
}
