import 'package:flutter/material.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/common/screenutil/screen_util.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/presentation/journey/home/movie_carousel/movie_card_widget.dart';

class MoviePageView extends StatefulWidget {
  final List<MovieEntity> movies;
  final int initialPage;

  const MoviePageView({
    required this.movies,
    required this.initialPage,
  }): assert(initialPage >= 0, 'InitialPage cannot be less than zero');

  @override
  _MoviePageViewState createState() => _MoviePageViewState();
}

class _MoviePageViewState extends State<MoviePageView> {
  late PageController _pageController;

  @override
  void initState() {
    super.initState();
    _pageController = PageController(
      initialPage: widget.initialPage,
      keepPage: false,
      viewportFraction: 0.7
    );
  }

  @override
  void dispose() { 
    _pageController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: EdgeInsets.symmetric(vertical: Sizes.dimen_10.h),
      height: ScreenUtil.screenHeight * 0.35,
      child: PageView.builder(
        itemBuilder: (BuildContext context, int index) { 
          final MovieEntity movie = widget.movies[index];
            return MovieCardWidget(
              movId: movie.id!, 
              posterPath: movie.posterPath!
            );
         },
        pageSnapping: true,
        itemCount: widget.movies.length,
      ),
    );
  }
}