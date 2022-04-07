// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, unused_field, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, unused_local_variable

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recette_app/pages/ObjetsDepenses/list_objets.dart';

class rechercheObjet extends StatefulWidget {
  const rechercheObjet({Key? key}) : super(key: key);

  @override
  State<rechercheObjet> createState() => _rechercheObjetState();
}

class _rechercheObjetState extends State<rechercheObjet> {
  final Stream<QuerySnapshot> _recherche = FirebaseFirestore.instance
      .collection("ObjetDepense")
      .orderBy("Intitule", descending: false)
      .snapshots();

  final double hauteur = 66.0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
        body: CustomScrollView(slivers: <Widget>[
      SliverAppBar(
        pinned: true,
        expandedHeight: 210.0,
        flexibleSpace: FlexibleSpaceBar(
          background: MonAppBarFlexbible(),
        ),
      ),
    ]));
  }
}

class MonAppBar extends StatelessWidget {
  const MonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Icon(
                Icons.home,
                color: Colors.white,
              ),
            ),
          )
        ]));
  }
}

class MonAppBarFlexbible extends StatelessWidget {
  const MonAppBarFlexbible({Key? key}) : super(key: key);
  final double hauteurAppBar = 66.0;

  @override
  Widget build(BuildContext context) {
    final double statusBarHeight = MediaQuery.of(context).padding.top;
    return Container(
        padding: EdgeInsets.only(top: statusBarHeight),
        height: statusBarHeight + hauteurAppBar,
        child: Column(mainAxisAlignment: MainAxisAlignment.center, children: <
            Widget>[
          Container(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
                SizedBox(
                  height: 20,
                ),
                Container(
                  child: Text("Recherche",
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontSize: 28.0)),
                ),
                Container(
                  child: Text("3 éléments",
                      style: const TextStyle(
                          color: Colors.white,
                          fontFamily: 'Poppins',
                          fontWeight: FontWeight.w800,
                          fontSize: 15.0)),
                ),
                SizedBox(
                  height: 10,
                ),
                Container(
                  width: 350,
                  child: TextFormField(
                    decoration: InputDecoration(
                        suffixIcon: Icon(Icons.search),
                        fillColor: Colors.white,
                        contentPadding: const EdgeInsets.fromLTRB(16, 0, 0, 0),
                        hintText: "Recherche",
                        border: OutlineInputBorder(
                          borderRadius: BorderRadius.circular(10),
                        )),
                  ),
                )
              ],
            ),
          ),
        ]));
  }
}
