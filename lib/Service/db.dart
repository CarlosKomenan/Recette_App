// ignore_for_file: unused_element, unused_import, library_prefixes, unused_local_variable, avoid_web_libraries_in_flutter

import 'dart:html';
import 'dart:io' as io;

import 'package:firebase_storage/firebase_storage.dart';
import 'package:recette_app/model/domaine_model.dart';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:firebase_core/firebase_core.dart';
import 'package:path/path.dart' as Path;
import 'package:firebase_storage/firebase_storage.dart' as firebase_storage;

// AuthClass authClass = AuthClass();
// final Stream<QuerySnapshot> _stream =
//     FirebaseFirestore.instance.collection("Domaine").snapshots();

// Stream <List<DomaineModel>> getDomaine{
//   return Domaine.snapshots().map(DomaineModel){
//     return DomaineModel.docs
//     .map((e)=>Domaine.fromJson(e.data(),Id_domaine:e.id)).toList();
//   }
// }

// Future<String> uploadImage(File file, {required String path}) async {
//   var time = DateTime.now().toString();
//   String img = path + "_" + time;
//   try {
//     firebase_storage.Reference ref =
//         FirebaseStorage.instance.ref().child(path + "/" + img);
//     firebase_storage.UploadTask upload = ref.putFile(file);
//     await upload.onComplete;
//     return await ref.getDownloadURL();
//   } catch (e) {
//     return "null";
//   }
// }
