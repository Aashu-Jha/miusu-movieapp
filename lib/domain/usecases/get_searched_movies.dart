import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/entities/movie_search_params.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class GetSearchedMovies extends UseCase<List<MovieEntity>, MovieSearchParams>{
  final MovieRepository _repository;

  GetSearchedMovies(this._repository);

  Future<Either<AppError,List<MovieEntity>?>> call(MovieSearchParams searchParams) async {
    return await _repository.getSearchedMovies(searchParams.searchTerm);
  }
}