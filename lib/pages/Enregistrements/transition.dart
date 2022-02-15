// ignore_for_file: prefer_const_constructors, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, non_constant_identifier_names, unused_import
import 'package:flutter/material.dart';
import 'package:recette_app/pages/Enregistrements/enregistre_depenses.dart';
import 'package:recette_app/pages/Enregistrements/enregistre_recette.dart';
import 'package:recette_app/pages/Home.dart';

class Transition extends StatefulWidget {
  const Transition({Key? key}) : super(key: key);

  @override
  _TransitionState createState() => _TransitionState();
}

class _TransitionState extends State<Transition> {
  Widget Enregistre_recette(String name) {
    return Material(
      elevation: 3,
      color: Colors.lightBlue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width - 70,
        onPressed: () async {
          setState(() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddTodo()));
          });
        },
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

  Widget Enregistre_depenses(String name) {
    return Material(
      elevation: 3,
      color: Colors.lightBlue,
      borderRadius: BorderRadius.circular(30),
      child: MaterialButton(
        minWidth: MediaQuery.of(context).size.width - 70,
        onPressed: () async {
          setState(() {
            Navigator.of(context)
                .push(MaterialPageRoute(builder: (context) => AddTodoD()));
          });
        },
        child: Text(
          name,
          style: TextStyle(fontWeight: FontWeight.bold, fontSize: 18),
        ),
      ),
    );
  }

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
        title: Text(
          'Faire un enregistrement',
        ),
        centerTitle: true,
      ),
      body: Center(
        child: Container(
          width: MediaQuery.of(context).size.width,
          height: MediaQuery.of(context).size.height,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Enregistre_recette("Enregistrer recette"),
              SizedBox(
                height: 50,
              ),
              Enregistre_depenses("Enregistrer dépenses")
            ],
          ),
        ),
      ),
    );
  }
}
