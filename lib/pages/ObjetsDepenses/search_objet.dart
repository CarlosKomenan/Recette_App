// ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, unused_field, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, unused_local_variable, non_constant_identifier_names, prefer_final_fields

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:flutter/material.dart';

class SearchObjet extends SearchDelegate {
  CollectionReference _collectionReference =
      FirebaseFirestore.instance.collection("ObjetDepense");

  @override
  List<Widget>? buildActions(BuildContext context) {
    return <Widget>[
      IconButton(
          onPressed: () {
            query = "";
          },
          icon: Icon(Icons.close))
    ];
  }

  @override
  Widget? buildLeading(BuildContext context) {
    return IconButton(
        onPressed: () {
          Navigator.of(context).pop();
        },
        icon: Icon(Icons.arrow_back));
  }

  @override
  Widget buildResults(BuildContext context) {
    return StreamBuilder<QuerySnapshot>(
        stream: _collectionReference.snapshots().asBroadcastStream(),
        builder: (BuildContext context, AsyncSnapshot<QuerySnapshot> snapshot) {
          if (!snapshot.hasData) {
            return Center(
              child: CircularProgressIndicator(),
            );
          } else {
            if (snapshot.data!.docs
                .where((QueryDocumentSnapshot<Object?> element) =>
                    element['Intitule']
                        .toString()
                        .toLowerCase()
                        .contains(query.toLowerCase()))
                .isEmpty) {
              return Center(
                child: Text("Aucun résulatat trouvé"),
              );
            } else {
              return ListView(children: [
                ...snapshot.data!.docs
                    .where((QueryDocumentSnapshot<Object?> element) =>
                        element['Intitule']
                            .toString()
                            .toLowerCase()
                            .contains(query.toLowerCase()))
                    .map((QueryDocumentSnapshot<Object?> data) {
                  final String Intitule = data.get('Intitule');
                  return ListTile(
                    onTap: () {},
                    title: Text(Intitule),
                    leading: CircleAvatar(
                      backgroundImage: AssetImage("assets/autre.jpg"),
                    ),
                  );
                })
              ]);
            }
          }
        });
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return Center(
      child: Text("Recherchez n’importe quoi ici"),
    );
  }
}







// // ignore_for_file: camel_case_types, prefer_const_constructors, avoid_print, unused_field, sized_box_for_whitespace, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, unused_import, unused_local_variable, non_constant_identifier_names

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:recette_app/Custom/DepenseCard.dart';
// import 'package:recette_app/Custom/DepenseCardHorizontal.dart';
// import 'package:recette_app/pages/Home.dart';
// import 'package:recette_app/pages/ObjetsDepenses/list_objets.dart';

// class search_objet extends StatefulWidget {
//   const search_objet({Key? key}) : super(key: key);
//   @override
//   State<search_objet> createState() => _search_objetState();
// }

// class _search_objetState extends State<search_objet> {
//   final Stream<QuerySnapshot> _stream = FirebaseFirestore.instance
//       .collection("ObjetDepense")
//       .orderBy("Intitule", descending: false)
//       .snapshots();

//   @override
//   Widget build(BuildContext context) {
//     return Scaffold(
//       backgroundColor: Colors.blue[50],
//       // appBar: AppBar(
//       //   elevation: 2.0,
//       //   backgroundColor: Colors.blue,
//       //   centerTitle: true,
//       //   title: InkWell(
//       //     onTap: () {
//       //       Navigator.push(
//       //           context, MaterialPageRoute(builder: (context) => Home()));
//       //     },
//       //     child: const Text(
//       //       'Recherche dépenses ',
//       //     ),
//       //   ),
//       // ),
//       body: Center(
//         child: Container(
//             height: MediaQuery.of(context).size.height - 100,
//             child: ListView(
//               children: [
//                 Padding(
//                   padding: EdgeInsets.only(bottom: 15, left: 20, right: 20),
//                   child: TextField(
//                       onChanged: (val) {
//                         // initiateState(val);
//                       },
//                       decoration: InputDecoration(
//                           prefixIcon: IconButton(
//                               color: Colors.black,
//                               iconSize: 20.0,
//                               onPressed: Navigator.of(context).pop,
//                               icon: Icon(Icons.arrow_back)),
//                           contentPadding: EdgeInsets.only(left: 25.0),
//                           hintText: 'Recherche nom dépense',
//                           border: OutlineInputBorder(
//                               borderRadius: BorderRadius.circular(4.0)))),
//                 )
//               ],
//             )),
//       ),
//     );
//   }
// }
