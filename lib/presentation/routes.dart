import 'package:flutter/material.dart';
import 'package:miusu/common/constants/route_constants.dart';
import 'package:miusu/presentation/journey/favorite/favorite_screen.dart';
import 'package:miusu/presentation/journey/home/home_screen.dart';
import 'package:miusu/presentation/journey/movie_detail/movie_detail_arguments.dart';
import 'package:miusu/presentation/journey/movie_detail/movie_detail_screen.dart';
import 'package:miusu/presentation/journey/watch_videos/watch_video_arguments.dart';
import 'package:miusu/presentation/journey/watch_videos/watch_video_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
    RouteList.initial: (context) => HomeScreen(),
    RouteList.movieDetail: (context) => MovieDetailScreen(
      watchMovieArguments: setting.arguments as MovieDetailArguments,
    ),
    RouteList.watchTrailer: (context) => WatchVideoScreen(
      watchVideoArguments: setting.arguments as WatchVideoArguments,
    ),
    RouteList.favorite: (context) => FavoriteScreen(),
  };
}