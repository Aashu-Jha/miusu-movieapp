import 'package:flutter/material.dart';
import 'package:miusu/common/constants/route_constants.dart';
import 'journey/favorite/favorite_screen.dart';
import 'journey/home/home_screen.dart';
import 'journey/movie_detail/movie_detail_arguments.dart';
import 'journey/movie_detail/movie_detail_screen.dart';
import 'journey/watch_videos/watch_video_arguments.dart';
import 'journey/watch_videos/watch_video_screen.dart';
import 'journey/login/login_screen.dart';

class Routes {
  static Map<String, WidgetBuilder> getRoutes(RouteSettings setting) => {
    RouteList.initial: (context) => LoginScreen(),
    RouteList.home: (context) => HomeScreen(),
    RouteList.movieDetail: (context) => MovieDetailScreen(
      watchMovieArguments: setting.arguments as MovieDetailArguments,
    ),
    RouteList.watchTrailer: (context) => WatchVideoScreen(
      watchVideoArguments: setting.arguments as WatchVideoArguments,
    ),
    RouteList.favorite: (context) => FavoriteScreen(),
  };
}