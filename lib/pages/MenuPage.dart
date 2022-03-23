// ignore_for_file: file_names, unused_import, prefer_const_constructors, sized_box_for_whitespace, prefer_final_fields, prefer_const_literals_to_create_immutables, unused_local_variable, deprecated_member_use, avoid_unnecessary_containers, unnecessary_this, non_constant_identifier_names, unnecessary_import

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/painting.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/services.dart';
import 'package:flutter/widgets.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/model/domaine_model.dart';
import 'package:recette_app/pages/DetailsPage.dart';
import 'package:recette_app/pages/Enregistrements/transition.dart';
import 'package:recette_app/pages/FlatButtonPage/DetailsComptePage.dart';
import 'package:recette_app/pages/SignIn.dart';
import 'dart:ui' as ui;

import 'HomePage.dart';
import 'ObjetsDepenses/list_objets.dart';
import 'SignUpPage.dart';
import 'package:recette_app/model/user_model.dart';

class MenuPage extends StatefulWidget {
  const MenuPage({Key? key}) : super(key: key);

  @override
  _MenuPageState createState() => _MenuPageState();
}

class _MenuPageState extends State<MenuPage> {
  double _borderRaduis = 24;
  AuthClass authClass = AuthClass();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  // DomaineModel domaineModel = DomaineModel();
  String photo_defaut = "assets/admin.png";

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Utilisateur")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  @override
  Widget build(BuildContext context) {
    Orientation orientation = MediaQuery.of(context).orientation;
    return Scaffold(
      backgroundColor: Colors.grey[100],
      body: SingleChildScrollView(
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Container(
              width: MediaQuery.of(context).size.width,
              child: Padding(
                padding: EdgeInsets.all(0.0),
                child: Stack(
                  children: [
                    Container(
                      height: 230,
                      decoration: BoxDecoration(
                          // borderRadius: BorderRadius.circular(_borderRaduis),
                          borderRadius: BorderRadius.only(
                            bottomLeft: Radius.circular(20),
                            bottomRight: Radius.circular(20),
                          ),
                          gradient: LinearGradient(
                              colors: [Colors.blue, Colors.white],
                              begin: Alignment.topLeft,
                              end: Alignment.bottomRight),
                          boxShadow: [
                            BoxShadow(
                                color: Colors.white,
                                blurRadius: 5,
                                offset: Offset(0, 3))
                          ]),
                    ),
                    Positioned(
                      right: 0,
                      bottom: 0,
                      top: 0,
                      child: CustomPaint(
                        size: Size(100, 150),
                        painter: CustomCardShapePainter(
                            _borderRaduis, Colors.white, Colors.blue),
                      ),
                    ),
                    Positioned.fill(
                        child: Card(
                      // margin: EdgeInsets.symmetric(vertical: 50, horizontal: 25),
                      margin: EdgeInsets.fromLTRB(25, 70, 25, 40),
                      color: Colors.white,
                      shadowColor: Colors.blueGrey,
                      elevation: 10,
                      shape: const RoundedRectangleBorder(
                          // side: BorderSide(color: Colors.green, width: 3),
                          borderRadius: BorderRadius.all(Radius.circular(20))),
                      child: Row(
                        children: [
                          Expanded(
                            child: Container(
                                margin: EdgeInsets.fromLTRB(10, 5, 20, 5),
                                height: 80,
                                width: 50,
                                decoration: BoxDecoration(
                                    color: Colors.white,
                                    borderRadius: BorderRadius.circular(8)),
                                child: CircleAvatar(
                                  backgroundColor: Colors.lightBlueAccent,
                                  radius: 40,
                                  child: CircleAvatar(
                                    radius: 35,
                                    backgroundColor: Colors.blueAccent[700],
                                    child: CircleAvatar(
                                      backgroundImage: AssetImage(photo_defaut),
                                      radius: 30,
                                    ),
                                  ),
                                )),
                            flex: 2,
                          ),
                          Expanded(
                            flex: 4,
                            child: Column(
                              mainAxisSize: MainAxisSize.min,
                              crossAxisAlignment: CrossAxisAlignment.start,
                              children: [
                                Row(
                                  children: [
                                    Icon(
                                      Icons.account_circle_outlined,
                                      color: Colors.black,
                                    ),
                                    SizedBox(
                                      width: 4,
                                    ),
                                    Text(
                                      "${loggedInUser.Nom} ${loggedInUser.Prenom}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontSize: 18,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${loggedInUser.Email}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                                SizedBox(
                                  height: 4,
                                ),
                                Row(
                                  children: [
                                    Text(
                                      "${loggedInUser.Contact}",
                                      style: TextStyle(
                                          color: Colors.black,
                                          fontWeight: FontWeight.w500),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ),
                        ],
                      ),
                    )),
                  ],
                ),
              ),
            ),
            Column(
              children: [
                SizedBox(
                  height: 20,
                ),
                Container(
                  height: 40,
                  margin: EdgeInsets.symmetric(horizontal: 2),
                  child: ListView(
                    scrollDirection: Axis.horizontal,
                    children: <Widget>[
                      FlatButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        icon: Icon(Icons.recent_actors),
                        label: Text("Détails compte"),
                        onPressed: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                  builder: (context) => ComptePersonnel()));
                        },
                        color: Colors.grey[300],
                        textTheme: ButtonTextTheme.normal,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        icon: Icon(Icons.power_settings_new),
                        label: Text("Déconnexion"),
                        onPressed: () {
                          logout(context);
                        },
                        color: Colors.grey[300],
                        textTheme: ButtonTextTheme.normal,
                      ),
                      SizedBox(
                        width: 10,
                      ),
                      FlatButton.icon(
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(18.0),
                        ),
                        icon: Icon(Icons.developer_mode),
                        label: Text("Développeur"),
                        onPressed: () {},
                        color: Colors.grey[300],
                        textTheme: ButtonTextTheme.normal,
                      ),
                    ],
                  ),
                ),
                Divider(
                  height: 40,
                  thickness: 1,
                  indent: 50,
                  endIndent: 50,
                ),
                Wrap(
                  spacing: 20.0,
                  runSpacing: 20.0,
                  children: [
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => Transition()));
                      },
                      child: SizedBox(
                        width: 170.0,
                        height: 120.0,
                        child: Card(
                          color: Colors.blue[300],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(12.0)),
                          child: Container(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Enregistrements",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/online-registration.png",
                                            width: 64,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ),
                      ),
                    ),
                    InkWell(
                      onTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (context) => const ListObjet()));
                      },
                      child: SizedBox(
                        width: 170.0,
                        height: 120.0,
                        child: Card(
                          color: Colors.blue[300],
                          elevation: 2.0,
                          shape: RoundedRectangleBorder(
                              borderRadius: BorderRadius.circular(8.0)),
                          child: Container(
                              child: Padding(
                                  padding: EdgeInsets.all(8.0),
                                  child: Column(
                                    children: [
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.start,
                                        children: [
                                          SizedBox(
                                            height: 10,
                                          ),
                                          Text(
                                            "Objets dépenses",
                                            style: TextStyle(
                                                color: Colors.white,
                                                fontWeight: FontWeight.bold,
                                                fontSize: 15.0),
                                          ),
                                        ],
                                      ),
                                      SizedBox(
                                        height: 10,
                                      ),
                                      Row(
                                        mainAxisAlignment:
                                            MainAxisAlignment.end,
                                        children: [
                                          Image.asset(
                                            "assets/expenses.png",
                                            width: 60,
                                            color: Colors.white,
                                          ),
                                        ],
                                      ),
                                    ],
                                  ))),
                        ),
                      ),
                    ),
                    SizedBox(
                      width: 170.0,
                      height: 120.0,
                      child: Card(
                        color: Colors.blue[300],
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Revenus semaine",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          "assets/annual.png",
                                          width: 64,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                    SizedBox(
                      width: 170.0,
                      height: 120.0,
                      child: Card(
                        color: Colors.blue[300],
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Classement",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        Text(
                                          "Dépenses ",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          "assets/financial.png",
                                          width: 50,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                    SizedBox(
                      width: 170.0,
                      height: 120.0,
                      child: Card(
                        color: Colors.blue[300],
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Analyse mensuelle",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 15.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          "assets/monitoring.png",
                                          width: 64,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                    SizedBox(
                      width: 170.0,
                      height: 120.0,
                      child: Card(
                        color: Colors.blue[300],
                        elevation: 2.0,
                        shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0)),
                        child: Container(
                            child: Padding(
                                padding: EdgeInsets.all(8.0),
                                child: Column(
                                  children: [
                                    Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.start,
                                      children: [
                                        SizedBox(
                                          height: 10,
                                        ),
                                        Text(
                                          "Plus",
                                          style: TextStyle(
                                              color: Colors.white,
                                              fontWeight: FontWeight.bold,
                                              fontSize: 16.0),
                                        ),
                                      ],
                                    ),
                                    SizedBox(
                                      height: 10,
                                    ),
                                    Row(
                                      mainAxisAlignment: MainAxisAlignment.end,
                                      children: [
                                        Image.asset(
                                          "assets/more.png",
                                          width: 64,
                                          color: Colors.white,
                                        ),
                                      ],
                                    ),
                                  ],
                                ))),
                      ),
                    ),
                  ],
                ),
              ],
            ),
            Container(
              height: 100,
              // color: Colors.black,
            )
          ],
        ),
      ),
    );
  }
}

