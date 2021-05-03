import 'package:dartz/dartz.dart';
import 'package:miusu/data/data_sources/movie_remote_data_source.dart';
import 'package:miusu/data/models/movie_model.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';

class MovieRepositoryImpl extends MovieRepository {
  final MovieRemoteDataSource remoteDataSource;

  MovieRepositoryImpl(this.remoteDataSource);

  @override
  Future<Either<AppError,List<MovieModel>?>> getTrending() async {
    try{
      final movies = await remoteDataSource.getTrending();
      return Right(movies);
    }on Exception {
      return Left(AppError('Something went Wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>?>> getComingSoon() async {
    try{
      final movies = await remoteDataSource.getComingSoon();
      return Right(movies);
    }on Exception {
      return Left(AppError('Something went Wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>?>> getPlayingNow() async {
    try{
      final movies = await remoteDataSource.getPlayingNow();
      return Right(movies);
    }on Exception {
      return Left(AppError('Something went Wrong'));
    }
  }

  @override
  Future<Either<AppError, List<MovieEntity>?>> getPopular() async {
    try{
      final movies = await remoteDataSource.getPopular();
      return Right(movies);
    }on Exception {
      return Left(AppError('Something went Wrong'));
    }
  }

}