// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, unused_field, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, unused_local_variable, non_constant_identifier_names, prefer_is_empty

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:recette_app/Custom/DepenseCard.dart';
import 'package:recette_app/Custom/DepenseCardHorizontal.dart';
import 'package:recette_app/Service/SearchService.dart';
import 'package:recette_app/pages/ObjetsDepenses/list_objets.dart';

class rechercheObjet extends StatefulWidget {
  const rechercheObjet({Key? key}) : super(key: key);

  @override
  State<rechercheObjet> createState() => _rechercheObjetState();
}

class _rechercheObjetState extends State<rechercheObjet> {
  final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
      .collection("ObjetDepense")
      .orderBy("Intitule", descending: false)
      .snapshots();

  // bool clicsearch = false;
  // var queryResultSet = [];
  // var tempSearchStore = [];

  // initiateSearch(value) {
  //   if (value.length == 0) {
  //     setState(() {
  //       var queryResultSet = [];
  //       var tempSearchStore = [];
  //     });
  //   }
  //   var capitalizedValue =
  //       value.substring(0, 1).toUpperCase() + value.substring(1);
  //   if (queryResultSet.length == 0 && value.length == 1) {
  //     SearchService().searchByName(value).then((QuerySnapshot docs) {
  //       for (int i = 0; i < docs.documents.length; i++) {
  //         queryResultSet.add(docs.documents[i].data);
  //       }
  //     });
  //   }
  // }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: CustomScrollView(slivers: <Widget>[
        SliverAppBar(
          pinned: true,
          title: MonAppBar(),

          expandedHeight:
              210.0, //Le problème peut venir de là, etude de la fonction SliverAppBar ou ajouter un scrollDirection à ListView

          flexibleSpace: FlexibleSpaceBar(
            background: MonAppBarFlexbible(),
          ),
        ),
        // clicsearch
        //     ?
        SliverList(
          delegate: SliverChildListDelegate(<Widget>[
            Container(
              height: MediaQuery.of(context).size.height - 300,
              child: StreamBuilder(
                  stream: _stream,
                  builder: (context, snapshot) {
                    if (!snapshot.hasData) {
                      return Center(child: Text("Aucun fichier existant"));
                    }
                    return Center(
                      child: SizedBox(
                        child: ListView.builder(
                          shrinkWrap:
                              true, //Ce paramètre peut créer un bug lié à la heuteur du ListView non précisé
                          itemCount:
                              (snapshot.data as QuerySnapshot).docs.length,
                          itemBuilder: (context, index) {
                            Map<String, dynamic> document =
                                (snapshot.data as QuerySnapshot)
                                    .docs[index]
                                    .data() as Map<String, dynamic>;
                            return Padding(
                                padding: EdgeInsets.all(6.0),
                                child: DepenseCardHorizontal(
                                  // iconObjet: document[index]["icon"],
                                  intitule: document["Intitule"],
                                  document: document,
                                ));
                          },
                        ),
                      ),
                    );
                  }),
            ),
            SizedBox(
              height: 20,
            )
          ]),
        )
        //     :
        // SliverList(
        //   delegate: SliverChildListDelegate(<Widget>[
        //     Container(
        //         height: MediaQuery.of(context).size.height - 300,
        //         child: ListView(
        //           children: [
        //             Padding(
        //               padding: EdgeInsets.only(bottom: 5, left: 20, right: 20),
        //               child: TextField(
        //                   onChanged: (val) {
        //                     initiateSearch(val);
        //                   },
        //                   decoration: InputDecoration(
        //                       prefixIcon: IconButton(
        //                           color: Colors.black,
        //                           iconSize: 20.0,
        //                           onPressed: Navigator.of(context).pop,
        //                           icon: Icon(Icons.arrow_back)),
        //                       contentPadding: EdgeInsets.only(left: 25.0),
        //                       hintText: 'Recherche nom dépense',
        //                       border: OutlineInputBorder(
        //                           borderRadius: BorderRadius.circular(4.0)))),
        //             )
        //           ],
        //         )),
        // Container(
        //   height: MediaQuery.of(context).size.height - 300,
        //   child: StreamBuilder(
        //       stream: _stream,
        //       builder: (context, snapshot) {
        //         if (!snapshot.hasData) {
        //           return Center(child: Text("Aucun fichier existant"));
        //         }
        //         return Center(
        //           child: SizedBox(
        //             child: ListView.builder(
        //               shrinkWrap:
        //                   true, //Ce paramètre peut créer un bug lié à la heuteur du ListView non précisé
        //               itemCount:
        //                   (snapshot.data as QuerySnapshot).docs.length,
        //               itemBuilder: (context, index) {
        //                 Map<String, dynamic> document =
        //                     (snapshot.data as QuerySnapshot)
        //                         .docs[index]
        //                         .data() as Map<String, dynamic>;
        //                 return Padding(
        //                     padding: EdgeInsets.all(6.0),
        //                     child: DepenseCardHorizontal(
        //                       // iconObjet: document[index]["icon"],
        //                       intitule: document["Intitule"],
        //                       document: document,
        //                     ));
        //               },
        //             ),
        //           ),
        //         );
        //       }),
        // ),
      ]),
    );
  }
}

class MonAppBar extends StatelessWidget {
  const MonAppBar({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
        // height: 66.0,
        child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: <Widget>[
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: Text(
                'Mes objets dépenses',
                style: TextStyle(
                    color: Colors.white, fontFamily: 'Poppins', fontSize: 20.0),
              ),
            ),
          ),
          Container(
            child: Padding(
              padding: const EdgeInsets.all(16.0),
              child: InkWell(
                  child: Icon(
                Icons.search,
                color: Colors.white,
              )),
            ),
          ),
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
        child: Center(
          child: Column(
              mainAxisAlignment: MainAxisAlignment.center,
              children: <Widget>[
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
                      SizedBox(
                        height: 15,
                      ),
                      // Container(
                      //   width: 350,
                      //   child: TextFormField(
                      //     decoration: InputDecoration(
                      //         suffixIcon: Icon(Icons.search),
                      //         contentPadding:
                      //             const EdgeInsets.fromLTRB(16, 0, 0, 0),
                      //         hintText: "Recherche",
                      //         border: OutlineInputBorder(
                      //           borderRadius: BorderRadius.circular(10),
                      //         )),
                      //   ),
                      // )
                    ],
                  ),
                ),
              ]),
        ));
  }
}
