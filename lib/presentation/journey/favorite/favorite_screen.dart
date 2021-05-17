import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/di/get_it.dart';
import 'package:miusu/presentation/blocs/favorite/favorite_cubit.dart';

import 'favorite_movie_grid_view.dart';

class FavoriteScreen extends StatefulWidget {
  @override
  _FavoriteScreenState createState() => _FavoriteScreenState();
}

class _FavoriteScreenState extends State<FavoriteScreen> {
  late FavoriteCubit _favoriteCubit;

  @override
  void initState() {
    _favoriteCubit = getItInstance<FavoriteCubit>();
    _favoriteCubit.loadFavoriteMovie();
    super.initState();
  }

  @override
  void dispose() {
    _favoriteCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(TranslationConstants.favoriteMovies.t(context)),
      ),
      body: BlocProvider<FavoriteCubit>.value(
        value: _favoriteCubit,
        child: BlocBuilder<FavoriteCubit, FavoriteState>(
          builder: (context, state) {
            if (state is FavoriteMoviesLoaded) {
              if (state.movies.isEmpty)
                return Center(
                  child: Text(
                    TranslationConstants.noFavoriteMovie.t(context),
                    textAlign: TextAlign.center,
                    style: Theme.of(context).textTheme.subtitle1,
                  ),
                );
              return FavoriteMovieGridView(movies: state.movies);
            }
            return const SizedBox.shrink();
          },
        ),
      ),
    );
  }
}
