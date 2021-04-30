import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/constants/sizes.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();
  static TextStyle get _whiteHeadLine6 => _poppinsTextTheme.headline6!.copyWith(
    fontSize: Sizes.dimen_20.sp as double,
    color: Colors.white,
  );

  static getTextTheme() => TextTheme(
    headline6: _whiteHeadLine6,
  );
}