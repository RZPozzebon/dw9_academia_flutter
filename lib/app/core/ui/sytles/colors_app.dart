import 'package:flutter/material.dart';

class ColorsApp {
  //
  static ColorsApp? _instance;

  ColorsApp._();

  static ColorsApp get i {
    _instance ??= ColorsApp._();
    return _instance!;
  }

  Color get primaria => const Color(0XFF007D21);
  Color get secundaria => const Color(0XFFF88B0C);
}

extension ColorAppExcetions on BuildContext {
  ColorsApp? get colors => ColorsApp.i;
}
