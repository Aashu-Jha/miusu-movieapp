part of 'videos_bloc.dart';

abstract class VideosEvent extends Equatable {
  const VideosEvent();
}

class LoadVideosEvent extends VideosEvent {
  final int movId;

  LoadVideosEvent({required this.movId});

  @override
  List<Object?> get props => [movId];
}
