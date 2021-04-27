import 'package:dartz/dartz.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';

abstract class MovieRepository {
  Future<Either<AppError,List<MovieEntity>?>> getTrending();
  Future<Either<AppError,List<MovieEntity>?>> getPopular();
  Future<Either<AppError,List<MovieEntity>?>> getComingSoon();
  Future<Either<AppError,List<MovieEntity>?>> getPlayingNow();
}