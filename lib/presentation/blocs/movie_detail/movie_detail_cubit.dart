import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_detail_entity.dart';
import 'package:miusu/domain/entities/movie_params.dart';
import 'package:miusu/domain/usecases/get_movie_detail.dart';
import 'package:miusu/presentation/blocs/cast/cast_cubit.dart';
import 'package:miusu/presentation/blocs/favorite/favorite_cubit.dart';
import 'package:miusu/presentation/blocs/loading/loading_cubit.dart';
import 'package:miusu/presentation/blocs/videos/videos_cubit.dart';

part 'movie_detail_state.dart';

class MovieDetailCubit extends Cubit<MovieDetailState> {
  final GetMovieDetail getMovieDetail;
  final CastCubit castCubit;
  final VideosCubit videosCubit;
  final FavoriteCubit favoriteCubit;
  final LoadingCubit loadingCubit;

  MovieDetailCubit({required this.loadingCubit, required this.favoriteCubit, required this.videosCubit, required this.castCubit, required this.getMovieDetail}) : super(MovieDetailInitial());

  void loadMovieDetail(int movieId) async {
    loadingCubit.show();
    final Either<AppError, MovieDetailEntity> eitherResponse =
    await getMovieDetail(
      MovieParams(movieId),
    );

    emit(eitherResponse.fold(
          (l) => MovieDetailError(),
          (r) => MovieDetailLoaded(r),
    ));

    favoriteCubit.checkIfMovieFavorite(movieId);
    castCubit.loadCast(movieId);
    videosCubit.loadVideos(movieId);
    loadingCubit.hide();
  }
}
