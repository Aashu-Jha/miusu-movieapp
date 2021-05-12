import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:miusu/common/constants/route_constants.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/data/core/api_constants.dart';
import 'package:miusu/presentation/journey/movie_detail/movie_detail_arguments.dart';

class MovieTabCardWidget extends StatelessWidget {
  final int movId;
  final String title, posterPath;

  MovieTabCardWidget(
      {Key? key,
      required this.movId,
      required this.title,
      required this.posterPath})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).pushNamed(
          RouteList.movieDetail, arguments: MovieDetailArguments(id: movId)
        );
      },
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: <Widget>[
          Expanded(
              child: ClipRRect(
            borderRadius: BorderRadius.circular(Sizes.dimen_6.h),
            child: CachedNetworkImage(
              imageUrl: '${ApiConstants.BASE_IMAGE_URL}$posterPath',
              fit: BoxFit.cover,
            ),
          )),
          Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Text(
              title.intelliTrim(),
              maxLines: 1,
              textAlign: TextAlign.center,
              style: Theme.of(context).textTheme.bodyText2,
            ),
          )
        ],
      ),
    );
  }
}
