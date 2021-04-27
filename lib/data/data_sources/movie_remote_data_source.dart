import 'package:miusu/data/core/api_client.dart';
import 'package:miusu/data/models/movie_model.dart';
import 'package:miusu/data/models/movies_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>?> getTrending();
  Future<List<MovieModel>?> getPopular();
  Future<List<MovieModel>?> getComingSoon();
  Future<List<MovieModel>?> getPlayingNow();
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>?> getTrending() async {
    final responseBody = await _client.get('trending/movie/day');
    final movies =  MoviesResultModel.fromJson(responseBody).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>?> getPopular() async {
    final responseBody = await _client.get('movie/popular');
    final movies =  MoviesResultModel.fromJson(responseBody).movies;
    // print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>?> getComingSoon() async {
    final responseBody = await _client.get('movie/upcoming');
    final movies =  MoviesResultModel.fromJson(responseBody).movies;
    // print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>?> getPlayingNow() async {
    final responseBody = await _client.get('movie/now_playing');
    final movies = MoviesResultModel.fromJson(responseBody).movies;
    // print(movies);
    return movies;
  }
}