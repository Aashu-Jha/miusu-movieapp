import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/constants/sizes.dart';

import 'app_color.dart';

class ThemeText {
  const ThemeText._();

  static TextTheme get _poppinsTextTheme => GoogleFonts.poppinsTextTheme();
  static TextStyle get _whiteHeadLine6 => _poppinsTextTheme.headline6!.copyWith(
    fontSize: Sizes.dimen_20.sp as double,
    color: Colors.white,
  );

  static TextStyle get _whiteHeadLine5 => _poppinsTextTheme.headline6!.copyWith(
    fontSize: Sizes.dimen_24.sp as double,
    color: Colors.white,
  );

  static TextStyle get whiteSubtitle1 => _poppinsTextTheme.subtitle1!.copyWith(
    fontSize: Sizes.dimen_16.sp as double,
    color: Colors.white,
  );

  static TextStyle get _whiteButton => _poppinsTextTheme.subtitle1!.copyWith(
    fontSize: Sizes.dimen_14.sp as double,
    color: Colors.white,
  );

  static TextStyle get whiteBodyText2 => _poppinsTextTheme.bodyText2!.copyWith(
    color: Colors.white,
    fontSize: Sizes.dimen_14.sp as double,
    wordSpacing: 0.25,
    letterSpacing: 0.25,
    height: 1.5,
  );

  static getTextTheme() => TextTheme(
    headline5: _whiteHeadLine5,
    headline6: _whiteHeadLine6,
    subtitle1: whiteSubtitle1,
    bodyText2: whiteBodyText2,
    button: _whiteButton
  );
}

extension ThemeTextExtension on TextTheme {
  TextStyle get royalBlueSubtitle1 => subtitle1!.copyWith(
    color: AppColor.royalBlue,
    fontWeight: FontWeight.w600,
  );

}