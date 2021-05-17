import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';

import '../entities/no_params.dart';

class GetFavoriteMovies extends UseCase<List<MovieEntity>, NoParams>{
  final MovieRepository _repository;

  GetFavoriteMovies(this._repository);

  Future<Either<AppError,List<MovieEntity>>> call(NoParams noParams) async {
    return await _repository.getFavoriteMovies();
  }
}