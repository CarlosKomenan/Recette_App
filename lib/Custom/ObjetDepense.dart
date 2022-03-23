// ignore_for_file: file_names, sized_box_for_whitespace, prefer_const_constructors, duplicate_ignore, prefer_const_literals_to_create_immutables, unused_field, non_constant_identifier_names, unnecessary_import

import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class ObjetD extends StatefulWidget {
  const ObjetD({Key? key}) : super(key: key);

  @override
  _ObjetDState createState() => _ObjetDState();
}

class _ObjetDState extends State<ObjetD> {
  var objet_list = [
    {"nom": "Salaire", "icon": "assets/company.png"},
    {"nom": "Transport", "icon": "assets/truck.png"},
    {"nom": "Loyer", "icon": "assets/mag.png"},
    {"nom": "Farine", "icon": "assets/flour.png"},
    {"nom": "Huile", "icon": "assets/huile.jpg"},
    {"nom": "Lait", "icon": "assets/lait.jpg"},
    {"nom": "Autres produits", "icon": "assets/autre.jpg"},
  ];

  // Widget buildObjet(ObjetDepense objetDepense) => ListTile(
  //       leading: Text(objetDepense.iconObjet.toString()),
  //       title: Text(objetDepense.nomObjet.toString()),
  //     );

  @override
  Widget build(BuildContext context) {
    return GridView.builder(
        itemCount: objet_list.length,
        gridDelegate:
            const SliverGridDelegateWithFixedCrossAxisCount(crossAxisCount: 3),
        itemBuilder: (BuildContext context, int index) {
          return Padding(
              padding: const EdgeInsets.all(4.0),
              child: ObjetDepense(
                iconObjet: objet_list[index]["icon"],
                nomObjet: objet_list[index]["nom"],
              ));
        });
  }
}

class ObjetDepense extends StatelessWidget {
  const ObjetDepense({
    Key? key,
    required this.iconObjet,
    required this.nomObjet,
  }) : super(key: key);

  final String? iconObjet;
  final String? nomObjet;
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 30,
      width: 50,
      // ignore: prefer_const_constructors
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: CircleAvatar(
                  backgroundImage: AssetImage(iconObjet!),
                  radius: 30,
                )),
            SizedBox(
              height: 5,
            ),
            Text(
              nomObjet!,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
