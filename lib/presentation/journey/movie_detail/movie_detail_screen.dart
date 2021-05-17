import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/di/get_it.dart';
import 'package:miusu/presentation/blocs/cast/cast_cubit.dart';
import 'package:miusu/presentation/blocs/favorite/favorite_cubit.dart';
import 'package:miusu/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:miusu/presentation/blocs/videos/videos_cubit.dart';
import 'package:miusu/presentation/journey/movie_detail/movie_detail_arguments.dart';
import 'package:miusu/presentation/journey/movie_detail/videos_widget.dart';

import 'big_poster.dart';
import 'cast_widget.dart';

class MovieDetailScreen extends StatefulWidget {
  final MovieDetailArguments watchMovieArguments;

  const MovieDetailScreen({Key? key, required this.watchMovieArguments})
      : super(key: key);

  @override
  _MovieDetailScreenState createState() => _MovieDetailScreenState();
}

class _MovieDetailScreenState extends State<MovieDetailScreen> {
  late MovieDetailCubit _movieDetailCubit;
  late CastCubit _castCubit;
  late VideosCubit _videosCubit;
  late FavoriteCubit _favoriteCubit;

  @override
  void initState() {
    _movieDetailCubit = getItInstance<MovieDetailCubit>();
    _castCubit = _movieDetailCubit.castCubit;
    _videosCubit = _movieDetailCubit.videosCubit;
    _favoriteCubit = _movieDetailCubit.favoriteCubit;
    _movieDetailCubit.loadMovieDetail(widget.watchMovieArguments.id);
    super.initState();
  }

  @override
  void dispose() {
    _castCubit.close();
    _videosCubit.close();
    _favoriteCubit.close();
    _movieDetailCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailCubit),
          BlocProvider.value(value: _castCubit),
          BlocProvider.value(value: _videosCubit),
          BlocProvider.value(value: _favoriteCubit),
        ],
        child: BlocBuilder<MovieDetailCubit, MovieDetailState>(
            builder: (context, state) {
              if (state is MovieDetailLoaded) {
                final movieDetail = state.movieDetailEntity;
                return SingleChildScrollView(
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      BigPoster(movie: movieDetail),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w, vertical: Sizes.dimen_8.h),
                        child: Text(
                          movieDetail.overview ?? '',
                          style: Theme.of(context).textTheme.bodyText2,
                        ),
                      ),
                      Padding(
                        padding: EdgeInsets.symmetric(horizontal: Sizes.dimen_16.w),
                        child: Text(
                          TranslationConstants.cast.t(context),
                          style: Theme.of(context).textTheme.headline6,
                        ),
                      ),
                      CastWidget(),
                      VideosWidget(videosCubit: _videosCubit),
                    ],
                  ),
                );
              } else if (state is MovieDetailError) {
                return Container();
              }
              return SizedBox.shrink();
            },
          ),
        ),
    );
  }
}
