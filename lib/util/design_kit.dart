import 'package:flutter/material.dart';

class DesignKit {
  // colors
  static const Color mainColor = Color.fromARGB(255, 17, 22, 160);
  static const Color green = Color.fromARGB(255, 162, 255, 171);
  static const Color blue = Color.fromARGB(255, 147, 229, 255);
  static const Color red = Color.fromARGB(255, 254, 161, 161);
  static const Color yellow = Color.fromARGB(255, 255, 215, 0);
  static const Color gray = Color.fromARGB(255, 188, 188, 188);

  // proportions
  // figma에 있는 컴포넌트 사이즈를 넣으면 기기에 맞는 비율로 변환합니다.
  static double getWidth(context, width) =>
      MediaQuery.of(context).size.width * width / 360;
  static double getHeight(context, hegiht) =>
      MediaQuery.of(context).size.height * hegiht / 800;
}
