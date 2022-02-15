// ignore_for_file: prefer_const_constructors

import 'package:flutter/material.dart';

TextStyle kHintStyle = TextStyle(
  fontSize: 13,
  letterSpacing: 1.2,
);

//border
var kOutlineBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.transparent));

var kOutlineErrorBorder = OutlineInputBorder(
    borderRadius: BorderRadius.circular(8),
    borderSide: BorderSide(color: Colors.red));

SizedBox kLoaderBtn = SizedBox(
  height: 20,
  width: 20,
  child: CircularProgressIndicator(
    strokeWidth: 1.5,
    valueColor: AlwaysStoppedAnimation<Color>(Colors.white),
  ),
);
