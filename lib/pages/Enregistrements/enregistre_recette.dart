// ignore_for_file: unused_import, file_names, prefer_const_constructors, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field, avoid_returning_null_for_void, prefer_void_to_null, unused_local_variable, unused_element, non_constant_identifier_names, deprecated_member_use, prefer_equal_for_default_values, unnecessary_this, unnecessary_import, import_of_legacy_library_into_null_safe

import 'package:cloud_firestore/cloud_firestore.dart';
import 'package:firebase_auth/firebase_auth.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';
import 'package:intl/intl.dart';
import 'package:recette_app/Service/Auth_Service.dart';
import 'package:recette_app/model/recette_model.dart';
import 'package:recette_app/pages/Home.dart';
import 'package:recette_app/pages/HomePage.dart';
import 'package:recette_app/pages/MenuPage.dart';
import 'package:intl/date_symbol_data_local.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recette_app/model/user_model.dart';

class AddTodo extends StatefulWidget {
  const AddTodo({Key? key}) : super(key: key);

  @override
  _AddTodoState createState() => _AddTodoState();
}

class _AddTodoState extends State<AddTodo> {
  TextEditingController dateinput = TextEditingController();
  final TextEditingController _montantController = TextEditingController();
  int prix = 0;
  final _formKey = GlobalKey<FormState>();
  User? user = FirebaseAuth.instance.currentUser;
  UserModel loggedInUser = UserModel();
  RecetteModel recetteModel = RecetteModel();
  DateTime? maDate;
  String today = "Aujourd'hui";

  @override
  void initState() {
    super.initState();
    initializeDateFormatting('fr_FR', null).then((_) => AddTodo());
    maDate = DateTime.now();
    dateinput.text = maDate.toString(); //set the initial value of text field
    dateinput.text = today;

    FirebaseFirestore.instance
        .collection("Utilisateur")
        .doc(user!.uid)
        .get()
        .then((value) {
      this.loggedInUser = UserModel.fromMap(value.data());
      setState(() {});
    });
  }

  Widget numberItem(TextEditingController controller) {
    return InkWell(
      child: Container(
          width: MediaQuery.of(context).size.width - 180,
          height: 55,
          child: TextFormField(
            textAlign: TextAlign.end,
            autofocus: true,
            keyboardType: TextInputType.number,
            controller: controller,
            validator: (value) {
              //champ vide
              if (value!.isEmpty) {
                return "Entrer le montant";
              }
              return null;
            },
            onSaved: (value) {
              controller.text = value!;
            },
            style: TextStyle(
              letterSpacing: 3.0,
              fontSize: 30,
              color: Colors.black,
            ),
            decoration: InputDecoration(
              isDense: true,
              hintText: "",
              labelStyle: TextStyle(
                fontSize: 15,
                color: Colors.black,
              ),
            ),
          )),
    );
  }

  Widget textDate() {
    return Container(
      width: MediaQuery.of(context).size.width - 70,
      height: 55,
      child: TextFormField(
        onTap: () async {
          DateTime? choix = await showDatePicker(
              context: context,
              initialDate: DateTime.now(),
              firstDate: DateTime(2021),
              lastDate: DateTime.now());

          if (choix != null) {
            // 'fr_FR' DateFormat.yMMMMd('en_US')
            String formattedDate_affichage =
                DateFormat.yMMMMd('fr_FR').format(choix);
            String formattedDate = DateFormat('dd-MM-yyyy').format(choix);

            setState(() {
              maDate = choix;
              // print(maDate);
              dateinput.text =
                  formattedDate_affichage; //set output date to TextField value.
            });
          } else {
            print('Date non selectionnée');
          }
        },
        autofocus: false,
        readOnly: true,
        controller: dateinput,
        validator: (value) {
          //champ vide
          if (value!.isEmpty) {
            return "Selectionner la date";
          }
          return null;
        },
        onSaved: (value) {
          dateinput.text = value!;
        },
        obscureText: false,
        style: const TextStyle(fontSize: 17, color: Colors.black),
        decoration: InputDecoration(
            hintText: "Selectionner la date",
            labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
            focusedBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 1.5, color: Colors.blue)),
            enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(15),
                borderSide: const BorderSide(width: 1, color: Colors.grey))),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    void showToastAsync() async {
      await Fluttertoast.showToast(
        msg: "Recette enregistrer",
        fontSize: 18,
        gravity: ToastGravity.BOTTOM,
      );
      Navigator.of(context)
          .push(MaterialPageRoute(builder: (context) => Home()));
    }

