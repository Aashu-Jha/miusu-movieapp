import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/entities/video_entity.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class GetVideos extends UseCase<List<VideoEntity>, MovieParams>{
  final MovieRepository _repository;

  GetVideos(this._repository);

  Future<Either<AppError,List<VideoEntity>>> call(MovieParams movieParams) async {
    return await _repository.getVideos(movieParams.id);
  }
}