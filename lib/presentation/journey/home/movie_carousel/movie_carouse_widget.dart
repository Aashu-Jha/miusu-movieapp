import 'package:flutter/material.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/presentation/widgets/movie_appbar.dart';

import 'movie_page_view.dart';

class MovieCarouselWidget extends StatelessWidget {
  final List<MovieEntity> movies;
  final int defaultIndex;

  const MovieCarouselWidget({Key? key, required this.movies, required this.defaultIndex}) : 
    assert(defaultIndex >= 0, 'defaultIndex cannot be less than zero'),
    super(key: key);

  @override
  Widget build(BuildContext context) {
    return Column(
      children: <Widget>[
        MovieAppBar(),
        MoviePageView(
          movies: movies,
          initialPage: defaultIndex,
        ),
      ],
    );
  }
}