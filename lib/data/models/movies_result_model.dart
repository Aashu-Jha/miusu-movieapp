import 'movie_model.dart';

class MoviesResultModel {
  final List<MovieModel> movies;

  MoviesResultModel({required this.movies});

  factory MoviesResultModel.fromJson(Map<String, dynamic> json) {
    List<MovieModel> tempMovies = [];
    if (json['results'] != null) {
      json['results'].forEach((v) {
        tempMovies.add(MovieModel.fromJson(v));
      });
    }

    return MoviesResultModel(movies: tempMovies);
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['results'] = this.movies.map((v) => v.toJson()).toList();
    return data;
  }
}