import 'package:flutter/material.dart';

class UiHelpers {
  static customButton({
    required VoidCallback callback,
    required String buttonName,
    Color? bgColor,
  }) {
    return SizedBox(
      height: 45,
      width: 350,
      child: ElevatedButton(
        style: ElevatedButton.styleFrom(backgroundColor: bgColor),
        onPressed: callback,
        child: Text(
          buttonName,
          style: TextStyle(fontSize: 18, color: Colors.white),
        ),
      ),
    );
  }

  static customText({
    required String text,
    required double fonts,
    Color? color,
    FontWeight? fontsWeight,
  }) {
    return Text(
      text,
      style: TextStyle(
        fontSize: fonts,
        color: color ?? Color(0xFF5E5E5E),
        fontWeight: fontsWeight,
      ),
    );
  }
}
