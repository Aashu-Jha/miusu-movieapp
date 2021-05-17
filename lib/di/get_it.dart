import 'package:get_it/get_it.dart';
import 'package:http/http.dart';
import 'package:miusu/data/core/api_client.dart';
import 'package:miusu/data/data_sources/authentication_local_data_source.dart';
import 'package:miusu/data/data_sources/authentication_remote_data_source.dart';
import 'package:miusu/data/data_sources/language_local_data_source.dart';
import 'package:miusu/data/data_sources/movie_local_data_source.dart';
import 'package:miusu/data/data_sources/movie_remote_data_source.dart';
import 'package:miusu/data/repositories/app_repository_impl.dart';
import 'package:miusu/data/repositories/authentication_repository_impl.dart';
import 'package:miusu/data/repositories/movie_repository_impl.dart';
import 'package:miusu/domain/repositories/app_repository.dart';
import 'package:miusu/domain/repositories/authentication_repository.dart';
import 'package:miusu/domain/repositories/movie_repostiory.dart';
import 'package:miusu/domain/usecases/check_if_favorite_movie.dart';
import 'package:miusu/domain/usecases/delete_favorite_movie.dart';
import 'package:miusu/domain/usecases/get_cast_crew.dart';
import 'package:miusu/domain/usecases/get_coming_soon.dart';
import 'package:miusu/domain/usecases/get_favorite_movies.dart';
import 'package:miusu/domain/usecases/get_movie_detail.dart';
import 'package:miusu/domain/usecases/get_playing_now.dart';
import 'package:miusu/domain/usecases/get_popular.dart';
import 'package:miusu/domain/usecases/get_preferred_language.dart';
import 'package:miusu/domain/usecases/get_searched_movies.dart';
import 'package:miusu/domain/usecases/get_trending.dart';
import 'package:miusu/domain/usecases/get_videos.dart';
import 'package:miusu/domain/usecases/login_user.dart';
import 'package:miusu/domain/usecases/logout_user.dart';
import 'package:miusu/domain/usecases/save_movie.dart';
import 'package:miusu/domain/usecases/update_language.dart';
import 'package:miusu/presentation/blocs/cast/cast_cubit.dart';
import 'package:miusu/presentation/blocs/favorite/favorite_cubit.dart';
import 'package:miusu/presentation/blocs/language/language_cubit.dart';
import 'package:miusu/presentation/blocs/loading/loading_cubit.dart';
import 'package:miusu/presentation/blocs/login/login_bloc.dart';
import 'package:miusu/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:miusu/presentation/blocs/movie_carousel/movie_carousel_cubit.dart';
import 'package:miusu/presentation/blocs/movie_detail/movie_detail_cubit.dart';
import 'package:miusu/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:miusu/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:miusu/presentation/blocs/videos/videos_cubit.dart';

final getItInstance = GetIt.I;

Future init() async {
  getItInstance.registerLazySingleton<Client>(() => Client());
  getItInstance
      .registerLazySingleton<ApiClient>(() => ApiClient(getItInstance()));
  getItInstance.registerLazySingleton<MovieRemoteDataSource>(
      () => MovieRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<MovieLocalDataSource>(
      () => MovieLocalDataSourceImpl());
  getItInstance.registerLazySingleton<LanguageLocalDataSource>(
      () => LanguageLocalDataSourceImpl());
  getItInstance.registerLazySingleton<AuthenticationRemoteDataSource>(
      () => AuthenticationRemoteDataSourceImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationLocalDataSource>(
      () => AuthenticationLocalDataSourceImpl());
  getItInstance
      .registerLazySingleton<GetTrending>(() => GetTrending(getItInstance()));
  getItInstance
      .registerLazySingleton<GetPopular>(() => GetPopular(getItInstance()));
  getItInstance.registerLazySingleton<GetComingSoon>(
      () => GetComingSoon(getItInstance()));
  getItInstance.registerLazySingleton<GetPlayingNow>(
      () => GetPlayingNow(getItInstance()));
  getItInstance.registerLazySingleton<MovieRepository>(
      () => MovieRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<AppRepository>(
      () => AppRepositoryImpl(getItInstance()));
  getItInstance.registerLazySingleton<AuthenticationRepository>(
      () => AuthenticationRepositoryImpl(getItInstance(), getItInstance()));
  getItInstance.registerLazySingleton<GetMovieDetail>(
      () => GetMovieDetail(getItInstance()));
  getItInstance.registerLazySingleton<GetSearchedMovies>(
      () => GetSearchedMovies(getItInstance()));
  getItInstance.registerLazySingleton<GetCast>(() => GetCast(getItInstance()));
  getItInstance
      .registerLazySingleton<GetVideos>(() => GetVideos(getItInstance()));
  getItInstance
      .registerLazySingleton<SaveMovie>(() => SaveMovie(getItInstance()));
  getItInstance.registerLazySingleton<GetFavoriteMovies>(
      () => GetFavoriteMovies(getItInstance()));
  getItInstance.registerLazySingleton<DeleteFavoriteMovie>(
      () => DeleteFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<CheckIfFavoriteMovie>(
      () => CheckIfFavoriteMovie(getItInstance()));
  getItInstance.registerLazySingleton<LoginUser>(
          () => LoginUser(getItInstance()));
  getItInstance.registerLazySingleton<LogoutUser>(
          () => LogoutUser(getItInstance()));
  getItInstance.registerLazySingleton<UpdateLanguage>(
      () => UpdateLanguage(getItInstance()));

  getItInstance.registerLazySingleton<GetPreferredLanguage>(
      () => GetPreferredLanguage(getItInstance()));

  getItInstance.registerFactory(
    () => MovieCarouselCubit(
      loadingCubit: getItInstance(),
      getTrending: getItInstance(),
      movieBackdropCubit: getItInstance(),
    ),
  );

  getItInstance.registerFactory(
    () => MovieBackdropCubit(),
  );

  getItInstance.registerFactory(() => MovieDetailCubit(
    loadingCubit: getItInstance(),
    getMovieDetail: getItInstance(),
        castCubit: getItInstance(),
        videosCubit: getItInstance(),
        favoriteCubit: getItInstance(),
      ));

  getItInstance.registerFactory(() => CastCubit(
        getItInstance(),
      ));

  getItInstance.registerFactory(() => VideosCubit(
        getVideos: getItInstance(),
      ));

  getItInstance.registerFactory(() => SearchMovieCubit(
        loadingCubit: getItInstance(),
        searchMovies: getItInstance(),
      ));

  getItInstance.registerFactory(() => MovieTabbedCubit(
        getPopular: getItInstance(),
        getPlayingNow: getItInstance(),
        getComingSoon: getItInstance(),
      ));

  getItInstance.registerSingleton<LanguageCubit>(
    LanguageCubit(
      updateLanguage: getItInstance(),
      getPreferredLanguage: getItInstance(),
    ),
  );

  getItInstance.registerFactory(() => FavoriteCubit(
        saveMovie: getItInstance(),
        getFavoriteMovies: getItInstance(),
        deleteFavoriteMovie: getItInstance(),
        checkIfFavoriteMovie: getItInstance(),
      ),
  );

  getItInstance.registerFactory(() => LoginCubit(
      loginUser: getItInstance(),
      logoutUser: getItInstance(),
    loadingCubit: getItInstance(),
    ),
  );

  getItInstance.registerSingleton<LoadingCubit>(LoadingCubit());
}