    Future EnregistrerRecette() async {
      if (_formKey.currentState!.validate()) {
        try {
          prix = int.parse(_montantController.text);
          recetteModel.Prix = prix;
          recetteModel.Date = maDate;
          recetteModel.Id_user = user!.uid;
          FirebaseFirestore.instance.collection("Recette").add({
            "Date": maDate,
            "Id_user": loggedInUser.uid,
            "Prix": prix,
            // "Id_rec": recetteModel.Id_rec,
          });
          showToastAsync();
        } on FirebaseAuthException catch (e) {
          ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            content: Text(e.message.toString()),
            backgroundColor: Colors.red,
          ));
        } catch (e) {
          print(e);
        }
      }
    }

    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
          body: SafeArea(
        child: Form(
          key: _formKey,
          autovalidateMode: AutovalidateMode.disabled,
          child: SingleChildScrollView(
            child: Column(children: [
              Container(
                height: MediaQuery.of(context).size.height * 0.15,
                color: Colors.blue[50],
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    Container(
                        margin: EdgeInsets.only(
                          top: 35,
                        ),
                        width: 35,
                        height: 35,
                        child: InkWell(
                          onTap: () {
                            Navigator.of(context).push(MaterialPageRoute(
                                builder: (context) => Home()));
                          },
                          child: Icon(
                            Icons.arrow_back_ios_rounded,
                            color: Colors.blue,
                            size: 30,
                          ),
                        )),
                    Container(
                        alignment: Alignment.center,
                        margin: EdgeInsets.only(
                          top: 60,
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            CircleAvatar(
                              backgroundColor: Colors.white,
                              child: Icon(
                                FontAwesomeIcons.coins,
                                size: 25,
                              ),
                            ),
                            Text(
                              "Nouvelle Recette",
                              style: TextStyle(
                                color: Colors.grey,
                                fontSize: 18,
                              ),
                            ),
                          ],
                        )),
                    Container(
                      margin: EdgeInsets.only(top: 30, right: 10),
                      width: 35,
                      height: 35,
                    )
                  ],
                ),
              ),
              Container(
                color: Colors.blue[50],
                // color: Colors.red,
                height: MediaQuery.of(context).size.height,
                padding: EdgeInsets.only(top: 30, left: 30, right: 30),
                child: Column(
                  children: [
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Date",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    textDate(),
                    SizedBox(
                      height: 20,
                    ),
                    Container(
                      child: Row(
                        children: [
                          Text(
                            "Montant",
                            style: TextStyle(
                                fontSize: 16,
                                color: Colors.grey,
                                fontWeight: FontWeight.w500),
                          ),
                        ],
                      ),
                    ),
                    SizedBox(
                      height: 10,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        numberItem(_montantController),
                        SizedBox(
                          width: 5,
                        ),
                        Text(
                          "F CFA",
                          style: TextStyle(color: Colors.grey, fontSize: 30),
                        )
                      ],
                    ),
                    SizedBox(
                      height: 50,
                    ),
                    GestureDetector(
                      onTap: EnregistrerRecette,
                      child: Container(
                        alignment: Alignment.bottomCenter,
                        height: 50,
                        width: MediaQuery.of(context).size.width - 120,
                        decoration: BoxDecoration(
                          borderRadius: BorderRadius.circular(15),
                          color: Colors.blue,
                        ),
                        child: Center(
                          child: Text(
                            "ENREGISTRER",
                            style: TextStyle(
                                color: Colors.white,
                                fontSize: 18,
                                fontWeight: FontWeight.w600),
                          ),
                        ),
                      ),
                    )
                  ],
                ),
              )
            ]),
          ),
        ),
      )),
    );
  }
}




