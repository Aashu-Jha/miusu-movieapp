import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/data/core/api_constants.dart';
import 'package:miusu/presentation/journey/movie_detail/movie_detail_arguments.dart';
import 'package:miusu/presentation/journey/movie_detail/movie_detail_screen.dart';

class MovieCardWidget extends StatelessWidget {
  final int movId;
  final String posterPath;

  const MovieCardWidget(
      {Key? key, required this.movId, required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Material(
      elevation: 32,
      borderRadius: BorderRadius.circular(Sizes.dimen_16.w),
      child: GestureDetector(
        onTap: () {
          Navigator.of(context).push(
            MaterialPageRoute(
              builder: (context) => MovieDetailScreen(
                arguments: MovieDetailArguments(movId),
              ),
            ),
          );
        },
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
