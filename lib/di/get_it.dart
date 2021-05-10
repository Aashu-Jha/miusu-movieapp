import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:miusu/data/core/api_client.dart';
import 'package:miusu/data/data_sources/movie_remote_data_source.dart';
import 'package:miusu/data/repositories/movie_repository_impl.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/get_cast_crew.dart';
import 'package:miusu/domain/usecases/get_coming_soon.dart';
import 'package:miusu/domain/usecases/get_movie_detail.dart';
import 'package:miusu/domain/usecases/get_playing_now.dart';
import 'package:miusu/domain/usecases/get_popular.dart';
import 'package:miusu/domain/usecases/get_trending.dart';
import 'package:miusu/domain/usecases/get_videos.dart';
import 'package:miusu/presentation/blocs/cast/cast_bloc.dart';
import 'package:miusu/presentation/blocs/language_bloc/language_bloc.dart';
import 'package:miusu/presentation/blocs/movie_backdrop/movie_backdrop_bloc.dart';
import 'package:miusu/presentation/blocs/movie_carousel/movie_carousel_bloc.dart';
import 'package:miusu/presentation/blocs/movie_detail/movie_detail_bloc.dart';
import 'package:miusu/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:miusu/presentation/blocs/videos/videos_bloc.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance.registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));

  getItInstance.registerFactory(() => MovieCarouselBloc(
      getTrending: getItInstance(), movieBackdropBloc: getItInstance()));

  getItInstance.registerFactory(() => MovieBackdropBloc());

  getItInstance.registerFactory(() => MovieDetailBloc(
      getMovieDetail: getItInstance(),
      castBloc: getItInstance(),
      videosBloc: getItInstance(),
    ));

  getItInstance.registerFactory(() => CastBloc(
      getItInstance(),
    ));

  getItInstance.registerFactory(() => VideosBloc(
      getVideos: getItInstance(),
  ));

  getItInstance.registerFactory(() => MovieTabbedBloc(
        getPopular: getItInstance(),
        getPlayingNow: getItInstance(),
        getComingSoon: getItInstance(),
      ));

  getItInstance.registerSingleton<LanguageBloc>(LanguageBloc());
}
