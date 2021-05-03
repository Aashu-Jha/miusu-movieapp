import 'dart:ui';

import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

import '../../../../common/constants/sizes.dart';
import '../../../../common/screenutil/screen_util.dart';
import '../../../../data/core/api_constants.dart';

class MovieBackdropWidget extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return FractionallySizedBox(
      alignment: Alignment.topCenter,
      heightFactor: 0.7,
      child: ClipRRect(
        borderRadius: BorderRadius.vertical(
          bottom: Radius.circular(Sizes.dimen_40.w),
        ),
        child: Stack(
          children: [
            FractionallySizedBox(
              heightFactor: 1,
              widthFactor: 1,
              child: BlocBuilder<MovieBackdropBloc,MovieBackdropState>(
                builder: (context, state) {
                  if(state is MovieBackdropChanged) {
                    return CachedNetworkImage(
                      imageUrl: '${ApiConstants.BASE_IMAGE_URL}${state.movie.backdropPath}',
                      fit: BoxFit.fitHeight,
                      );
                  }
                  return const SizedBox.shrink();
                }
              ),
            ),
            BackdropFilter(
              filter: ImageFilter.blur(sigmaX: 5.0, sigmaY: 5.0),
              child: Container(
                width: ScreenUtil.screenWidth,
                height: 1,
                color: Colors.transparent,
              ),
            ),
          ],
        ),
      ),
    );
  }
}