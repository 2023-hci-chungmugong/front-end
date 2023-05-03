import 'package:flutter/material.dart';

class DesignKit {
  // colors
  static const mainColor = Color.fromARGB(255, 17, 22, 160);
  static const green = Color.fromARGB(255, 162, 255, 171);
  static const blue = Color.fromARGB(255, 147, 229, 255);
  static const red = Color.fromARGB(255, 254, 161, 161);
  static const yellow = Color.fromARGB(255, 255, 215, 0);
  static const gray = Color.fromARGB(255, 188, 188, 188);

  // proportions
  static getWidth(context, width) =>
      MediaQuery.of(context).size.width * width / 360;
  static getHeight(context, hegiht) =>
      MediaQuery.of(context).size.height * hegiht / 360;
}
