import 'package:flutter/material.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/presentation/themes/app_color.dart';

import 'button.dart';

class AppDialog extends StatelessWidget {
  final String title, description, buttonText;
  final Widget? image;


  AppDialog({Key? key, required this.title, required this.description, required this.buttonText, this.image})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Dialog(
      backgroundColor: Theme.of(context).primaryColor,
      elevation: Sizes.dimen_32,
      insetPadding: EdgeInsets.all(Sizes.dimen_32),
      shape: RoundedRectangleBorder(
          borderRadius: BorderRadius.all(
              Radius.circular(Sizes.dimen_8.w)
          )
      ),
      child: Container(
        padding: EdgeInsets.only(
          top: Sizes.dimen_4.h,
          left: Sizes.dimen_16.w,
          right: Sizes.dimen_16.w,
        ),
        decoration: BoxDecoration(
          boxShadow: [
            BoxShadow(
              color: AppColor.vulcan,
              blurRadius: Sizes.dimen_16,
            ),
          ],
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Text(
              title.t(context),
              style: Theme.of(context).textTheme.headline5,
            ),
            Padding(
              padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
              child: Text(
                description.t(context),
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.bodyText2,
              ),
            ),
            image!,
            Button(
              onPressed: () {
                Navigator.of(context).pop();
              },
              text: TranslationConstants.okay,
            ),
          ],
        ),
      ),
    );
  }
}
