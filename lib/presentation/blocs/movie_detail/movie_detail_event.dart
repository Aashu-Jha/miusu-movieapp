part of 'movie_detail_bloc.dart';

abstract class MovieDetailEvent extends Equatable {
  const MovieDetailEvent();
}

class MovieDetailLoadEvent extends MovieDetailEvent {
  final int movId;

  const MovieDetailLoadEvent(this.movId);

  @override
  List<Object?> get props => [movId];
}
