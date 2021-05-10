import 'package:flutter/material.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';

class MovieDetailAppBar extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        IconButton(
            icon: Icon(
              Icons.arrow_back_ios,
              color: Colors.white,
              size: Sizes.dimen_12.h,
            ),
            onPressed: () {
              Navigator.of(context).pop();
            },
        ),
        IconButton(
          icon: Icon(
            Icons.favorite_border,
            color: Colors.white,
            size: Sizes.dimen_12.h,
          ),
          onPressed: () {},
        ),
      ],
    );
  }
}
