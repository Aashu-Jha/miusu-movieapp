import 'dart:async';

import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/cast_entity.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/usecases/get_cast_crew.dart';

part 'cast_event.dart';

part 'cast_state.dart';

class CastBloc extends Bloc<CastEvent, CastState> {
  final GetCast getCast;

  CastBloc(this.getCast) : super(CastInitial());

  @override
  Stream<CastState> mapEventToState(
    CastEvent event,
  ) async* {
    if (event is LoadCastEvent) {
      Either<AppError, List<CastEntity>?> eitherResponse =
          await getCast(MovieParams(id: event.movId));
      yield eitherResponse.fold(
        (l) => CastError(),
        (r) => CastLoaded(casts: r),
      );

      
    }
  }
}
