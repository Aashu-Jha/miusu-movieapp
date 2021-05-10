import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/num_extensions.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/presentation/themes/theme_text.dart';
import 'package:miusu/common/screenutil/screen_util.dart';
import 'package:miusu/data/core/api_constants.dart';
import 'package:miusu/domain/entities/movie_detail_entity.dart';

import 'movie_detail_app_bar.dart';

class BigPoster extends StatelessWidget {
  final MovieDetailEntity? movie;

  const BigPoster({Key? key, required this.movie}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      Container(
        foregroundDecoration: BoxDecoration(
          gradient: LinearGradient(
              begin: Alignment.topCenter,
              end: Alignment.bottomCenter,
              colors: [
                Theme.of(context).primaryColor.withOpacity(0.3),
                Theme.of(context).primaryColor,
              ]),
        ),
        child: CachedNetworkImage(
          imageUrl: '${ApiConstants.BASE_IMAGE_URL}${movie!.posterPath}',
          width: ScreenUtil.screenWidth,
        ),
      ),
      Positioned(
        left: 0,
        right: 0,
        bottom: 0,
        child: ListTile(
          title: Text(movie!.title!,
            style: Theme.of(context).textTheme.headline5,
          ),
          subtitle: Text(movie!.releaseDate!,
            style: Theme.of(context).textTheme.greySubtitle1,
          ),
          trailing: Text(
            movie!.voteAverage!.convertToPercentString(),
            style: Theme.of(context).textTheme.violetHeadLine6,
          ),
        )
      ),
      Positioned(
        left: Sizes.dimen_16.w,
        right: Sizes.dimen_16.w,
        top: ScreenUtil.statusBarHeight + Sizes.dimen_2.h,
        child: MovieDetailAppBar(),
      ),
    ]);
  }
}
