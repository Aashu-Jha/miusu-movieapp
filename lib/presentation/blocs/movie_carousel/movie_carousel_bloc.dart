import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/usecases/get_trending.dart';
import 'package:miusu/domain/usecases/no_params.dart';

part 'movie_carousel_event.dart';
part 'movie_carousel_state.dart';

class MovieCarouselBloc extends Bloc<MovieCarouselEvent, MovieCarouselState> {
  final GetTrending getTrending;

  MovieCarouselBloc({
    required this.getTrending,
  }) : super(MovieCarouselInitial());
  

  @override
  Stream<MovieCarouselState> mapEventToState(
    MovieCarouselEvent event,
  ) async* {
    if(event is MovieCarouselEvent) {
      final either = await getTrending(NoParams());
      yield either.fold((error) => 
        MovieCarouselError(),
         (movies) {
        return MovieCarouselLoaded(movies: movies!);
      });
    }
  }
}
