import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class CheckIfFavoriteMovie extends UseCase<bool, MovieParams>{
  final MovieRepository _repository;

  CheckIfFavoriteMovie(this._repository);

  Future<Either<AppError,bool>> call(MovieParams params) async {
    return await _repository.checkIfMovieFavorite(params.id);
  }
}