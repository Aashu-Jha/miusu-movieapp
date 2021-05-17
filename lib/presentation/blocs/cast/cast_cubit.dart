import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/cast_entity.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/usecases/get_cast_crew.dart';


part 'cast_state.dart';

class CastCubit extends Cubit<CastState> {
  final GetCast getCast;

  CastCubit(this.getCast) : super(CastInitial());

  void loadCast(int movieId) async {
    Either<AppError, List<CastEntity>> eitherResponse = await getCast(MovieParams(movieId));

    emit(eitherResponse.fold(
          (l) => CastError(),
          (r) => CastLoaded(casts: r),
    ));
  }
}
