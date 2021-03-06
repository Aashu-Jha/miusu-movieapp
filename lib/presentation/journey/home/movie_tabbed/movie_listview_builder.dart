import 'package:flutter/cupertino.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/presentation/journey/home/movie_tabbed/movie_tab_card_widget.dart';

class MovieListViewBuilder extends StatelessWidget {
  final List<MovieEntity> movies;

  const MovieListViewBuilder({Key? key, required this.movies}) : super(key: key);
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: EdgeInsets.symmetric(vertical: Sizes.dimen_6.h),
      child: ListView.separated(
        shrinkWrap: true,
          scrollDirection: Axis.horizontal,
          itemCount: movies.length,
          itemBuilder: (context, index) {
            final MovieEntity movie = movies[index];
            return MovieTabCardWidget(
                movId: movie.id,
                title: movie.title,
                posterPath: movie.posterPath);
          },
          separatorBuilder: (context, index) {
            return SizedBox(
              width: Sizes.dimen_14.w,
            );
          },
      ),
    );
  }
}
