class UserModel {
  String? uid;
  String? email;
  String? firstName;
  String? secondName;
  String? numeroTel;
  UserModel(
      {this.uid, this.email, this.firstName, this.secondName, this.numeroTel});

  //Recevoir les données du server
  factory UserModel.fromMap(map) {
    return UserModel(
        uid: map['uid'],
        email: map['email'],
        firstName: map['firstName'],
        secondName: map['secondName'],
        numeroTel: map['numeroTel']);
  }

  //Envoyé les données vers le server
  Map<String, dynamic> toMap() {
    return {
      'uid': uid,
      'email': email,
      'firstName': firstName,
      'secondName': secondName,
      'numeroTel': numeroTel
    };
  }
}
