// ignore_for_file: file_names, unused_import, sized_box_for_whitespace, prefer_const_constructors, prefer_const_literals_to_create_immutables, unused_local_variable, avoid_print, non_constant_identifier_names
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'dart:ui' as ui;
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/view_data.dart';

class TodoCard extends StatelessWidget {
  final Map<String, dynamic> document;
  const TodoCard({
    Key? key,
    // required this.nom,
    required this.iconData,
    required this.iconColor,
    required this.time,
    required this.iconBgColor,
    required this.espece,
    required this.theorique,
    required this.document,
  }) : super(key: key);

  // final String nom;
  final int espece;
  final int theorique;
  final IconData iconData;
  final Color iconColor;
  final String time;
  final Color iconBgColor;
  final double _borderRaduis = 24;

  @override
  Widget build(BuildContext context) {
    return Container(
      width: MediaQuery.of(context).size.width,
      child: Padding(
        padding: const EdgeInsets.all(10.0),
        child: Stack(
          children: [
            Container(
              height: 120,
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
                    flex: 2,
                  ),
                  Expanded(
                    flex: 4,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        // Row(
                        //   children: [
                        //     Icon(
                        //       Icons.account_circle_outlined,
                        //       color: Colors.white,
                        //     ),
                        //     SizedBox(
                        //       width: 8,
                        //     ),
                        //     Text(
                        //       nom,
                        //       style: TextStyle(
                        //           color: Colors.white,
                        //           fontWeight: FontWeight.w500),
                        //     ),
                        //   ],
                        // ),
                        // SizedBox(
                        //   height: 4,
                        // ),
                        Row(
                          children: [
                            Text(
                              "Date: ",
                              style: TextStyle(
                                  color: Colors.white,
                                  fontWeight: FontWeight.w500),
                            ),
                            Text(
                              time,
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
                                  espece.toString(),
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
                                  theorique.toString(),
                                  style: TextStyle(
                                    color: Colors.white,
                                    fontSize: 20,
                                    fontWeight: FontWeight.bold,
                                  ),
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
                            )
                          ],
                        )
                      ],
                    ),
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        // InkWell(
                        //     onTap: () {
                        //       DialogBoiteDetails(context, "Détails",
                        //           Icon(Icons.content_paste), "Verifier");
                        //       print("details");
                        //     },
                        //     child:
                        //         Icon(Icons.content_paste, color: Colors.white)),
                        // SizedBox(
                        //   height: 20,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       DialogBoiteModif(context, "Modification",
                        //           Icon(Icons.warning_amber), "Modifier");
                        //       print("Modifier");
                        //     },
                        //     child: Icon(Icons.create, color: Colors.white)),
                        // SizedBox(
                        //   height: 30,
                        // ),
                        // InkWell(
                        //     onTap: () {
                        //       DialogBoiteDelete(
                        //           context,
                        //           "Suppresion",
                        //           Icon(Icons.dangerous,
                        //               size: 30, color: Colors.red),
                        //           "Oui supprimer");
                        //       print("delete");
                        //     },
                        //     child: Icon(Icons.delete, color: Colors.white)),
                      ],
                    ),
                  )
                ],
              ),
            )
          ],
        ),
      ),
    );
  }

  void DialogBoiteModif(BuildContext context, String textAction,
      Icon iconAction, String textAppuyer) {
    // Create a AlertDialog.
    AlertDialog dialog = AlertDialog(
      title: Text(textAction),
      titleTextStyle: TextStyle(color: Colors.red, fontSize: 24),
      content: Row(children: [
        // Icon(Icons.iconAction, size: 30, color: Colors.red)
        iconAction,
        SizedBox(width: 5, height: 5),
        Text("Êtes vous sûrs ?")
      ]),
      actions: [
        ElevatedButton(
            child: Text(textAppuyer),
            onPressed: () {
              Navigator.of(context).pop(true);
              // Navigator.push(
              //     context,
              //     MaterialPageRoute(
              //         builder: (builder) => ViewData(
              //               document: document,
              //               id: document['index'],
              //               // snapshot.data.docs[index].id
              //             ))); // Return true
            }),
        ElevatedButton(
            child: Text("Retour"),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false
            }),
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

  void DialogBoiteDelete(BuildContext context, String textAction,
      Icon iconAction, String textAppuyer) {
    // Create a AlertDialog.
    AlertDialog dialog = AlertDialog(
      title: Text(textAction),
      titleTextStyle: TextStyle(color: Colors.red, fontSize: 24),
      content: Row(children: [
        // Icon(Icons.iconAction, size: 30, color: Colors.red)
        iconAction,
        SizedBox(width: 5, height: 5),
        Text("Êtes vous sûrs ?")
      ]),
      actions: [
        ElevatedButton(
            child: Text(textAppuyer),
            onPressed: () {
              Navigator.of(context).pop(true);
              // Return true
              showToast();
            }),
        ElevatedButton(
            child: Text("Retour"),
            onPressed: () {
              Navigator.of(context).pop(false); // Return false
            }),
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

  void showToast() => Fluttertoast.showToast(
        msg: "Element supprimé avec succès",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
      );

  // void DialogBoiteDetails(BuildContext context, String textAction,
  //     Icon iconAction, String textAppuyer) {
  //   // Create a AlertDialog.
  //   AlertDialog dialog = AlertDialog(
  //     title: Text(textAction),
  //     titleTextStyle: TextStyle(color: Colors.red, fontSize: 24),
  //     content: Row(children: [
  //       // Icon(Icons.iconAction, size: 30, color: Colors.red)
  //       iconAction,
  //       SizedBox(width: 5, height: 5),
  //       Text("Êtes vous sûrs ?")
  //     ]),
  //     actions: [
  //       ElevatedButton(
  //           child: Text(textAppuyer),
  //           onPressed: () {
  //             Navigator.of(context).pop(true);
  //             Navigator.of(context).push(MaterialPageRoute(
  //                 builder: (context) => AddTodo())); // Return true
  //           }),
  //       ElevatedButton(
  //           child: Text("Retour"),
  //           onPressed: () {
  //             Navigator.of(context).pop(false); // Return false
  //           }),
  //     ],
  //   );

  //   // Call showDialog function.
  //   Future futureValue = showDialog(
  //       context: context,
  //       builder: (BuildContext context) {
  //         return dialog;
  //       });
  //   futureValue.then((value) {
  //     print("Return value: " + value.toString()); // true/false
  //   });
  // }
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


// Row(
//                   children: [
//                     SizedBox(
//                       width: 15,
//                     ),
//                     Container(
//                       height: 33,
//                       width: 36,
//                       decoration: BoxDecoration(
//                           color: iconBgColor,
//                           borderRadius: BorderRadius.circular(8)),
//                       child: Icon(
//                         iconData,
//                         color: iconColor,
//                       ),
//                     ),
//                     SizedBox(
//                       width: 20,
//                     ),
//                     Expanded(
//                       child: Text(nom,
//                           style: TextStyle(
//                               fontSize: 18,
//                               letterSpacing: 2,
//                               fontWeight: FontWeight.w600,
//                               color: Colors.black)),
//                     ),
//                     Text(time,
//                         style: TextStyle(fontSize: 15, color: Colors.black)),
//                     SizedBox(
//                       width: 20,
//                     ),
//                   ],
//                 ),


// Expanded(
//             child: Container(
//               height: 150,
//               child: Card(
//                   margin: const EdgeInsets.fromLTRB(15, 15, 15, 0),
//                   shape: RoundedRectangleBorder(
//                       borderRadius: BorderRadius.circular(15)),
//                   color: Colors.white,
//                   child: Column(
//                     children: [
//                       Column(
//                         children: [
//                           Row(
//                             children: [
//                               Column(
//                                 mainAxisAlignment: MainAxisAlignment.center,
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Container(
//                                     margin: EdgeInsets.only(left: 20),
//                                     height: 33,
//                                     width: 36,
//                                     decoration: BoxDecoration(
//                                         color: iconBgColor,
//                                         borderRadius: BorderRadius.circular(8)),
//                                     child: Icon(
//                                       iconData,
//                                       color: iconColor,
//                                     ),
//                                   ),
//                                 ],
//                               ),
//                               SizedBox(
//                                 width: 10,
//                               ),
//                               Column(
//                                 children: [
//                                   SizedBox(
//                                     height: 20,
//                                   ),
//                                   Text(nom,
//                                       style: TextStyle(
//                                           fontSize: 18,
//                                           letterSpacing: 2,
//                                           fontWeight: FontWeight.w600,
//                                           color: Colors.black)),
//                                   Text(time,
//                                       style: TextStyle(
//                                           fontSize: 15, color: Colors.black)),
//                                 ],
//                               )
//                             ],
//                           ),
//                           SizedBox(
//                             height: 10,
//                           ),
//                           Container(
//                             margin: EdgeInsets.only(left: 1 * 5),
//                             height: 50,
//                             width: 200,
//                             color: Colors.blue,
//                             child: Column(
//                               mainAxisAlignment: MainAxisAlignment.spaceAround,
//                               children: [
//                                 Row(
//                                   children: [
//                                     Text("Espèce: "),
//                                     Text("2500000"),
//                                     Text("FCFA")
//                                   ],
//                                 ),
//                                 Row(
//                                   children: [
//                                     Text("Site: "),
//                                     Text("2500000"),
//                                     Text("FCFA")
//                                   ],
//                                 )
//                               ],
//                             ),
//                           )
//                         ],
//                       ),
//                       Column(
//                         children: [Row()],
//                       )
//                     ],
//                   )),
//             ),
//           )