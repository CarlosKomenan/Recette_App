// ignore_for_file: prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_print, avoid_unnecessary_containers, unused_import

import 'package:flutter/material.dart';
import 'package:recette_app/Custom/ObjetDepense.dart';

import '../Home.dart';
import 'enregistrer_objet.dart';

class ListObjet extends StatefulWidget {
  const ListObjet({Key? key}) : super(key: key);

  @override
  _ListObjetState createState() => _ListObjetState();
}

class _ListObjetState extends State<ListObjet> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
              // height: 30,
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  print("Recherche");
                },
              ),
              // decoration:
              //     ShapeDecoration(color: Colors.grey[300], shape: CircleBorder()),
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
      body: Column(
        children: [
          SizedBox(
            height: 20,
          ),
          Flexible(child: ObjetD()),
        ],
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
