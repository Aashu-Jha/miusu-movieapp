import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/di/get_it.dart';
import 'package:miusu/presentation/blocs/movie_backdrop/movie_backdrop_cubit.dart';
import 'package:miusu/presentation/blocs/movie_carousel/movie_carousel_cubit.dart';
import 'package:miusu/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:miusu/presentation/blocs/search_movie/search_movie_cubit.dart';
import 'package:miusu/presentation/journey/drawer/navigation_drawer.dart';
import 'package:miusu/presentation/journey/home/movie_tabbed/movie_tabbed_widget.dart';
import 'package:miusu/presentation/widgets/app_error_widget.dart';

import 'movie_carousel/movie_carousel_widget.dart';

class HomeScreen extends StatefulWidget {

  @override
  _HomeScreenState createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  late MovieCarouselCubit movieCarouselCubit;
  late MovieBackdropCubit movieBackdropCubit;
  late MovieTabbedCubit movieTabbedCubit;
  late SearchMovieCubit searchMovieCubit;

  @override
  void initState() {
    super.initState();
    movieCarouselCubit = getItInstance<MovieCarouselCubit>();
    movieBackdropCubit = movieCarouselCubit.movieBackdropCubit;
    movieTabbedCubit = getItInstance<MovieTabbedCubit>();
    searchMovieCubit = getItInstance<SearchMovieCubit>();
    movieCarouselCubit.loadCarousel();
  }

  @override
  void dispose() {
    movieCarouselCubit.close();
    movieBackdropCubit.close();
    movieTabbedCubit.close();
    searchMovieCubit.close();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return MultiBlocProvider(
      providers: [
        BlocProvider(
          create: (context) => movieCarouselCubit,
        ),
        BlocProvider(
          create: (context) => movieBackdropCubit,
        ),
        BlocProvider(
          create: (context) => movieTabbedCubit,
        ),
        BlocProvider(
          create: (context) => searchMovieCubit,
        ),
      ],
      child: Scaffold(
        drawer: const NavigationDrawer(),
        body: BlocBuilder<MovieCarouselCubit, MovieCarouselState>(
          bloc: movieCarouselCubit,
          builder: (context, state) {
            if(state is MovieCarouselLoaded) {
              return Stack(
                fit: StackFit.expand,
                children: <Widget>[
                  FractionallySizedBox(
                    alignment: Alignment.topCenter,
                    heightFactor: 0.6,
                    child: MovieCarouselWidget(
                      movies: state.movies,
                      defaultIndex: state.defaultIndex,
                    ),
                  ),
                  FractionallySizedBox(
                    alignment: Alignment.bottomCenter,
                    heightFactor: 0.4,
                    child: MovieTabbedWidget(),
                  ),
                ],
              );
            }else if(state is MovieCarouselError) {
              return AppErrorWidget(
                  appErrorType: state.errorType,
                  onPressed: () {
                    movieCarouselCubit.loadCarousel();
                  }
                  );
            }
            return SizedBox.shrink();
          } 
        ),
      ),
    );
  }
}