// ignore_for_file: file_names, prefer_const_constructors, prefer_const_literals_to_create_immutables, avoid_unnecessary_containers, sized_box_for_whitespace, unused_local_variable, unused_import, unused_field, non_constant_identifier_names, must_call_super, unnecessary_this, avoid_print, must_be_immutable, unnecessary_import

import 'package:firebase_auth/firebase_auth.dart';
import 'package:firebase_storage/firebase_storage.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'dart:io';
import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/date_symbol_data_file.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/model/user_model.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:fluttertoast/fluttertoast.dart';

class ComptePersonnel extends StatefulWidget {
  const ComptePersonnel({Key? key}) : super(key: key);

  @override
  _ComptePersonnelState createState() => _ComptePersonnelState();
}

class _ComptePersonnelState extends State<ComptePersonnel> {
  TextEditingController _nomController = TextEditingController(text: "");
  TextEditingController _prenomController = TextEditingController(text: "");
  TextEditingController _contactController = TextEditingController(text: "");
  TextEditingController _emailController = TextEditingController(text: "");
  TextEditingController _photoController = TextEditingController(text: "");
  TextEditingController _entrepriseController = TextEditingController(text: "");
  File? pickedImage;
  final _formKey = GlobalKey<FormState>();
  bool loading = false;
  // String nom_val = "COUCOU";
  // String prenom_val = "";
  // String entreprise_val = "";
  // String contact_val = "";
  // String email_val = "";
  // String photo_val = "";

  AuthClass authClass = AuthClass();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();

