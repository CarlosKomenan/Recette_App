// ignore_for_file: non_constant_identifier_names

class DomaineModel {
  String? Id_domaine;
  String? Nom_domaine;
  String? Photo_domaine;

  DomaineModel({this.Id_domaine, this.Nom_domaine, this.Photo_domaine});

  //Recevoir les données du server
  factory DomaineModel.fromMap(map) {
    return DomaineModel(
      Id_domaine: map['Id_domaine'],
      Nom_domaine: map['Nom_domaine'],
      Photo_domaine: map['Photo_domaine'],
    );
  }

  //Envoyé les données vers le server
  Map<String, dynamic> toMap() {
    return {
      'Id_domaine': Id_domaine,
      'Nom_domaine': Nom_domaine,
      'Photo_domaine': Photo_domaine,
    };
  }
}
