import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/usecases/get_coming_soon.dart';
import 'package:miusu/domain/usecases/get_playing_now.dart';
import 'package:miusu/domain/usecases/get_popular.dart';
import 'package:miusu/domain/usecases/no_params.dart';

part 'movie_tabbed_event.dart';
part 'movie_tabbed_state.dart';

class MovieTabbedBloc extends Bloc<MovieTabbedEvent, MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabbedBloc({required this.getComingSoon, required this.getPopular, required this.getPlayingNow}) : super(MovieTabbedInitial());

  @override
  Stream<MovieTabbedState> mapEventToState(
    MovieTabbedEvent event,
  ) async* {
    if(event is MovieTabChangedEvent) {
      Either<AppError,List<MovieEntity>?>? moviesEither;
      switch(event.currentIndex) {
        case 0:
          moviesEither = await getPopular(NoParams());
          break;
        case 1:
          moviesEither = await getPlayingNow(NoParams());
          break;
        case 2:
          moviesEither = await getComingSoon(NoParams());
          break;
      }
      yield moviesEither!.fold(
              (l) => MovieTabLoadError(event.currentIndex),
              (movies) {
        return MovieTabChanged(
          currentTabIndex: event.currentIndex,
          movies: movies,
        );
      });
    }
  }
}
