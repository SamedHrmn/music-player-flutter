import 'package:flutter/material.dart';
import 'package:music_player/core/constants/string_constants.dart';
import 'package:music_player/core/extension/size_extension.dart';
import 'package:music_player/features/home/home_view_view_model.dart';
import 'package:music_player/features/play_detail/play_detail_view_manager.dart';
import 'package:music_player/features/play_detail/play_detail_view_model.dart';
import 'package:music_player/features/play_detail/widget/song_progress_bar.dart';
import 'package:music_player/features/shared/domain/song.dart';
import 'package:music_player/widgets/app_text.dart';
import 'package:music_player/widgets/next_song_button_widget.dart';
import 'package:music_player/widgets/pause_button_widget.dart';
import 'package:music_player/widgets/play_button_widget.dart';
import 'package:music_player/widgets/previous_song_button_widget.dart';
import 'package:music_player/widgets/volume_control_widget.dart';
import 'package:provider/provider.dart';

class PlayDetailView extends StatefulWidget {
  const PlayDetailView({super.key});

  @override
  State<PlayDetailView> createState() => _PlayDetailViewState();
}

class _PlayDetailViewState extends State<PlayDetailView> with PlayDetailViewManager {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            artworkAndTitle(),
            controlPanel(),
          ],
        ),
      ),
    );
  }

  Widget artworkAndTitle() {
    return Consumer<PlayDetailViewModel>(
      builder: (context, viewmodel, _) {
        return switch (viewmodel.playDetailState.playingSongState) {
          Initial() => const SizedBox(),
          Loading() => const Center(
              child: CircularProgressIndicator(),
            ),
          Error(error: final String? errorData) => Center(
              child: AppText(text: errorData ?? StringConstants.errorGeneral),
            ),
          Loaded(data: final Song? playingSong) => Column(
              children: [
                Hero(
                  key: Key(playingSong!.id.toString()),
                  tag: 'artwork${playingSong.id}',
                  child: Image.memory(
                    playingSong.artwork!,
                    height: context.getHeight * 0.6,
                    width: double.maxFinite,
                    fit: BoxFit.cover,
                  ),
                ),
                AppText(
                  text: playingSong.title,
                  maxLines: 3,
                  fontWeight: FontWeight.bold,
                  size: 24,
                  textAlign: TextAlign.center,
                ),
                AppText(
                  text: playingSong.artist ?? '-',
                  maxLines: 1,
                ),
              ],
            ),
        };
      },
    );
  }

  Widget controlPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: context.paddingAllLow,
        child: Selector<PlayDetailViewModel, PageState<Song?>>(
          selector: (p0, p1) => p1.playDetailState.playingSongState,
          builder: (context, playingSong, _) {
            return switch (playingSong) {
              Initial() => const SizedBox(),
              Loading() => const Center(
                  child: CircularProgressIndicator(),
                ),
              Error(error: final String? errorData) => Center(
                  child: AppText(text: errorData ?? StringConstants.errorGeneral),
                ),
              Loaded(data: final Song? _) => Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: context.paddingOnlyBottom(8),
                      child: const VolumeControlWidget(),
                    ),
                    Padding(
                      padding: context.paddingOnlyBottom(16),
                      child: buildProgressBar(),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        PreviousSongButtonWidget(
                          size: 32,
                          onTap: () async {
                            await toPrevious();
                          },
                        ),
                        buildPlayOrPauseMusicButton(),
                        NextSongButtonWidget(
                          size: 32,
                          onTap: toNext,
                        ),
                      ],
                    ),
                  ],
                ),
            };
          },
        ),
      ),
    );
  }

  Widget buildProgressBar() {
    return Padding(
      padding: context.paddingHorizontalLow,
      child: const SongProgressBar(),
    );
  }

  Widget buildPlayOrPauseMusicButton() {
    return Selector<PlayDetailViewModel, ButtonState>(
      selector: (p0, p1) => p1.playDetailState.buttonState,
      builder: (context, buttonState, _) {
        switch (buttonState) {
          case ButtonState.loading:
            return const SizedBox();
          case ButtonState.paused:
            return PlayButtonWidget(
              onTap: play,
            );
          case ButtonState.playing:
            return PauseButtonWidget(
              onTap: pause,
            );
        }
      },
    );
  }
}
