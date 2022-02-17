// ignore_for_file: unused_element, unused_import

import 'package:recette_app/model/domaine_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:firebase_core/firebase_core.dart';

AuthClass authClass = AuthClass();
final Stream<QuerySnapshot> _stream =
    FirebaseFirestore.instance.collection("Domaine").snapshots();

// Stream <List<DomaineModel>> getDomaine{
//   return Domaine.snapshots().map(DomaineModel){
//     return DomaineModel.docs
//     .map((e)=>Domaine.fromJson(e.data(),Id_domaine:e.id)).toList();
//   }
// }