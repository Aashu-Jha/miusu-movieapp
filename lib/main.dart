import 'package:dartz/dartz.dart';
import 'package:flutter/material.dart';
import 'package:http/http.dart';
import 'package:miusu/data/core/api_client.dart';
import 'package:miusu/data/data_sources/movie_remote_data_source.dart';
import 'package:miusu/data/repositories/movie_repository_impl.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/get_trending.dart';
import 'package:miusu/domain/usecases/no_params.dart';

import 'domain/entities/movie_entity.dart';

Future<void> main() async {
  final ApiClient client = ApiClient(Client());
  MovieRemoteDataSource dataSource = MovieRemoteDataSourceImpl(client);
  MovieRepository movieRepository = MovieRepositoryImpl(dataSource);
  GetTrending getTrending = GetTrending(movieRepository);
  final Either<AppError, List<MovieEntity>?> eitheResponse =
      await getTrending(NoParams());
  eitheResponse.fold((l) {
    print('Error');
    print(l);
  }, (r) {
    print('Movies List');
    print(r);
  });
  runApp(MyApp());
}

class MyApp extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      title: 'Flutter Demo',
      theme: ThemeData(
        primarySwatch: Colors.blue,
      ),
      home: Container(),
    );
  }
}
