import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/usecases/get_coming_soon.dart';
import 'package:miusu/domain/usecases/get_playing_now.dart';
import 'package:miusu/domain/usecases/get_popular.dart';
import 'file:///C:/Users/Aashish%20Jha/StudioProjects/miusu/lib/domain/entities/no_params.dart';

part 'movie_tabbed_state.dart';

class MovieTabbedCubit extends Cubit<MovieTabbedState> {
  final GetPopular getPopular;
  final GetPlayingNow getPlayingNow;
  final GetComingSoon getComingSoon;

  MovieTabbedCubit({required this.getComingSoon, required this.getPopular, required this.getPlayingNow}) : super(MovieTabbedInitial());


  void movieTabChanged(int currentTabIndex) async {
    emit(MovieTabLoading(currentTabIndex: currentTabIndex));
    Either<AppError,List<MovieEntity>?>? moviesEither;
    switch(currentTabIndex) {
      case 0:
        moviesEither = await getPopular(NoParams());
        break;
      case 1:
        moviesEither = await getPlayingNow(NoParams());
        break;
      case 2:
        moviesEither = await getComingSoon(NoParams());
        break;
    }
    emit(moviesEither!.fold(
            (l) => MovieTabLoadError(errorType: l.appErrorType , currentTabIndex: currentTabIndex),
            (movies) {
          return MovieTabChanged(
            currentTabIndex: currentTabIndex,
            movies: movies!,
          );
        }));
  }
}
