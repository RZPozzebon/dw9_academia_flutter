import 'package:flutter/material.dart';

import '../sytles/app_styles.dart';
import '../sytles/colors_app.dart';
import '../sytles/text_styles.dart';

class ThemeConfig {
  ThemeConfig._();
  static final _defaultInputBorder = OutlineInputBorder(
      borderRadius: BorderRadius.circular(7),
      borderSide: BorderSide(
        color: Colors.grey[400]!,
      ));

  static final theme = ThemeData(
      scaffoldBackgroundColor: Colors.white,
      appBarTheme: const AppBarTheme(
        backgroundColor: Colors.white,
        elevation: 0,
        centerTitle: true,
        iconTheme: IconThemeData(color: Colors.black),
      ),
      primaryColor: ColorsApp.i.primaria,
      colorScheme: ColorScheme.fromSeed(
        seedColor: ColorsApp.i.primaria,
        primary: ColorsApp.i.primaria,
        secondary: ColorsApp.i.secundaria,
      ),
      elevatedButtonTheme: ElevatedButtonThemeData(
        style: AppStyles.i.primariaButton,
      ),
      inputDecorationTheme: InputDecorationTheme(
        fillColor: Colors.white,
        filled: true,
        isDense: true,
        contentPadding: const EdgeInsets.all(14),
        border: _defaultInputBorder,
        enabledBorder: _defaultInputBorder,
        focusedBorder: _defaultInputBorder,
        labelStyle: TextStyles.i.textRegular.copyWith(color: Colors.black),
        errorStyle: TextStyles.i.textRegular.copyWith(color: Colors.red),
      ));
}
