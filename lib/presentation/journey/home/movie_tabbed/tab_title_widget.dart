import 'package:flutter/material.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/presentation/themes/app_color.dart';
import 'package:miusu/presentation/themes/theme_text.dart';

class TabTitleWidget extends StatelessWidget {
  final String title;
  final Function onTap;
  final bool isSelected;


  const TabTitleWidget({Key? key, required this.title, required this.onTap,  this.isSelected = false})
    : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          border: Border(
            bottom: BorderSide(
              color: isSelected ? AppColor.royalBlue : Colors.transparent,
              width: Sizes.dimen_1.w,
            )
          )
        ),
        child: Text(
          title.t(context), //'popular', 'now', 'soon'
          style: isSelected ? Theme.of(context).textTheme.royalBlueSubtitle1
            : Theme.of(context).textTheme.subtitle1,
        ),
      ),
    );
  }
}
