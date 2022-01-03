import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/extensions/string_extensions.dart';
import 'package:miusu/presentation/blocs/movie_tabbed/movie_tabbed_cubit.dart';
import 'package:miusu/presentation/journey/home/movie_tabbed/movie_listview_builder.dart';
import 'package:miusu/presentation/journey/home/movie_tabbed/tab_title_widget.dart';
import 'package:miusu/presentation/journey/loading/loading_circle.dart';
import 'package:miusu/presentation/widgets/app_error_widget.dart';

import 'movie_tabbed_constants.dart';

class MovieTabbedWidget extends StatefulWidget {
  @override
  _MovieTabbedWidgetState createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget>{
  MovieTabbedCubit get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedCubit>(context);

  int currentTabIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedBloc.movieTabChanged(currentTabIndex);
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedCubit, MovieTabbedState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    for(var i = 0; i < MovieTabbedConstants.movieTabs.length; i++)
                     TabTitleWidget(
                         title: MovieTabbedConstants.movieTabs[i].title,
                         onTap:() {
                           _onTabTapped(i);
                         },
                          isSelected: MovieTabbedConstants.movieTabs[i].index == state.currentTabIndex,
                     ),
                  ],
                ),
                if(state is MovieTabChanged)
                  state.movies.isEmpty ?
                      Expanded(
                        child: Center(
                          child: Text(TranslationConstants.noMovies.t(context),
                            textAlign: TextAlign.center,
                            style: Theme.of(context).textTheme.subtitle1,
                          ),
                        )
                      ):
                  Expanded(
                    child: MovieListViewBuilder(movies: state.movies,),
                  ),
                if(state is MovieTabLoadError)
                  Expanded(
                    child: AppErrorWidget(
                      appErrorType: state.errorType,
                      onPressed: () {
                        movieTabbedBloc.movieTabChanged(currentTabIndex);
                      },
                    ),
                  ),
                if (state is MovieTabLoading)
                  Expanded(child: Center(
                    child: LoadingCircle(
                      size: Sizes.dimen_100.w,
                    ),
                  ),
                  ),
              ],
            ),
          );
          }
        );
    }
    void _onTabTapped(int index) {
      movieTabbedBloc.movieTabChanged(index);
  }
}

