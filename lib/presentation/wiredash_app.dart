import 'package:flutter/material.dart';
import 'package:miusu/presentation/themes/app_color.dart';
import 'package:wiredash/wiredash.dart';

class WiredashApp extends StatelessWidget {
  final navigatorKey;
  final Widget child;
  final String languageCode;

  WiredashApp({Key? key, required this.navigatorKey,required this.child, required this.languageCode}): super(key: key);

  @override
  Widget build(BuildContext context) {
    return Wiredash(
      projectId: 'miusu-9d30mr0',
        secret: 'zjhp9z8quycmmxzg52fjalrfutqg8ge4zb0ct54wmczwg2t5',
        navigatorKey: navigatorKey,
        child: child,
      options: WiredashOptionsData(
        locale: Locale.fromSubtags(languageCode: languageCode)
      ),
      theme: WiredashThemeData(
        brightness: Brightness.dark,
        primaryColor: AppColor.royalBlue,
        secondaryColor: AppColor.violet,
        secondaryBackgroundColor: AppColor.vulcan,
        dividerColor: AppColor.vulcan,
      ),
    );
  }
}
