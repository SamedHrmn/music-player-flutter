import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:music_player/features/play_detail/play_detail_view_model.dart';
import 'package:provider/provider.dart';

class SongProgressBar extends StatefulWidget {
  const SongProgressBar({super.key});

  @override
  State<SongProgressBar> createState() => _SongProgressBarState();
}

class _SongProgressBarState extends State<SongProgressBar> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<PlayDetailViewModel>().listenPositionStream();
      context.read<PlayDetailViewModel>().listenBufferedPositionStream();
      context.read<PlayDetailViewModel>().listenDurationStream();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Selector<PlayDetailViewModel, ProgressBarState>(
      selector: (p0, p1) => p1.playDetailState.progressBarState,
      builder: (_, progressBarState, __) {
        return ProgressBar(
          thumbColor: ColorConstants.lapisLazuli,
          baseBarColor: ColorConstants.nyanza,
          progressBarColor: ColorConstants.lapisLazuli,
          thumbRadius: 8,
          timeLabelTextStyle: const TextStyle(
            fontFamily: 'EvilEmpire',
            fontSize: 20,
            color: ColorConstants.wine,
          ),
          progress: progressBarState.current,
          buffered: progressBarState.buffered,
          total: progressBarState.total,
          onSeek: (position) async {
            await context.read<PlayDetailViewModel>().seek(position);
          },
        );
      },
    );
  }
}
