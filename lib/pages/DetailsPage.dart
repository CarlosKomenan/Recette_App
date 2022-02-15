// ignore_for_file: unused_import, file_names, prefer_const_literals_to_create_immutables, prefer_const_constructors, avoid_print, unused_field, non_constant_identifier_names, prefer_final_fields, sized_box_for_whitespace, unused_local_variable

import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:recette_app/pages/view_data.dart';
import 'dart:ui' as ui;

class DetailsPage extends StatefulWidget {
  const DetailsPage({Key? key, required this.document, required this.id})
      : super(key: key);
  final Map<String, dynamic> document;
  final String id;
  @override
  _DetailsPageState createState() => _DetailsPageState();
}

class _DetailsPageState extends State<DetailsPage> {
  TextEditingController dateinput = TextEditingController();
  late TextEditingController _nomController;
  late TextEditingController _dateController;
  late TextEditingController _siController; //Contrôleur pour le site
  late TextEditingController _esController; //Contrôleur en espèce
  int espece_val = 0;
  int theorique_val = 0;
  bool edit = false;

  IconData iconData = Icons.not_interested;
  Color iconColor = Colors.black;
  Color iconBgColor = Colors.red;
  double _borderRaduis = 24;
  int difference = 0;

  @override
  void initState() {
    super.initState();
    String nom = widget.document["Nom"] ?? " Non disponible";
    _nomController = TextEditingController(text: nom);
    // Affichage de la date
    _dateController = TextEditingController(text: widget.document['Date']);
    dateinput.text = _dateController.text;
    // Affichage du montant en espèce
    String espece = widget.document['Recette espece'].toString();
    _esController = TextEditingController(text: espece);
    // Affichage du montant théorique
    String theorique = widget.document['Recette site'].toString();
    _siController = TextEditingController(text: theorique);

    espece_val = int.parse(_esController.text);
    theorique_val = int.parse(_siController.text);

    if (espece_val > theorique_val) {
      iconBgColor = Colors.green;
      iconData = Icons.paid_outlined;
      difference = espece_val - theorique_val;
    } else {
      iconBgColor = Colors.red;
      iconData = Icons.error_outline;
      difference = espece_val + theorique_val;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          SizedBox(height: 1),
          Container(
            width: MediaQuery.of(context).size.width,
            child: Padding(
              padding: const EdgeInsets.all(8.0),
              child: Stack(
                children: [
                  Container(
                    height: 230,
                    decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(_borderRaduis),
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
                    child: Row(
                      children: [
                        Expanded(
                          child: Container(
                            margin: EdgeInsets.fromLTRB(20, 0, 20, 0),
                            height: 50,
                            width: 50,
                            decoration: BoxDecoration(
                                color: iconBgColor,
                                borderRadius: BorderRadius.circular(8)),
                            child: Icon(
                              iconData,
                              color: iconColor,
                            ),
                          ),
                          flex: 1,
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
                                    color: Colors.white,
                                  ),
                                  SizedBox(
                                    width: 8,
                                  ),
                                  Text(
                                    _nomController.text,
                                    style: TextStyle(
                                        color: Colors.white,
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
                                    "Date: ",
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                  Text(
                                    dateinput.text,
                                    style: TextStyle(
                                        color: Colors.white,
                                        fontWeight: FontWeight.w500),
                                  ),
                                ],
                              ),
                              Divider(
                                height: 16,
                                color: Colors.white,
                              ),
                              Column(
                                children: [
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.money,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Espèce: ",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        _esController.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "FCFA",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  SizedBox(
                                    height: 10,
                                  ),

                                  Row(
                                    children: [
                                      Icon(
                                        Icons.monitor,
                                        color: Colors.white,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Logiciel: ",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                      Text(
                                        _siController.text,
                                        style: TextStyle(
                                            color: Colors.white,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "FCFA",
                                        style: TextStyle(
                                          color: Colors.white,
                                        ),
                                      ),
                                    ],
                                  ),
                                  // SizedBox(
                                  //   height: 20,
                                  // ),
                                  Divider(
                                    height: 16,
                                    color: Colors.white,
                                  ),
                                  Row(
                                    children: [
                                      Icon(
                                        Icons.paid_outlined,
                                        color: Colors.blue,
                                      ),
                                      SizedBox(
                                        width: 8,
                                      ),
                                      Text(
                                        "Différence: ",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                      Text(
                                        difference.toString(),
                                        style: TextStyle(
                                            color: Colors.blue,
                                            fontSize: 20,
                                            fontWeight: FontWeight.bold),
                                      ),
                                      SizedBox(
                                        width: 4,
                                      ),
                                      Text(
                                        "FCFA",
                                        style: TextStyle(
                                          color: Colors.blue,
                                        ),
                                      ),
                                    ],
                                  ),
                                ],
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ),
          )
        ],
      ),
    );
  }
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
