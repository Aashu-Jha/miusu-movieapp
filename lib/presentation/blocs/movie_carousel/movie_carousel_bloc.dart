import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/usecases/get_trending.dart';
import 'package:miusu/domain/usecases/no_params.dart';
import 'package:miusu/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropBloc movieBackdropBloc;

  MovieCarouselBloc({
    required this.getTrending,
    required this.movieBackdropBloc,
  }) : super(MovieCarouselInitial());
  

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if(event is CarouselLoadEvent) {
      final either = await getTrending(NoParams());
      yield either.fold((error) => 
        MovieCarouselError(),
         (movies) {
           movieBackdropBloc.add(MovieBackdropChangedEvent(movies![event.defaultIndex]));
        return MovieCarouselLoaded(movies: movies, defaultIndex: event.defaultIndex);
      });
    }
  }
}
