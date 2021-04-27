import 'dart:ffi';

import 'package:miusu/domain/entities/movie_entity.dart';

class MovieModel extends MovieEntity{
  final int id;
  final bool? video;
  final int? voteCount;
  final double? voteAverage;
  final String? title;
  final String? releaseDate;
  final String? originalLanguage;
  final String? originalTitle;
  final List<int>? genreIds;
  final String? backdropPath;
  final bool? adult;
  final String? overview;
  final String? posterPath;
  final double? popularity;
  final String? mediaType;
  
   const MovieModel({
    this.popularity,
    this.voteCount,
    this.video,
    this.posterPath,
    required this.id,
    this.adult,
    this.backdropPath,
    this.originalLanguage,
    this.originalTitle,
    this.genreIds,
    this.title,
    this.voteAverage,
    this.overview,
    this.releaseDate,
    this.mediaType,
  }): super(
    id: id,
    releaseDate: releaseDate,
    posterPath: posterPath,
    title: title,
    voteAverage: voteAverage,
    backdropPath: backdropPath
  );

  factory MovieModel.fromJson(Map<String, dynamic> json) {
    return MovieModel(
      id : json['id'],
      video : json['video'],
      voteCount : json['vote_count'],
      voteAverage :json['vote_average'].toDouble() ?? 0.0,
      title : json['title'],
      releaseDate : json['release_date'],
      originalLanguage : json['original_language'],
      originalTitle : json['original_title'],
      genreIds : json['genre_ids'].cast<int>(),
      backdropPath : json['backdrop_path'],
      adult : json['adult'],
      overview : json['overview'],
      posterPath : json['poster_path'],
      popularity : json['popularity'].toDouble() ?? 0.0,
      mediaType : json['media_type'],
    );
  }

  Map<String, dynamic> toJson() {
    final Map<String, dynamic> data = new Map<String, dynamic>();
    data['popularity'] = this.popularity;
    data['vote_count'] = this.voteCount;
    data['video'] = this.video;
    data['poster_path'] = this.posterPath;
    data['id'] = this.id;
    data['adult'] = this.adult;
    data['backdrop_path'] = this.backdropPath;
    data['original_language'] = this.originalLanguage;
    data['original_title'] = this.originalTitle;
    data['genre_ids'] = this.genreIds;
    data['title'] = this.title;
    data['vote_average'] = this.voteAverage;
    data['overview'] = this.overview;
    data['release_date'] = this.releaseDate;
    data['media_type'] = this.mediaType;
    return data;
  }
}