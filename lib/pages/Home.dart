// ignore_for_file: file_names, unused_import, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, prefer_const_literals_to_create_immutables, unused_local_variable, deprecated_member_use, avoid_unnecessary_containers, avoid_print, unnecessary_this, unused_field, non_constant_identifier_names

import 'package:bottom_navy_bar/bottom_navy_bar.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:curved_navigation_bar/curved_navigation_bar.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:recette_app/pages/DetailsPage.dart';
import 'package:recette_app/pages/Enregistrements/enregistre_recette.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:recette_app/pages/SignIn.dart';
import 'dart:ui' as ui;

import 'HomePage.dart';
import 'SignUpPage.dart';
import 'model/user_model.dart';

class Home extends StatefulWidget {
  const Home({Key? key}) : super(key: key);

  @override
  _HomeState createState() => _HomeState();
}

class _HomeState extends State<Home> {
  int index = 0;

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    bodySelection() {
      switch (index) {
        case 0:
          return MenuPage();
        case 1:
          return AddTodo();
        case 2:
          return HomePage();
      }
    }

    customBottomNavigationBar() {
      return CurvedNavigationBar(
          backgroundColor: Colors.transparent,
          color: Colors.lightBlue,
          height: 60,
          animationCurve: Curves.easeInOut,
          items: <Widget>[
            Icon(
              Icons.home,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.supervised_user_circle_rounded,
              size: 30,
              color: Colors.white,
            ),
            Icon(
              Icons.analytics_outlined,
              size: 30,
              color: Colors.white,
            ),
          ],
          onTap: (index) => setState(() => this.index = index));
    }

    return Scaffold(
      extendBody: true,
      backgroundColor: Colors.grey[100],
      body: Container(
        child: bodySelection(),
      ),
      bottomNavigationBar: customBottomNavigationBar(),
    );
  }
}
