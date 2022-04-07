// ignore_for_file: file_names, unused_import, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print, non_constant_identifier_names, unused_field
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/view_data.dart';

class DepenseCard extends StatelessWidget {
  final Map<String, dynamic> document;
  const DepenseCard({
    Key? key,
    required this.document,
    required this.intitule,
  }) : super(key: key);
  final String intitule;

  @override
  Widget build(BuildContext context) {
    return Center(
      child: Padding(
        padding: EdgeInsets.all(5.0),
        child: Column(
          children: [
            Container(
                decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(8)),
                child: CircleAvatar(
                  backgroundImage: AssetImage("assets/autre.jpg"),
                  radius: 30,
                )),
            SizedBox(
              height: 10,
            ),
            Text(
              intitule,
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.bold),
            ),
          ],
        ),
      ),
    );
  }
}
