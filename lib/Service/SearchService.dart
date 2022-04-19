// ignore_for_file: unused_import, file_names

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recette_app/model/objetDepense_model.dart';
import 'package:recette_app/model/user_model.dart';
import 'package:recette_app/pages/Home.dart';

class SearchService {
  searchByName(String searchField) {
    return FirebaseFirestore.instance
        .collection('ObjetDepense')
        .where('PremiereLettreIntitule',
            isEqualTo: searchField.substring(0, 1).toUpperCase())
        .get();
  }
}