// // ignore_for_file: unused_import, file_names, prefer_const_constructors, avoid_print, sized_box_for_whitespace, avoid_unnecessary_containers, prefer_const_literals_to_create_immutables, unused_field, avoid_returning_null_for_void, prefer_void_to_null, unused_local_variable, unused_element, non_constant_identifier_names, deprecated_member_use, prefer_equal_for_default_values, unnecessary_this

// import 'package:cloud_firestore/cloud_firestore.dart';
// import 'package:firebase_auth/firebase_auth.dart';
// import 'package:flutter/material.dart';
// import 'package:intl/intl.dart';
// import 'package:recette_app/Service/Auth_Service.dart';
// import 'package:recette_app/model/recette_model.dart';
// import 'package:recette_app/pages/Home.dart';
// import 'package:recette_app/pages/HomePage.dart';
// import 'package:recette_app/pages/MenuPage.dart';
// import 'package:intl/date_symbol_data_local.dart';
// import 'package:fluttertoast/fluttertoast.dart';
// import 'package:recette_app/model/user_model.dart';

// import 'transition.dart';

// class AddTodo extends StatefulWidget {
//   const AddTodo({Key? key}) : super(key: key);

//   @override
//   _AddTodoState createState() => _AddTodoState();
// }

// enum ButtonState { init, loading, done }

// class _AddTodoState extends State<AddTodo> {
//   TextEditingController dateinput = TextEditingController();
//   // final TextEditingController _nomController = TextEditingController();
//   final TextEditingController _prixController = TextEditingController();
//   // final TextEditingController _esController = TextEditingController();
//   int prix = 0;
//   // int theorique_val = 0;

//   ButtonState state = ButtonState.init;
//   final _formKey = GlobalKey<FormState>();
//   User? user = FirebaseAuth.instance.currentUser;
//   UserModel loggedInUser = UserModel();
//   RecetteModel recetteModel = RecetteModel();
//   DateTime? maDate;
//   // String contenu_champ_string = "";
//   // int contenu_champ_number = 0;

//   DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
//         value: item,
//         child: Text(
//           item,
//           style: TextStyle(fontSize: 17),
//         ),
//       );
//   Widget buildSmallButton(isDone) {
//     final color = isDone ? Colors.green : Colors.blueAccent;
//     return Container(
//       decoration: BoxDecoration(shape: BoxShape.circle, color: color),
//       child: Center(
//         child: isDone
//             ? Icon(
//                 Icons.done,
//                 size: 40,
//                 color: Colors.white,
//               )
//             : CircularProgressIndicator(color: Colors.white),
//       ),
//     );
//   }

//   @override
//   void initState() {
//     super.initState();
//     dateinput.text = ""; //set the initial value of text field
//     maDate = DateTime.now();
//     initializeDateFormatting('fr_FR', null).then((_) => AddTodo());
//     FirebaseFirestore.instance
//         .collection("Utilisateur")
//         .doc(user!.uid)
//         .get()
//         .then((value) {
//       this.loggedInUser = UserModel.fromMap(value.data());
//       setState(() {});
//     });
//   }

