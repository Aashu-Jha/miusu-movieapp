import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_detail_entity.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';


class GetMovieDetail extends UseCase<MovieDetailEntity, MovieParams>{
  final MovieRepository repository;

  GetMovieDetail(this.repository);

  @override
  Future<Either<AppError,MovieDetailEntity>> call(MovieParams movieParams) async {
    return await repository.getMovieDetail(movieParams.id);
  }
}