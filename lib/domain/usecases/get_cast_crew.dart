import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/cast_entity.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';


class GetCast extends UseCase<List<CastEntity>, MovieParams>{
  final MovieRepository _repository;

  GetCast(this._repository);

  Future<Either<AppError,List<CastEntity>?>> call(MovieParams movieParams) async {
    return await _repository.getCastCrew(movieParams.id);
  }
}