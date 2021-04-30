import 'package:flutter/material.dart';
import 'package:miusu/common/screenutil/screen_util.dart';
import 'package:miusu/presentation/journey/home/home_screen.dart';
import 'package:miusu/presentation/themes/app_color.dart';
import 'package:miusu/presentation/themes/theme_text.dart';

class MovieApp extends StatelessWidget {

  @override
  Widget build(BuildContext context) {
    ScreenUtil.init();
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      title: 'Miusu',
      theme: ThemeData(
        primaryColor: AppColor.vulcan,
        scaffoldBackgroundColor: AppColor.vulcan,
        textTheme: ThemeText.getTextTheme(),
        appBarTheme: const AppBarTheme(elevation: 0),
      ),
      home: HomeScreen(),
    );
  }
}