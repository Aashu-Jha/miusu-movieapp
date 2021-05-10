part of 'cast_bloc.dart';

abstract class CastEvent extends Equatable {
  const CastEvent();
}

class LoadCastEvent extends CastEvent {
  final int movId;

  const LoadCastEvent({required this.movId});

  @override
  List<Object?> get props => [movId];

}