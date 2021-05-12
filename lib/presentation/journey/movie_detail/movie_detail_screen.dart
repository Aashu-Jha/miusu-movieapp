import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/di/get_it.dart';
import 'package:miusu/presentation/blocs/cast/cast_bloc.dart';
import 'package:miusu/presentation/blocs/favorite/favorite_bloc.dart';
import 'package:miusu/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:miusu/presentation/blocs/videos/videos_bloc.dart';
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
  late MovieDetailBloc? _movieDetailBloc;
  late CastBloc? _castBloc;
  late VideosBloc? _videosBloc;
  late FavoriteBloc? _favoriteBloc;

  @override
  void initState() {
    _movieDetailBloc = getItInstance<MovieDetailBloc>();
    _castBloc = _movieDetailBloc!.castBloc;
    _videosBloc = _movieDetailBloc!.videosBloc;
    _favoriteBloc = _movieDetailBloc!.favoriteBloc;
    _movieDetailBloc!.add(MovieDetailLoadEvent(widget.watchMovieArguments.id));
    super.initState();
  }

  @override
  void dispose() {
    _castBloc!.close();
    _videosBloc!.close();
    _favoriteBloc!.close();
    _movieDetailBloc!.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: MultiBlocProvider(
        providers: [
          BlocProvider.value(value: _movieDetailBloc!),
          BlocProvider.value(value: _castBloc!),
          BlocProvider.value(value: _videosBloc!),
          BlocProvider.value(value: _favoriteBloc!),
        ],
        child: BlocBuilder<MovieDetailBloc, MovieDetailState>(
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
                          movieDetail.overview!,
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
                      VideosWidget(videosBloc: _videosBloc!),
                    ],
                  ),
                );
              } else if (state is MovieDetailError) {
                //ToDo
              } else if (state is MovieDetailLoading) {
                return Center(child: CircularProgressIndicator());
              }
              return SizedBox.shrink();
            },
          ),
        ),
    );
  }
}
