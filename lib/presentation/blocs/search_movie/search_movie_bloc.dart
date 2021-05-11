import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/entities/movie_search_params.dart';
import 'package:miusu/domain/usecases/get_searched_movies.dart';

part 'search_movie_event.dart';

part 'search_movie_state.dart';

class SearchMovieBloc extends Bloc<SearchMovieEvent, SearchMovieState> {
  final GetSearchedMovies searchMovies;

  SearchMovieBloc({required this.searchMovies}) : super(SearchMovieInitial());

  @override
  Stream<SearchMovieState> mapEventToState(SearchMovieEvent event,) async* {
    if (event is SearchTermChangedEvent) {
      if (event.searchTerm.length > 2) {
        yield SearchMovieLoading();
        final Either<AppError,
            List<MovieEntity>?> response = await searchMovies(
            MovieSearchParams(event.searchTerm)); 

        yield response.fold((l) => SearchMovieError(l.appErrorType), (r) => SearchMovieLoaded(r!));
      }
    }
  }
}
