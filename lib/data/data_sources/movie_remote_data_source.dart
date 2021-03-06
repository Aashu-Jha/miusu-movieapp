import 'package:miusu/data/core/api_client.dart';
import 'package:miusu/data/models/cast_crew_result_model.dart';
import 'package:miusu/data/models/movie_detail_model.dart';
import 'package:miusu/data/models/movie_model.dart';
import 'package:miusu/data/models/movies_result_model.dart';
import 'package:miusu/data/models/video_model.dart';
import 'package:miusu/data/models/video_result_model.dart';

abstract class MovieRemoteDataSource {
  Future<List<MovieModel>> getTrending();
  Future<List<MovieModel>> getPopular();
  Future<List<MovieModel>> getComingSoon();
  Future<List<MovieModel>> getPlayingNow();
  Future<List<MovieModel>> getSearchedMovies(String searchTerm);
  Future<MovieDetailModel> getMovieDetail(int id);
  Future<List<CastModel>> getCastCrew(int id);
  Future<List<VideoModel>> getVideos(int id);
}

class MovieRemoteDataSourceImpl extends MovieRemoteDataSource {
  final ApiClient _client;

  MovieRemoteDataSourceImpl(this._client);

  @override
  Future<List<MovieModel>> getTrending() async {
    final responseBody = await _client.get('trending/movie/day');
    final movies =  MoviesResultModel.fromJson(responseBody).movies;
    return movies;
  }

  @override
  Future<List<MovieModel>> getPopular() async {
    final responseBody = await _client.get('movie/popular');
    final movies =  MoviesResultModel.fromJson(responseBody).movies;
    // print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getComingSoon() async {
    final responseBody = await _client.get('movie/upcoming');
    final movies =  MoviesResultModel.fromJson(responseBody).movies;
    // print(movies);
    return movies;
  }

  @override
  Future<List<MovieModel>> getPlayingNow() async {
    final responseBody = await _client.get('movie/now_playing');
    final movies = MoviesResultModel.fromJson(responseBody).movies;
    // print(movies);
    return movies;
  }

  @override
  Future<MovieDetailModel> getMovieDetail(int id) async {
    final responseBody = await _client.get('movie/$id');
    final movie = MovieDetailModel.fromJson(responseBody);
    if (_isValidMovieDetail(movie)) {
      return movie;
    }
    throw Exception();
  }

  bool _isValidMovieDetail(MovieDetailModel movie) {
    return movie.id != -1 &&
        movie.title.isNotEmpty &&
        movie.posterPath.isNotEmpty;
  }

  @override
  Future<List<CastModel>> getCastCrew(int id) async {
    final responseBody = await _client.get('movie/$id/credits');
    final cast = CastCrewResultModel.fromJson(responseBody).cast;
    // print(cast);
    return cast;
  }

  @override
  Future<List<VideoModel>> getVideos(int id) async {
    final responseBody = await _client.get('movie/$id/videos');
    final videos = VideoResultModel.fromJson(responseBody).videos;
    // print(videos);
    return videos;
  }

  @override
  Future<List<MovieModel>> getSearchedMovies(String searchTerm) async {
    final responseBody = await _client.get(
        'search/movie',
      params: {
          'query': searchTerm,
      }
    );
    final movies = MoviesResultModel.fromJson(responseBody).movies;
    print(movies);
    return movies;
  }
}