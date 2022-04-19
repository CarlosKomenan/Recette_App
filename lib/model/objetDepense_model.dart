// ignore_for_file: unused_import, file_names, non_constant_identifier_names

import 'package:flutter/material.dart';

class ObjetDepense {
  String? Intitule;
  String? Id_user;
  DateTime? Date_creation;
  String? PremiereLettreIntitule;
  ObjetDepense(
      {this.Intitule,
      this.Id_user,
      Date_creation,
      this.PremiereLettreIntitule});

  //Recevoir les données du server
  factory ObjetDepense.fromMap(map) {
    return ObjetDepense(
        Intitule: map['Intitule'],
        Id_user: map['Id_user'],
        Date_creation: map['Date_creation'],
        PremiereLettreIntitule: map['PremiereLettreIntitule']);
  }

  //Envoyé les données vers le server
  Map<String, dynamic> toMap() {
    return {
      'Intitule': Intitule,
      'Id_user': Id_user,
      'Date_creation': Date_creation,
      'PremiereLettreIntitule': PremiereLettreIntitule
    };
  }
}
