// ignore_for_file: unused_import, file_names, sized_box_for_whitespace, prefer_const_constructors, avoid_print, unused_local_variable, prefer_const_literals_to_create_immutables, use_full_hex_values_for_flutter_colors

import 'dart:async';

import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';
import 'package:otp_text_field/otp_field.dart';
import 'package:otp_text_field/otp_text_field.dart';
import 'package:otp_text_field/style.dart';
import 'package:recette_app/Service/Auth_service.dart';

class PhoneAuthPage extends StatefulWidget {
  const PhoneAuthPage({Key? key}) : super(key: key);

  @override
  _PhoneAuthPageState createState() => _PhoneAuthPageState();
}

class _PhoneAuthPageState extends State<PhoneAuthPage> {
  int start = 30;
  bool wait = false;
  String buttonName = "Envoyé";
  TextEditingController phoneController = TextEditingController();
  AuthClass authClass = AuthClass();
  String verificationId = "";
  String smsCode = "";
  String verificationIdFinal = "";
  @override
  Widget build(BuildContext context) {
    return Scaffold(
        backgroundColor: Colors.black87,
        appBar: AppBar(
          backgroundColor: Colors.black87,
          title: const Text(
            "S'enregistrer",
            style: TextStyle(color: Colors.white, fontSize: 24),
          ),
          centerTitle: true,
        ),
        body: Container(
          height: MediaQuery.of(context).size.height,
          width: MediaQuery.of(context).size.width,
          child: SingleChildScrollView(
            child: Column(
              children: [
                SizedBox(
                  height: 120,
                ),
                textField(),
                SizedBox(
                  height: 30,
                ),
                Container(
                  width: MediaQuery.of(context).size.width - 40,
                  child: Row(
                    children: [
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      )),
                      Text(
                        "Entrez les 6 chiffres",
                        style: TextStyle(fontSize: 16, color: Colors.white),
                      ),
                      Expanded(
                          child: Container(
                        height: 1,
                        color: Colors.grey,
                        margin: EdgeInsets.symmetric(horizontal: 12),
                      )),
                    ],
                  ),
                ),
                SizedBox(
                  height: 30,
                ),
                otpField(),
                SizedBox(
                  height: 40,
                ),
                RichText(
                    text: TextSpan(
                  children: [
                    TextSpan(
                      text: "Envoyé encore les 6 chiffres",
                      style:
                          TextStyle(fontSize: 16, color: Colors.yellowAccent),
                    ),
                    TextSpan(
                      text: " 00 : $start ",
                      style: TextStyle(fontSize: 16, color: Colors.pinkAccent),
                    ),
                    TextSpan(
                      text: "sec",
                      style:
                          TextStyle(fontSize: 16, color: Colors.yellowAccent),
                    ),
                  ],
                )),
                SizedBox(
                  height: 150,
                ),
                InkWell(
                  onTap: () {
                    authClass.signInwithPhoneNumber(
                        verificationIdFinal, smsCode, context);
                  },
                  child: Container(
                    height: 60,
                    width: MediaQuery.of(context).size.width - 60,
                    decoration: BoxDecoration(
                        color: Color(0xffff9601),
                        borderRadius: BorderRadius.circular(15)),
                    child: Center(
                      child: Text(
                        "Lets Go",
                        style: TextStyle(
                            fontSize: 17,
                            color: Color(0xfffbe2ae),
                            fontWeight: FontWeight.w700),
                      ),
                    ),
                  ),
                )
              ],
            ),
          ),
        ));
  }

  void startTimer() {
    const onsec = Duration(seconds: 1);
    Timer _timer = Timer.periodic(onsec, (timer) {
      if (start == 0) {
        setState(() {
          timer.cancel();
          wait = false;
        });
      } else {
        setState(() {
          start--;
        });
      }
    });
  }

  Widget otpField() {
    return OTPTextField(
      length: 6,
      width: MediaQuery.of(context).size.width - 25,
      otpFieldStyle: OtpFieldStyle(
          backgroundColor: Color(0xff1d1d1d), borderColor: Colors.white),
      fieldWidth: 58,
      style: TextStyle(fontSize: 17, color: Colors.white),
      textFieldAlignment: MainAxisAlignment.spaceAround,
      fieldStyle: FieldStyle.underline,
      onChanged: (pin) {
        print("Changed: " + pin);
      },
      onCompleted: (pin) {
        print("Terminé: " + pin);
        setState(() {
          smsCode = pin;
        });
      },
    );
  }

  Widget textField() {
    return Container(
        width: MediaQuery.of(context).size.width - 40,
        height: 60,
        decoration: BoxDecoration(
            color: Color(0xff1d1d1d), borderRadius: BorderRadius.circular(15)),
        child: TextFormField(
            controller: phoneController,
            cursorColor: Colors.white,
            style: const TextStyle(fontSize: 17, color: Colors.white),
            decoration: InputDecoration(
              border: InputBorder.none,
              hintText: "Numéro téléphone",
              hintStyle: TextStyle(color: Colors.white54, fontSize: 17),
              contentPadding: EdgeInsets.symmetric(vertical: 19, horizontal: 8),
              prefixIcon: Padding(
                  padding: EdgeInsets.symmetric(vertical: 14, horizontal: 15),
                  child: Text(
                    " (+225) ",
                    style: TextStyle(color: Colors.white, fontSize: 17),
                  )),
              suffixIcon: InkWell(
                onTap: wait
                    ? null
                    : () async {
                        startTimer();
                        setState(() {
                          start = 30;
                          wait = true;
                          buttonName = "Renvoyé";
                        });
                        await authClass.verifyPhoneNumber(
                            "+225 ${phoneController.text}", context, setData);
                      },
                child: Padding(
                    padding: EdgeInsets.symmetric(vertical: 20, horizontal: 15),
                    child: Text(
                      buttonName,
                      style: TextStyle(
                          color: wait ? Colors.grey : Colors.white,
                          fontSize: 17,
                          fontWeight: FontWeight.bold),
                    )),
              ),
            )));
  }

  void setData(String verificationId) {
    setState(() {
      verificationIdFinal = verificationId;
    });
    startTimer();
  }
}
