import 'package:bloc/bloc.dart';
import 'package:dartz/dartz.dart';
import 'package:equatable/equatable.dart';
import 'package:miusu/domain/entities/app_error.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/domain/entities/movie_search_params.dart';
import 'package:miusu/domain/usecases/get_searched_movies.dart';
import 'package:miusu/presentation/blocs/loading/loading_cubit.dart';


part 'search_movie_state.dart';

class SearchMovieCubit extends Cubit<SearchMovieState> {
  final GetSearchedMovies searchMovies;
  final LoadingCubit loadingCubit;


  SearchMovieCubit({required this.searchMovies, required this.loadingCubit}) : super(SearchMovieInitial());

  void searchTermChanged(String searchTerm) async {
    loadingCubit.show();
    if (searchTerm.length > 2) {
      emit(SearchMovieLoading());
      final Either<AppError,
          List<MovieEntity>?> response = await searchMovies(
          MovieSearchParams(searchTerm));

      emit(response.fold((l) => SearchMovieError(l.appErrorType), (r) => SearchMovieLoaded(r!)));
    }
    loadingCubit.hide();
  }
}
