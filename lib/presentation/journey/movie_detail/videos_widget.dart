import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:miusu/common/constants/route_constants.dart';
import 'package:miusu/common/constants/translation_constants.dart';
import 'package:miusu/presentation/blocs/videos/videos_cubit.dart';
import 'package:miusu/presentation/journey/watch_videos/watch_video_arguments.dart';
import 'package:miusu/presentation/widgets/button.dart';

class VideosWidget extends StatelessWidget {
  final VideosCubit videosCubit;

  const VideosWidget({
    Key? key,
    required this.videosCubit,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<VideosCubit, VideosState>(
      bloc: videosCubit,
      builder: (context, state) {
        if (state is VideosLoaded && state.videos.iterator.moveNext()) {
          final _videos = state.videos;
          return Button(
            text: TranslationConstants.watchTrailers,
            onPressed: () {
              Navigator.of(context).pushNamed(RouteList.watchTrailer, arguments: WatchVideoArguments(_videos));
            },
          );
        } else {
          return const SizedBox.shrink();
        }
      },
    );
  }
}