import 'package:flutter/material.dart';

extension SizeExtensions on BuildContext {
  double get screenWidth => MediaQuery.of(this).size.width;
  double get screenHeight => MediaQuery.of(this).size.height;

  double percentualWidth(double percent) => screenWidth * percent;
  double percentualHeight(double percent) => screenHeight * percent;
}
