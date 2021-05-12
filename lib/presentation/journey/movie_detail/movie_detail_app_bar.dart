import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/sizes.dart';
import 'package:miusu/common/extensions/size_extensions.dart';
import 'package:miusu/domain/entities/movie_detail_entity.dart';
import 'package:miusu/domain/entities/movie_entity.dart';
import 'package:miusu/presentation/blocs/favorite/favorite_bloc.dart';

class MovieDetailAppBar extends StatelessWidget {
  final MovieDetailEntity movieDetailEntity;

  const MovieDetailAppBar({Key? key, required this.movieDetailEntity}) : super(key: key);

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
        BlocBuilder<FavoriteBloc, FavoriteState>(
            builder: (context, state) {
              if (state is IsFavoriteMovie) {
                return GestureDetector(
                  onTap: () {
                    BlocProvider.of<FavoriteBloc>(context).add(
                      ToggleFavoriteMovieEvent(
                          movieEntity: MovieEntity.fromMovieDetailEntity(movieDetailEntity), isFavorite: state.isMovieFavorite),);
                  },
                  child: Icon(
                    state.isMovieFavorite ? Icons.favorite : Icons
                        .favorite_border,
                    color: Colors.white,
                    size: Sizes.dimen_12.h,
                  ),
                );
              } else {
                return GestureDetector(
                  onTap: () {

                  },
                  child: Icon(
                    Icons.favorite_border,
                    color: Colors.white,
                    size: Sizes.dimen_12.h,
                  ),
                );
              }
            }
        ),
      ],
    );
  }
}