//   Widget numberItem(TextEditingController controller) {
//     return InkWell(
//       // onTap: () {
//       //   setState(() {});
//       // },
//       child: Container(
//           width: MediaQuery.of(context).size.width - 70,
//           height: 55,
//           child: TextFormField(
//             autofocus: false,
//             keyboardType: TextInputType.number,
//             controller: controller,
//             validator: (value) {
//               //champ vide
//               if (value!.isEmpty) {
//                 return "Veuillez renseigner ce champ svp";
//               }
//               return null;
//             },
//             onSaved: (value) {
//               controller.text = value!;
//             },
//             style: const TextStyle(fontSize: 17, color: Colors.black),
//             decoration: InputDecoration(
//                 // labelText: labelText,
//                 hintText: "Entrer la recette",
//                 labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
//                 focusedBorder: OutlineInputBorder(
//                   borderRadius: BorderRadius.circular(15),
//                   borderSide: const BorderSide(width: 1.5, color: Colors.blue),
//                 ),
//                 enabledBorder: OutlineInputBorder(
//                     borderRadius: BorderRadius.circular(15),
//                     borderSide:
//                         const BorderSide(width: 1, color: Colors.grey))),
//           )),
//     );
//   }

//   Widget textDate() {
//     return Container(
//       width: MediaQuery.of(context).size.width - 70,
//       height: 55,
//       child: TextFormField(
//         onTap: () async {
//           DateTime? choix = await showDatePicker(
//               context: context,
//               initialDate: DateTime.now(),
//               firstDate: DateTime(2021),
//               lastDate: DateTime.now());

//           if (choix != null) {
//             // 'fr_FR' DateFormat.yMMMMd('en_US')
//             String formattedDate_affichage =
//                 DateFormat.yMMMMd('fr_FR').format(choix);
//             String formattedDate = DateFormat('dd-MM-yyyy').format(choix);
//             print(formattedDate);
//             setState(() {
//               maDate = choix;
//               // print(maDate);
//               dateinput.text =
//                   formattedDate_affichage; //set output date to TextField value.
//             });
//           } else {
//             print('Date non selectionnée');
//           }
//         },
//         autofocus: false,
//         readOnly: true,
//         controller: dateinput,
//         validator: (value) {
//           //champ vide
//           if (value!.isEmpty) {
//             return "Veuillez renseigner ce champ svp";
//           }
//           return null;
//         },
//         onSaved: (value) {
//           dateinput.text = value!;
//         },
//         obscureText: false,
//         style: const TextStyle(fontSize: 17, color: Colors.black),
//         decoration: InputDecoration(
//             // labelText: 'Selectionner la date',
//             hintText: "Selectionner la date",
//             labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
//             focusedBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: const BorderSide(width: 1.5, color: Colors.blue)),
//             enabledBorder: OutlineInputBorder(
//                 borderRadius: BorderRadius.circular(15),
//                 borderSide: const BorderSide(width: 1, color: Colors.grey))),
//       ),
//     );
//   }

//   void _refresh() {
//     setState(() {
//       dateinput.text = "";
//       maDate = DateTime.now();
//       // _nomController.text = "";
//       _prixController.text = "";
//       // _esController.text = "";
//     });
//   }

//   @override
//   Widget build(BuildContext context) {
//     void SnackbarAsync() async {
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => HomePage()));
//       final snackBar =
//           SnackBar(content: Text("Recette enregistrer avec succès"));
//       ScaffoldMessenger.of(context)
//         ..removeCurrentSnackBar()
//         ..showSnackBar(snackBar);

//       await Future.delayed(Duration(seconds: 2));
//     }

//     void Snackbar() {
//       final snackBar = SnackBar(content: Text("Formulaire rafréchit"));
//       ScaffoldMessenger.of(context).showSnackBar(snackBar);
//     }

//     void showToast() => Fluttertoast.showToast(
//           msg: "Formulaire rafréchit",
//           fontSize: 18,
//           gravity: ToastGravity.BOTTOM,
//         );

//     void VideToast() => Fluttertoast.showToast(
//           msg: "Fomulaire imcomplet",
//           fontSize: 18,
//           gravity: ToastGravity.BOTTOM,
//         );

//     void showToastAsync() async {
//       await Fluttertoast.showToast(
//         msg: "Recette enregistrer",
//         fontSize: 18,
//         gravity: ToastGravity.BOTTOM,
//       );
//       Navigator.of(context)
//           .push(MaterialPageRoute(builder: (context) => Transition()));
//     }

