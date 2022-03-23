// ignore_for_file: non_constant_identifier_names

class RecetteModel {
  // String? Id_rec;
  int? Prix;
  DateTime? Date;
  String? Id_user;
  RecetteModel({this.Prix, this.Date, this.Id_user});

  //Recevoir les données du server
  factory RecetteModel.fromMap(map) {
    return RecetteModel(
      // Id_rec: map['Id_rec'],
      Prix: map['Prix'],
      Date: map['Date'],
      Id_user: map['Id_user'],
    );
  }

  //Envoyé les données vers le server
  Map<String, dynamic> toMap() {
    return {
      // 'Id_rec': Id_rec,
      'Prix': Prix,
      'Date': Date,
      'Id_user': Id_user,
    };
  }
}
