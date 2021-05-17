import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'file:///C:/Users/Aashish%20Jha/StudioProjects/miusu/lib/domain/entities/no_params.dart';
import 'package:miusu/domain/usecases/usecase.dart';

class GetPlayingNow extends UseCase<List<MovieEntity>, NoParams>{
  final MovieRepository _repository;

  GetPlayingNow(this._repository);

  Future<Either<AppError,List<MovieEntity>?>> call(NoParams noParams) async {
    return await _repository.getPlayingNow();
  }
}