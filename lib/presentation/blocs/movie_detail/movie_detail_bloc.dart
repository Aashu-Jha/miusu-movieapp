import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_detail_entity.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/usecases/get_movie_detail.dart';
import 'package:miusu/presentation/blocs/cast/cast_bloc.dart';
import 'package:miusu/presentation/blocs/videos/videos_bloc.dart';

part 'movie_detail_event.dart';
part 'movie_detail_state.dart';

class MovieDetailBloc extends Bloc<MovieDetailEvent, MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastBloc? castBloc;
  final VideosBloc videosBloc;

  MovieDetailBloc({required this.videosBloc, required this.castBloc, required this.getMovieDetail}) : super(MovieDetailInitial());

  @override
  Stream<MovieDetailState> mapEventToState(
    MovieDetailEvent event,
  ) async* {
    if(event is MovieDetailLoadEvent)  {
      final Either<AppError, MovieDetailEntity> eitherResponse =
          await getMovieDetail(MovieParams(id:  event.movId));

      yield eitherResponse.fold(
              (l) => MovieDetailError(),
              (r) => MovieDetailLoaded(r),
      );
      
      castBloc!.add(LoadCastEvent(movId: event.movId));
      videosBloc.add(LoadVideosEvent(movId: event.movId));
    }
  }
}
