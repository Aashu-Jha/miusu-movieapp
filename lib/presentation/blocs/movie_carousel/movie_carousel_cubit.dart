import 'package:bloc/bloc.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/usecases/get_trending.dart';
import 'package:miusu/presentation/blocs/loading/loading_cubit.dart';
import 'file:///C:/Users/Aashish%20Jha/StudioProjects/miusu/lib/domain/entities/no_params.dart';
import 'package:miusu/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';


part 'movie_carousel_state.dart';

class MovieCarouselCubit extends Cubit<MovieCarouselState> {
  final GetTrending getTrending;
  final MovieBackdropCubit movieBackdropCubit;
  final LoadingCubit loadingCubit;


  MovieCarouselCubit({
    required this.loadingCubit,
    required this.getTrending,
    required this.movieBackdropCubit,
  }) : super(MovieCarouselInitial());

  void loadCarousel({int defaultIndex = 0}) async {
    loadingCubit.show();
    final moviesEither = await getTrending(NoParams());
    emit(moviesEither.fold(
          (l) => MovieCarouselError(l.appErrorType),
          (movies) {
        movieBackdropCubit.backDropChanged(movies[defaultIndex]);
        return MovieCarouselLoaded(
          movies: movies,
          defaultIndex: defaultIndex,
        );
      },
    ));
    loadingCubit.hide();
  }
}
