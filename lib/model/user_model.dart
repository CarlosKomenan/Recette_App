// ignore_for_file: non_constant_identifier_names

class UserModel {
  String? uid;
  String? Email;
  String? Nom;
  String? Prenom;
  String? Contact;
  String? Id_domaine;
  String? Nom_entreprise;
  String? Photo;
  UserModel(
      {this.uid,
      this.Email,
      this.Nom,
      this.Prenom,
      this.Contact,
      this.Id_domaine,
      this.Nom_entreprise,
      this.Photo});

  //Recevoir les données du server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        Email: map['Email'],
        Nom: map['Nom'],
        Prenom: map['Prenom'],
        Contact: map['Contact'],
        Id_domaine: map['Id_domaine'],
        Nom_entreprise: map['Nom_entreprise'],
        Photo: map['Photo']);
  }

  //Envoyé les données vers le server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'Email': Email,
      'Nom': Nom,
      'Prenom': Prenom,
      'Contact': Contact,
      'Id_domaine': Id_domaine,
      'Nom_entreprise': Nom_entreprise,
      'Photo': Photo
    };
  }
}
