// ignore_for_file: unused_import

import 'package:flutter/material.dart';

class CustomButton extends StatelessWidget {
  final double width;
  final double height;
  final Widget child;
  final Function onPressed;

  const CustomButton(
      {Key? key,
      required this.child,
      this.height = 40,
      this.width = 220,
      required this.onPressed})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: height,
      width: width,
      child: ElevatedButton(
        onPressed: () {},
        child: child,
      ),
    );
  }
}
