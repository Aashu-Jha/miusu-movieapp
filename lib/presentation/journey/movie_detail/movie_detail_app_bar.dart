import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/domain/entities/movie_detail_entity.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/presentation/blocs/favorite/favorite_cubit.dart';

class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailAppBar({Key? key, required this.movieDetailEntity})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        GestureDetector(
          onTap: () {
            Navigator.of(context).pop();
          },
          child: Icon(
            Icons.arrow_back_ios,
            color: Colors.white,
            size: Sizes.dimen_12.h,
          ),
        ),
        BlocBuilder<FavoriteCubit, FavoriteState>(builder: (context, state) {
          if (state is IsFavoriteMovie) {
            return GestureDetector(
              onTap: () =>
                BlocProvider.of<FavoriteCubit>(context).toggleFavoriteMovie(
                    MovieEntity.fromMovieDetailEntity(movieDetailEntity),
                    state.isMovieFavorite),
              child: Icon(
                state.isMovieFavorite ? Icons.favorite : Icons.favorite_border,
                color: Colors.white,
                size: Sizes.dimen_12.h,
              ),
            );
          } else {
            return Icon(
              Icons.favorite_border,
              color: Colors.white,
              size: Sizes.dimen_12.h,
            );
          }
        }),
      ],
    );
  }
}
