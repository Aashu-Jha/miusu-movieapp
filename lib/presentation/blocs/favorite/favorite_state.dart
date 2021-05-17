part of 'favorite_cubit.dart';

abstract class FavoriteState extends Equatable {
  const FavoriteState();
}

class FavoriteInitial extends FavoriteState {
  @override
  List<Object> get props => [];
}

class FavoriteMoviesLoaded extends FavoriteState {
  final List<MovieEntity> movies;

  FavoriteMoviesLoaded(this.movies);

  @override
  List<Object> get props => [movies];
}

class FavoriteMoviesError extends FavoriteState {
  @override
  List<Object> get props => [];
}

class IsFavoriteMovie extends FavoriteState {
  final bool isMovieFavorite;

  IsFavoriteMovie(this.isMovieFavorite);

  @override
  List<Object> get props => [isMovieFavorite];
}