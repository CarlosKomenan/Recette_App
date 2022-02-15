// ignore_for_file: avoid_unnecessary_containers, prefer_const_constructors, sized_box_for_whitespace, unused_field, unused_import, unused_local_variable, dead_code

import 'package:flutter/material.dart';
import 'package:fluttertoast/fluttertoast.dart';
import 'package:recette_app/pages/Home.dart';

import 'list_objets.dart';

class AddTodoO extends StatefulWidget {
  const AddTodoO({Key? key}) : super(key: key);

  @override
  _AddTodoOState createState() => _AddTodoOState();
}

enum ButtonState { init, loading, done }

class _AddTodoOState extends State<AddTodoO> {
  ButtonState state = ButtonState.init;
  final TextEditingController _nomController = TextEditingController();
  final TextEditingController _commentaireController = TextEditingController();
  String? value;

  var items = [
    'Salaire',
    'Loyer',
    'Transport',
    'Farine',
    'Huile',
    'Lait',
    'Sucre',
    "Main d'oeuvre",
    'Ingrédients',
    'Bonus',
    "Carburant",
  ];
  DropdownMenuItem<String> buildMenuItem(String item) => DropdownMenuItem(
        value: item,
        child: Text(
          item,
          style: TextStyle(fontSize: 17),
        ),
      );

  Widget buildSmallButton(isDone) {
    final color = isDone ? Colors.green : Colors.blueAccent;
    return Container(
      decoration: BoxDecoration(shape: BoxShape.circle, color: color),
      child: Center(
        child: isDone
            ? Icon(
                Icons.done,
                size: 40,
                color: Colors.white,
              )
            : CircularProgressIndicator(color: Colors.white),
      ),
    );
  }

  void showToastAsync() async {
    await Fluttertoast.showToast(
      msg: "Objet de dépense enregistrer",
      fontSize: 18,
      gravity: ToastGravity.BOTTOM,
    );
    Navigator.of(context)
        .push(MaterialPageRoute(builder: (context) => ListObjet()));
  }

  Widget textItem(String labelText, TextEditingController controller,
      bool obscureText, double hauteur) {
    return InkWell(
      onTap: () {
        setState(() {
          // refresh_Controller.text = contenu_champ_string;
        });
      },
      child: Container(
          width: MediaQuery.of(context).size.width - 70,
          height: hauteur,
          child: TextFormField(
            onChanged: (String string) {
              setState(() {
                // poids = string as double? tryParse(String string);
                // if (string.isEmpty) {
                //   contenu_champ_string = "";
                // } else {
                //   contenu_champ_string = string;
                // }
              });
            },
            // onSaved: (value) {
            //   controller.text = value!;
            // },
            // validator: (value) {
            //   //champ vide
            //   if (value!.isEmpty) {
            //     return "Veuillez renseigner le champ svp";
            //   }
            //   return null;
            // },
            controller: controller,
            obscureText: obscureText,
            style: const TextStyle(fontSize: 17, color: Colors.black),
            decoration: InputDecoration(
                labelText: labelText,
                labelStyle: const TextStyle(fontSize: 17, color: Colors.black),
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

  @override
  Widget build(BuildContext context) {
    bool isStretched = state == ButtonState.init;
    bool isDone = state == ButtonState.done;
    return GestureDetector(
      onTap: (() => FocusScope.of(context).requestFocus(FocusNode())),
      child: Scaffold(
          appBar: AppBar(
            leading: IconButton(
              icon: Icon(Icons.arrow_back_ios_new_outlined),
              tooltip: 'Retour Icon',
              onPressed: () {
                Navigator.of(context)
                    .push(MaterialPageRoute(builder: (context) => ListObjet()));
              },
            ),
            elevation: 2.0,
            backgroundColor: Colors.blue,
            centerTitle: false,
            title: InkWell(
              onTap: () {
                Navigator.push(context,
                    MaterialPageRoute(builder: (context) => ListObjet()));
              },
              child: const Text(
                'Objet dépense ',
              ),
            ),
            actions: [
              InkWell(
                onTap: () async {
                  setState(() => state = ButtonState.loading);
                  await Future.delayed(Duration(seconds: 2));
                  setState(() => state = ButtonState.done);
                  await Future.delayed(Duration(seconds: 2));
                  setState(() => state = ButtonState.init);
                  showToastAsync();
                },
                child: isStretched
                    ? IconButton(
                        icon: Icon(Icons.done, color: Colors.white),
                        onPressed: null)
                    : buildSmallButton(isDone),
              ),
              InkWell(
                // onTap: () {
                //   _refresh();
                //   showToast();
                //   print("rafrechis");
                // },
                child: Container(
                    child: IconButton(
                        icon: Icon(Icons.refresh, color: Colors.white),
                        onPressed: null)),
              ),
            ],
          ),
          body: SingleChildScrollView(
            child: Container(
              decoration: BoxDecoration(color: Colors.blue[50]),
              width: MediaQuery.of(context).size.width,
              height: MediaQuery.of(context).size.height,
              child: Card(
                margin: const EdgeInsets.fromLTRB(25, 20, 25, 200),
                color: Colors.white,
                shadowColor: Colors.blueGrey,
                elevation: 3,
                shape: const RoundedRectangleBorder(
                    // side: BorderSide(color: Colors.green, width: 3),
                    borderRadius: BorderRadius.all(Radius.circular(10))),
                child: Center(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    children: [
                      SizedBox(
                        height: 30,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            )),
                            Text(
                              "Nom dépense *",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textItem("Entrer l'intitulé de la dépense",
                          _nomController, false, 55),
                      // textDate(),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            )),
                            Text(
                              "Catégorie *",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        width: MediaQuery.of(context).size.width - 70,
                        padding:
                            EdgeInsets.symmetric(horizontal: 20, vertical: 2),
                        decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(12),
                            border: Border.all(color: Colors.grey)),
                        child: DropdownButton<String>(
                          value: value,
                          isExpanded: true,
                          iconSize: 36,
                          icon: Icon(
                            Icons.arrow_drop_down,
                            color: Colors.black,
                          ),
                          hint: Text(
                            "Selectionner dépense",
                            style: TextStyle(fontSize: 17, color: Colors.black),
                          ),
                          items: items.map(buildMenuItem).toList(),
                          onChanged: (value) =>
                              setState(() => this.value = value),
                        ),
                      ),
                      // numberItem("Entrer la recette en espèce", _esController),
                      SizedBox(
                        height: 20,
                      ),
                      Container(
                        child: Row(
                          children: [
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            )),
                            Text(
                              "Commentaire",
                              style:
                                  TextStyle(fontSize: 16, color: Colors.black),
                            ),
                            Expanded(
                                child: Container(
                              height: 1,
                              color: Colors.grey,
                              margin: EdgeInsets.symmetric(horizontal: 20),
                            )),
                          ],
                        ),
                      ),
                      SizedBox(
                        height: 20,
                      ),
                      textItem("Entrer un commentaire s'il y a lieu",
                          _commentaireController, false, 100),
                    ],
                  ),
                ),
              ),
            ),
          )),
    );
  }
}
