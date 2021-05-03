import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/presentation/blocs/movie_tabbed/movie_tabbed_bloc.dart';
import 'package:miusu/presentation/journey/home/movie_tabbed/movie_listview_builder.dart';
import 'package:miusu/presentation/journey/home/movie_tabbed/tab_title_widget.dart';

import 'movie_tabbed_constants.dart';

class MovieTabbedWidget extends StatefulWidget {
  @override
  _MovieTabbedWidgetState createState() => _MovieTabbedWidgetState();
}

class _MovieTabbedWidgetState extends State<MovieTabbedWidget> with SingleTickerProviderStateMixin{
  MovieTabbedBloc get movieTabbedBloc =>
      BlocProvider.of<MovieTabbedBloc>(context);

  int currentIndex = 0;

  @override
  void initState() {
    super.initState();
    movieTabbedBloc.add(MovieTabChangedEvent(currentIndex: currentIndex));
  }

  @override
  void dispose() {
    super.dispose();
  }
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<MovieTabbedBloc, MovieTabbedState>(
        builder: (context, state) {
          return Padding(
              padding: EdgeInsets.only(top: Sizes.dimen_4.h),
            child: Column(
              children: <Widget>[
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  mainAxisSize: MainAxisSize.max,
                  children: <Widget>[
                    for(var i = 0; i < MovieTabbedConstants.movieTabs.length;
                      i++)
                     TabTitleWidget(
                         title: MovieTabbedConstants.movieTabs[i].title,
                         onTap:() => _onTabTapped(i),
                          isSelected: MovieTabbedConstants.movieTabs[i].index == state.currentTabIndex,
                     ),
                  ],
                ),
                if(state is MovieTabChanged)
                  Expanded(
                    child: MovieListViewBuilder(movies: state.movies!,),
                  ),
              ],
            ),
          );
          }
        );
    }
    void _onTabTapped(int index) {
      movieTabbedBloc.add(MovieTabChangedEvent(currentIndex: index));
  }
}

