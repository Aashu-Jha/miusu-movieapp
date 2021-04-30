import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/data/core/api_constants.dart';

class MovieCardWidget extends StatelessWidget {
  final int movId;
  final String posterPath;

  const MovieCardWidget({Key? key, required this.movId, required this.posterPath}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () {},
        child: ClipRRect(
          borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
          child: CachedNetworkImage(
            fit: BoxFit.cover,
            imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
          ),
        ),
      ),
    );
  }
}