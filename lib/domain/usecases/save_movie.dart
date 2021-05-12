import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class SaveMovie extends UseCase<void, MovieEntity>{
  final MovieRepository _repository;

  SaveMovie(this._repository);

  Future<Either<AppError,void>> call(MovieEntity params) async {
    return await _repository.saveMovie(params);
  }
}