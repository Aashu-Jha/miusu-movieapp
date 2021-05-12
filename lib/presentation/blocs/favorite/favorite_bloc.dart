import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/usecases/check_if_favorite_movie.dart';
import 'package:miusu/domain/usecases/delete_favorite_movie.dart';
import 'package:miusu/domain/usecases/get_favorite_movies.dart';
import 'package:miusu/domain/usecases/no_params.dart';
import 'package:miusu/domain/usecases/save_movie.dart';

part 'favorite_event.dart';

part 'favorite_state.dart';

class FavoriteBloc extends Bloc<FavoriteEvent, FavoriteState> {
  final SaveMovie saveMovie;
  final GetFavoriteMovies getFavoriteMovies;
  final DeleteFavoriteMovie deleteFavoriteMovie;
  final CheckIfFavoriteMovie checkIfFavoriteMovie;

  FavoriteBloc({
    required this.saveMovie,
    required this.getFavoriteMovies,
    required this.deleteFavoriteMovie,
    required this.checkIfFavoriteMovie,
  }) : super(FavoriteInitial());

  @override
  Stream<FavoriteState> mapEventToState(
    FavoriteEvent event,
  ) async* {
    if (event is ToggleFavoriteMovieEvent) {
      if (event.isFavorite) {
        await deleteFavoriteMovie(MovieParams(id: event.movieEntity.id!));
      } else {
        await saveMovie(event.movieEntity);
      }
      final response =
          await checkIfFavoriteMovie(MovieParams(id: event.movieEntity.id!));
      yield response.fold(
        (l) => FavoriteMoviesError(),
        (r) => IsFavoriteMovie(r),
      );
    } else if (event is LoadFavoriteMovieEvent) {
      yield* _fetchLoadFavoriteMovies();
    } else if (event is DeleteFavoriteMovieEvent) {
      await deleteFavoriteMovie(MovieParams(id: event.movieId));
      yield* _fetchLoadFavoriteMovies();
    }else if(event is CheckIfFavoriteMovieEvent) {
      final response = await checkIfFavoriteMovie(MovieParams(id: event.movieId));
      yield response.fold((l) => FavoriteMoviesError(), (r) => IsFavoriteMovie(r));
    }
  }

  Stream<FavoriteState> _fetchLoadFavoriteMovies() async* {
    final Either<AppError, List<MovieEntity>?> response =
        await getFavoriteMovies(NoParams());
    yield response.fold(
      (l) => FavoriteMoviesError(),
      (r) => FavoriteMoviesLoaded(r!),
    );
  }
}
