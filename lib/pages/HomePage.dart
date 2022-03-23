// ignore_for_file: file_names, unused_import, prefer_const_constructors, deprecated_member_use, avoid_unnecessary_containers, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, unused_field, prefer_typing_uninitialized_variables, unused_local_variable, unused_element, non_constant_identifier_names, empty_statements, avoid_print, unnecessary_null_in_if_null_operators, prefer_if_null_operators

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:recette_app/Custom/TodoCard.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/pages/DetailsPage.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:recette_app/pages/SignUpPage.dart';
import 'package:firebase_core/firebase_core.dart';

import 'view_data.dart';

class HomePage extends StatefulWidget {
  const HomePage({Key? key}) : super(key: key);

  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  AuthClass authClass = AuthClass();
  final Stream<QuerySnapshot> _stream =
      FirebaseFirestore.instance.collection("Recette").snapshots();
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
        backgroundColor: Colors.blue,
        title: Text(
          "Mes recettes",
          // style: TextStyle(fontSize: 25, color: Colors.white),
        ),
        actions: [
          Ink(
            // height: 30,
            // child: IconButton(
            //   icon: Icon(Icons.search),
            //   color: Colors.white,
            //   iconSize: 30,
            //   onPressed: () {
            //     print("Recherche");
            //   },
            // ),
            child: InkWell(
              onTap: () {
                print("search");
              },
              child: IconButton(
                icon: Icon(Icons.search),
                color: Colors.white,
                iconSize: 30,
                onPressed: () {
                  print("Recherche");
                },
              ),
            ),
          ),
          SizedBox(
            width: 20,
          )
        ],
      ),
      // bottomNavigationBar: BottomNavigationBar(
      //   backgroundColor: Colors.blue,
      //   items: [
      //     BottomNavigationBarItem(
      //         icon: InkWell(
      //           onTap: () {
      //             Navigator.push(
      //                 context, MaterialPageRoute(builder: (builder) => Home()));
      //           },
      //           child: Container(
      //               height: 52,
      //               width: 52,
      //               child: Icon(Icons.home, size: 32, color: Colors.white)),
      //         ),
      //         title: Container()),
      //     BottomNavigationBarItem(
      //         icon: InkWell(
      //           onTap: () {
      //             Navigator.push(context,
      //                 MaterialPageRoute(builder: (builder) => AddTodo()));
      //           },
      //           child: Container(
      //               height: 52,
      //               width: 52,
      //               decoration: BoxDecoration(
      //                   shape: BoxShape.circle,
      //                   gradient: LinearGradient(
      //                       colors: [Colors.blue, Colors.white])),
      //               child: Icon(Icons.add, size: 32, color: Colors.white)),
      //         ),
      //         title: Container()),
      //     BottomNavigationBarItem(
      //         icon: Icon(Icons.settings, size: 32, color: Colors.white),
      //         title: Container()),
      //   ],
      // ),
      body: Center(
        child: StreamBuilder(
            stream: _stream,
            builder: (context, snapshot) {
              if (!snapshot.hasData) {
                // return Center(child: CircularProgressIndicator());
                return Text("Aucun fichier existant");
              }
              return ListView.builder(
                  itemCount: (snapshot.data as QuerySnapshot).docs.length,
                  itemBuilder: (context, index) {
                    IconData iconData = Icons.smart_button;
                    Color iconColor = Colors.white;
                    Color iconBgColor = Colors.white;
                    Map<String, dynamic> document =
                        (snapshot.data as QuerySnapshot).docs[index].data()
                            as Map<String, dynamic>;
                    switch (document["Prix"] > 1000000) {
                      case true:
                        iconData = Icons.sentiment_very_satisfied_outlined;
                        iconColor = Colors.white;
                        iconBgColor = Colors.lightBlueAccent;
                        break;
                      default:
                        iconData = Icons.sentiment_very_dissatisfied;
                        iconColor = Colors.white;
                        iconBgColor = Colors.lightBlue;
                    }
                    ;
                    return InkWell(
                      onDoubleTap: () {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                                builder: (builder) => DetailsPage(
                                      document: document,
                                      id: (snapshot.data as QuerySnapshot)
                                          .docs[index]
                                          .id,
                                    )));
                      },
                      onLongPress: () {
                        // print("Appuyer");
                        // DialogBoiteDetails(context, "Détails",
                        //     Icon(Icons.content_paste), "Verifier");
                        // print("details");
                        AlertDialog dialog = AlertDialog(
                          title: Text("Oups !!!"),
                          titleTextStyle:
                              TextStyle(color: Colors.red, fontSize: 24),
                          content: Row(children: [
                            // Icon(Icons.iconAction, size: 30, color: Colors.red)
                            Icon(Icons.content_paste),
                            SizedBox(width: 5, height: 5),
                            Text("Que voulez-vous faire ?")
                          ]),
                          actions: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                ElevatedButton(
                                    child: Text("Modifier"),
                                    onPressed: () {
                                      Navigator.of(context).pop(true);
                                      Navigator.push(
                                          context,
                                          MaterialPageRoute(
                                              builder: (builder) => ViewData(
                                                    document: document,
                                                    id: (snapshot.data
                                                            as QuerySnapshot)
                                                        .docs[index]
                                                        .id,
                                                  ))); // Return true
                                    }),
                                // ElevatedButton(
                                //     child: Text("Supprimer"),
                                //     onPressed: () {
                                //       Navigator.of(context).pop(true);
                                //       Navigator.push(
                                //           context,
                                //           MaterialPageRoute(
                                //               builder: (builder) => ViewData(
                                //                     document: document,
                                //                     id: (snapshot.data
                                //                             as QuerySnapshot)
                                //                         .docs[index]
                                //                         .id,
                                //                   )));

                                //       // Navigator.push(
                                //       //     context,
                                //       //     MaterialPageRoute(
                                //       //         builder: (builder) => ViewData(
                                //       //               document: document,
                                //       //               id: (snapshot.data
                                //       //                       as QuerySnapshot)
                                //       //                   .docs[index]
                                //       //                   .id,
                                //       //             ))); // Return true
                                //     }),
                                ElevatedButton(
                                    child: Text("Annuler"),
                                    onPressed: () {
                                      Navigator.of(context)
                                          .pop(false); // Return false
                                    }),
                              ],
                            )
                          ],
                        );

                        // Call showDialog function.
                        Future futureValue = showDialog(
                            context: context,
                            builder: (BuildContext context) {
                              return dialog;
                            });
                        futureValue.then((value) {
                          print("Return value: " +
                              value.toString()); // true/false
                        });
                      },
                      child: TodoCard(
                        iconBgColor: iconBgColor,
                        iconColor: iconColor,
                        iconData: iconData,
                        time: "document['Date'].toString()",
                        // nom: document['Nom'] ?? "Non disponible",
                        prix: document['Prix'],
                        // theorique: document['Recette site'],
                        document: document,
                      ),
                    );
                  });
            }),
      ),
    );
  }
}

void DialogBoiteDetails(BuildContext context, String textAction,
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
            Navigator.push(
                context,
                MaterialPageRoute(
                    builder: (builder) => ViewData(
                          document: {},
                          id: '',
                        ))); // Return true
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

///For futurre use code
// ///IconButton(
//               onPressed: () async {
//                 //Ajout de context:context
//                 await authClass.signOut(context: context);
//                 Navigator.pushAndRemoveUntil(
//                     context,
//                     MaterialPageRoute(builder: (builder) => SignUpPage()),
//                     (route) => false);
//               },
//               icon: const Icon(Icons.logout))