//     Future EnregistrerRecette() async {
//       if (_formKey.currentState!.validate()) {
//         try {
//           setState(() => state = ButtonState.loading);
//           await Future.delayed(Duration(seconds: 2));
//           setState(() => state = ButtonState.done);
//           await Future.delayed(Duration(seconds: 2));
//           setState(() => state = ButtonState.init);
//           prix = int.parse(_prixController.text);
//           recetteModel.Prix = prix;
//           recetteModel.Date = maDate;
//           recetteModel.Id_user = user!.uid;
//           FirebaseFirestore.instance.collection("Recette").add({
//             "Date": maDate,
//             "Id_user": loggedInUser.uid,
//             "Prix": prix,
//             // "Id_rec": recetteModel.Id_rec,
//           });
//           print("enregistrer");
//           showToastAsync();
//         } on FirebaseAuthException catch (e) {
//           ScaffoldMessenger.of(context).showSnackBar(SnackBar(
//             content: Text(e.message.toString()),
//             backgroundColor: Colors.red,
//           ));
//         } catch (e) {
//           print(e);
//         }
//       }

//       // maDate = DateTime.parse(dateinput.text);
//       // recetteModel.Id_rec = recetteModel.Id_rec;
//       // recetteModel.Id_rec = ;

//       // theorique_val = int.parse(_siController.text);
//     }

