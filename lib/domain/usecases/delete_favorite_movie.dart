import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class DeleteFavoriteMovie extends UseCase<void, MovieParams>{
  final MovieRepository _repository;

  DeleteFavoriteMovie(this._repository);

  Future<Either<AppError,void>> call(MovieParams params) async {
    return await _repository.deleteFavoriteMovie(params.id);
  }
}