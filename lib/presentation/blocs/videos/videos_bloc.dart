import 'dart:async';
import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/entities/video_entity.dart';
import 'package:miusu/domain/usecases/get_videos.dart';

part 'videos_event.dart';

part 'videos_state.dart';

class VideosBloc extends Bloc<VideosEvent, VideosState> {
  final GetVideos getVideos;

  VideosBloc({required this.getVideos}) : super(VideosInitial());

  @override
  Stream<VideosState> mapEventToState(
    VideosEvent event,
  ) async* {
    if (event is LoadVideosEvent) {
      Either<AppError, List<VideoEntity>?> eitherResponse =
          await getVideos(MovieParams(id: event.movId));
      yield eitherResponse.fold(
        (l) => NoVideos(),
        (r) => VideosLoaded(videos: r!),
      );
    }
  }
}