//     bool isStretched = state == ButtonState.init;
//     bool isDone = state == ButtonState.done;
//     return GestureDetector(
//       onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
//       child: Scaffold(
//           appBar: AppBar(
//             leading: IconButton(
//               icon: Icon(Icons.arrow_back_ios_new_outlined),
//               tooltip: 'Retour Option',
//               onPressed: () {
//                 Navigator.of(context).push(
//                     MaterialPageRoute(builder: (context) => Transition()));
//               },
//             ),
//             elevation: 2.0,
//             backgroundColor: Colors.blue,
//             centerTitle: true,
//             title: InkWell(
//               onTap: () {
//                 Navigator.push(context,
//                     MaterialPageRoute(builder: (context) => const HomePage()));
//               },
//               child: const Text(
//                 'Ma Recette',
//               ),
//             ),
//             actions: [
//               // InkWell(
//               //   onTap: () {
//               //     EnregistrerRecette();
//               //   },
//               //   child: IconButton(
//               //       icon: Icon(Icons.done, color: Colors.white),
//               //       onPressed: null),
//               // ),
//               InkWell(
//                 onTap: () async {
//                   EnregistrerRecette();
//                 },
//                 child: isStretched
//                     ? IconButton(
//                         icon: Icon(Icons.done, color: Colors.white),
//                         onPressed: null)
//                     : buildSmallButton(isDone),
//               ),
//               InkWell(
//                 onTap: () {
//                   _refresh();
//                   showToast();
//                   print("rafrechis");
//                 },
//                 child: Container(
//                   child: IconButton(
//                       icon: Icon(Icons.refresh, color: Colors.white),
//                       onPressed: null),
//                 ),
//               ),
//             ],
//           ),
//           body: SafeArea(
//             child: Form(
//               key: _formKey,
//               autovalidateMode: AutovalidateMode.disabled,
//               child: SingleChildScrollView(
//                 child: Container(
//                   decoration: BoxDecoration(color: Colors.blue[50]),
//                   width: MediaQuery.of(context).size.width,
//                   height: MediaQuery.of(context).size.height,
//                   child: Card(
//                     margin: const EdgeInsets.fromLTRB(25, 20, 25, 200),
//                     color: Colors.white,
//                     shadowColor: Colors.blueGrey,
//                     elevation: 3,
//                     shape: const RoundedRectangleBorder(
//                         // side: BorderSide(color: Colors.green, width: 3),
//                         borderRadius: BorderRadius.all(Radius.circular(10))),
//                     child: Center(
//                       child: Column(
//                         crossAxisAlignment: CrossAxisAlignment.center,
//                         children: [
//                           SizedBox(
//                             height: 30,
//                           ),
//                           Container(
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     child: Container(
//                                   height: 1,
//                                   color: Colors.grey,
//                                   margin: EdgeInsets.symmetric(horizontal: 20),
//                                 )),
//                                 Text(
//                                   "Date du jour",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.black),
//                                 ),
//                                 Expanded(
//                                     child: Container(
//                                   height: 1,
//                                   color: Colors.grey,
//                                   margin: EdgeInsets.symmetric(horizontal: 20),
//                                 )),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           textDate(),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           Container(
//                             child: Row(
//                               children: [
//                                 Expanded(
//                                     child: Container(
//                                   height: 1,
//                                   color: Colors.grey,
//                                   margin: EdgeInsets.symmetric(horizontal: 20),
//                                 )),
//                                 Text(
//                                   "Recette",
//                                   style: TextStyle(
//                                       fontSize: 16, color: Colors.black),
//                                 ),
//                                 Expanded(
//                                     child: Container(
//                                   height: 1,
//                                   color: Colors.grey,
//                                   margin: EdgeInsets.symmetric(horizontal: 20),
//                                 )),
//                               ],
//                             ),
//                           ),
//                           SizedBox(
//                             height: 20,
//                           ),
//                           numberItem(_prixController),
//                           // SizedBox(
//                           //   height: 20,
//                           // ),
//                           // Container(
//                           //   child: Row(
//                           //     children: [
//                           //       Expanded(
//                           //           child: Container(
//                           //         height: 1,
//                           //         color: Colors.grey,
//                           //         margin: EdgeInsets.symmetric(horizontal: 20),
//                           //       )),
//                           //       Text(
//                           //         "Recette du site",
//                           //         style:
//                           //             TextStyle(fontSize: 16, color: Colors.black),
//                           //       ),
//                           //       Expanded(
//                           //           child: Container(
//                           //         height: 1,
//                           //         color: Colors.grey,
//                           //         margin: EdgeInsets.symmetric(horizontal: 20),
//                           //       )),
//                           //     ],
//                           //   ),
//                           // ),
//                           // SizedBox(
//                           //   height: 20,
//                           // ),
//                           // numberItem("Entrer la recette du site", _siController),
//                         ],
//                       ),
//                     ),
//                   ),
//                 ),
//               ),
//             ),
//           )),
//     );
//   }
// }

//             // onChanged: (String string) {
//             //   setState(() {
//             //     // poids = string as double? tryParse(String string);
//             //     // if (string.isEmpty) {
//             //     //   contenu_champ_number = 0;
//             //     // } else {
//             //     //   contenu_champ_number = int.parse(string);
//             //     // }
//             //   });
//             // },

// // Widget textItem(
// //     String labelText, TextEditingController controller, bool obscureText) {
// //   return InkWell(
// //     onTap: () {
// //       setState(() {
// //         // refresh_Controller.text = contenu_champ_string;
// //       });
// //     },
// //     child: Container(
// //         width: MediaQuery.of(context).size.width - 70,
// //         height: 55,
// //         child: TextFormField(
// //           onChanged: (String string) {
// //             setState(() {
// //               // poids = string as double? tryParse(String string);
// //               // if (string.isEmpty) {
// //               //   contenu_champ_string = "";
// //               // } else {
// //               //   contenu_champ_string = string;
// //               // }
// //             });
// //           },
// //           controller: controller,
// //           obscureText: obscureText,
// //           style: const TextStyle(fontSize: 17, color: Colors.black),
// //           decoration: InputDecoration(
// //               labelText: labelText,
// //               labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
// //               focusedBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                   borderSide:
// //                       const BorderSide(width: 1.5, color: Colors.blue)),
// //               enabledBorder: OutlineInputBorder(
// //                   borderRadius: BorderRadius.circular(15),
// //                   borderSide:
// //                       const BorderSide(width: 1, color: Colors.grey))),
// //         )),
// //   );
// // }

