import 'package:flutter/material.dart';

const colorSeed = Color(0xffF7322E);
const scaffoldBackgroundColor = Color(0xff16162F);

class AppTheme {
  ThemeData getTheme() => ThemeData(
      useMaterial3: true,
      colorSchemeSeed: colorSeed,
      appBarTheme: const AppBarTheme(backgroundColor: colorSeed),
      scaffoldBackgroundColor: scaffoldBackgroundColor,
      brightness: Brightness.dark);
}
