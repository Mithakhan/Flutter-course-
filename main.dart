import 'package:flutter/material.dart';
import 'package:flutter_application_1/model/parsing-json/json-parsing.dart';
import 'package:flutter_application_1/model/parsing-json/parsing_json_name.dart';

final ThemeData _apptheme = _appthemeData();

ThemeData _appthemeData() {
  final ThemeData base = ThemeData.dark();
  return base.copyWith(
      primaryColor: Colors.lightGreen,
      accentColor: Colors.amber,
      scaffoldBackgroundColor: Colors.red,
      backgroundColor: Colors.amber,
      textTheme: _addTexttheme(base.textTheme));
}

TextTheme _addTexttheme(TextTheme base) {
  return base.copyWith(
      headline1: base.headline1!.copyWith(fontWeight: FontWeight.w500),
      headline6:
          base.headline6!.copyWith(fontSize: 18).apply(fontFamily: "Lobster"),
      caption:
          base.caption!.copyWith(fontSize: 14, fontWeight: FontWeight.w400),
      bodyText1: base.bodyText1!
          .copyWith(fontFamily: "Lobster", fontSize: 16.9, color: Colors.white),
      button: base.button!.copyWith(letterSpacing: 3.0));
}

void main() {
  runApp(MaterialApp(
    // theme: _apptheme,
    home: Json_Parsing(),
  ));
}