//Déconexion
Future<void> logout(BuildContext context) async {
  await FirebaseAuth.instance.signOut();
  Navigator.of(context)
      .pushReplacement(MaterialPageRoute(builder: (context) => SignIn()));
}

class CustomCardShapePainter extends CustomPainter {
  double raduis = 0.0;
  Color startColor = Colors.black;
  Color endColor = Colors.black;

  CustomCardShapePainter(this.raduis, this.startColor, this.endColor);

  @override
  void paint(Canvas canvas, Size size) {
    var raduis = 24.0;

    var paint = Paint();
    paint.shader = ui.Gradient.linear(
        Offset(0, 0), Offset(size.width, size.height), [
      HSLColor.fromColor(startColor).withLightness(0.8).toColor(),
      endColor
    ]);

    var path = Path()
      ..moveTo(0, size.height)
      ..lineTo(size.width - raduis, size.height)
      ..quadraticBezierTo(
          size.width, size.height, size.width, size.height - raduis)
      ..lineTo(size.width, raduis)
      ..quadraticBezierTo(size.width, 0, size.width - raduis, 0)
      ..lineTo(size.width - 1.5 * raduis, 0)
      ..quadraticBezierTo(-raduis, 2 * raduis, 0, size.height)
      ..close();

    canvas.drawPath(path, paint);
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) {
    return true;
  }
}
