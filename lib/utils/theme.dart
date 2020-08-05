import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';


const Color darkGrey = Color(0xAEDDA6);

themeData(context) => ThemeData(
      textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme),
      primarySwatch: Colors.green,
      primaryColor: Colors.green,
      brightness: Brightness.light,
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );

darkThemeData(context) => ThemeData.dark().copyWith(
      textTheme: GoogleFonts.ubuntuTextTheme(Theme.of(context).textTheme),
      primaryColor: Colors.green,
      scaffoldBackgroundColor: HexColor.fromHex("#050A30"),
      visualDensity: VisualDensity.adaptivePlatformDensity,
    );


extension HexColor on Color {
  /// String is in the format "aabbcc" or "ffaabbcc" with an optional leading "#".
  static Color fromHex(String hexString) {
    final buffer = StringBuffer();
    if (hexString.length == 6 || hexString.length == 7) buffer.write('ff');
    buffer.write(hexString.replaceFirst('#', ''));
    return Color(int.parse(buffer.toString(), radix: 16));
  }

  /// Prefixes a hash sign if [leadingHashSign] is set to `true` (default is `true`).
  String toHex({bool leadingHashSign = true}) => '${leadingHashSign ? '#' : ''}'
      '${alpha.toRadixString(16).padLeft(2, '0')}'
      '${red.toRadixString(16).padLeft(2, '0')}'
      '${green.toRadixString(16).padLeft(2, '0')}'
      '${blue.toRadixString(16).padLeft(2, '0')}';
}