  @override
  void initState() {
    super.initState();
    FirebaseFirestore.instance
        .collection("Utilisateur")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {
        var nom = "${loggedInUser.Nom}";
        _nomController = TextEditingController(text: nom);
        // Affichage du prenom
        String prenom = "${loggedInUser.Prenom}";
        _prenomController = TextEditingController(text: prenom);
        // Affichage du contact
        String contact = "${loggedInUser.Contact}";
        _contactController = TextEditingController(text: contact);
        // Affichage du email
        String email = "${loggedInUser.Email}";
        _emailController = TextEditingController(text: email);
        // Affichage de la photo
        String photo = "${loggedInUser.Photo}";
        _photoController = TextEditingController(text: photo);
        // Affichage de l'entreprise
        String entreprise = "${loggedInUser.Nom_entreprise}";
        _entrepriseController = TextEditingController(text: entreprise);
      });
    });
    // String prenom_val = "";
    // String entreprise_val = "";
    // String contact_val = "";
    // String email_val = "";
    // String photo_val = "";
    // String nom = widget.document["Nom"] ?? " Non disponible";
  }

  Widget textItem(
    String labelText,
    TextEditingController controller,
  ) {
    return InkWell(
      onTap: () {},
      child: Container(
          width: MediaQuery.of(context).size.width - 70,
          height: 55,
          child: TextFormField(
            controller: controller,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(
                    fontSize: 17,
                    color: Colors.black,
                    fontWeight: FontWeight.bold),
                focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1.5, color: Colors.blue)),
                enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(15),
                    borderSide:
                        const BorderSide(width: 1, color: Colors.grey))),
          )),
    );
  }

  void imagePickerOption() {
    Get.bottomSheet(SingleChildScrollView(
      child: ClipRRect(
        borderRadius: BorderRadius.only(
            topLeft: Radius.circular(10), topRight: Radius.circular(10.0)),
        child: Container(
          color: Colors.white,
          height: 250,
          child: Padding(
            padding: EdgeInsets.all(8.0),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                Text(
                  "CHARGER L'IMAGE DEPUIS...",
                  style: TextStyle(fontWeight: FontWeight.bold),
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.camera);
                    },
                    icon: Icon(Icons.camera),
                    label: Text("CAMERA")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      pickImage(ImageSource.gallery);
                    },
                    icon: Icon(Icons.image),
                    label: Text("GALERIE")),
                SizedBox(
                  height: 10,
                ),
                ElevatedButton.icon(
                    onPressed: () {
                      Get.back();
                    },
                    icon: Icon(Icons.close),
                    label: Text("RETOUR")),
              ],
            ),
          ),
        ),
      ),
    ));
  }

  pickImage(ImageSource imageType) async {
    try {
      final photo = await ImagePicker().pickImage(source: imageType);
      if (photo == null) return;
      final tempImage = File(photo.path);
      setState(() {
        pickedImage = tempImage;
        // _photoController = pickedImage;
      });
      if (pickedImage != null) {
        loading = true;
        setState(() {});
      }
      Get.back();
    } catch (error) {
      debugPrint(error.toString());
    }
  }

  Future uploadImage({required String path}) async {
    FirebaseStorage storage = FirebaseStorage.instance;
    Reference ref = storage.ref().child(path + "/" + pickedImage.toString());
    await ref.putFile(pickedImage!);
    // UploadTask upload = ref.putFile(img!);
    String url = await ref.getDownloadURL();
    // await FirebaseFirestore.collection("Utilisateur");
    // upload.then((res) {
    //   res.ref.getDownloadURL();
    // });
    // await upload.onComplete;
    // return await ref.getDownloadURL();
  }

  @override
  Widget build(BuildContext context) {
    void showToastAsync(String text) async {
      await Fluttertoast.showToast(
        msg: text,
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    }

    return GestureDetector(
        onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
        child: Scaffold(
            appBar: AppBar(
              title: Text(
                "Détails compte",
                style: TextStyle(color: Colors.blue),
              ),
              centerTitle: true,
              backgroundColor: Colors.white,
              actions: [
                Image.asset(
                  "assets/LogoCr3.png",
                  width: 50,
                  height: 50,
                ),
                SizedBox(
                  width: 20,
                ),
              ],
              leading: IconButton(
                icon: Icon(
                  Icons.arrow_back_ios_new_outlined,
                  color: Colors.blue,
                ),
                tooltip: 'Retour Menu',
                onPressed: () {
                  Navigator.of(context)
                      .push(MaterialPageRoute(builder: (context) => Home()));
                },
              ),
            ),
            body: SafeArea(
              child: Form(
                key: _formKey,
                autovalidateMode: AutovalidateMode.disabled,
                child: SingleChildScrollView(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(
                        height: 20,
                      ),
                      Align(
                        alignment: Alignment.center,
                        child: Stack(
                          children: [
                            Container(
                                decoration: BoxDecoration(
                                    border: Border.all(
                                        color: Colors.indigo, width: 5),
                                    borderRadius:
                                        BorderRadius.all(Radius.circular(100))),
                                child: ClipOval(
                                  child: pickedImage != null
                                      ? Image.file(
                                          pickedImage!,
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        )
                                      : Image.asset(
                                          "assets/admin.png",
                                          width: 170,
                                          height: 170,
                                          fit: BoxFit.cover,
                                        ),
                                )),
                            if (loading)
                              Positioned(
                                top: 4,
                                left: 3,
                                right: 3,
                                bottom: 2,
                                child: CircularProgressIndicator(
                                  valueColor: AlwaysStoppedAnimation<Color>(
                                      Colors.white),
                                ),
                              ),
                            Positioned(
                                bottom: 0,
                                right: 5,
                                child: IconButton(
                                    onPressed: imagePickerOption,
                                    icon: Icon(
                                      Icons.add_a_photo_outlined,
                                      color: Colors.blue[300],
                                      size: 30,
                                    )))
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: 20),
                        child: Column(
                          children: [
                            textItem("Entreprise", _entrepriseController),
                            SizedBox(
                              height: 10,
                            ),
                            textItem("Nom", _nomController),
                            SizedBox(
                              height: 10,
                            ),
                            textItem("Prénom", _prenomController),
                            SizedBox(
                              height: 10,
                            ),
                            textItem("Email", _emailController),
                            SizedBox(
                              height: 10,
                            ),
                            textItem("Contact", _contactController),
                            SizedBox(
                              height: 10,
                            ),
                            SizedBox(
                              height: 10,
                            ),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Padding(
                        padding: EdgeInsets.all(20.0),
                        child: ElevatedButton.icon(
                            onPressed: () {
                              // setState(() {
                              //   nom_val = _nomController.text;
                              //   prenom_val = _prenomController.text;
                              //   entreprise_val = _entrepriseController.text;
                              //   contact_val = _contactController.text;
                              //   photo_val = _photoController.text;
                              //   email_val = _emailController.text;
                              // });
                              uploadImage(path: "images");
                              FirebaseFirestore.instance
                                  .collection("Utilisateur")
                                  .doc(user!.uid)
                                  .update({
                                "Nom": _nomController.text,
                                "Prenom": _prenomController.text,
                                "Email": _emailController.text,
                                "Contact": _contactController.text,
                                "Nom_entreprise": _entrepriseController.text,
                                "Photo": pickedImage.toString(),
                                //Partie restante
                                // "Date": dateinput.text,
                                // "Nom": _nomController.text,
                                // "Recette espece": espece_val,
                                // "Recette site": theorique_val,
                              });
                              showToastAsync(
                                  "Informations modifiées avec succès");
                            },
                            icon: Icon(Icons.add_a_photo_sharp),
                            label: Text("MODIFIER")),
                      )
                    ],
                  ),
                ),
              ),
            )));
  }
}
