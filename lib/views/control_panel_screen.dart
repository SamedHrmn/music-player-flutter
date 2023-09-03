import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:music_player/core/constants/asset_constants.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:music_player/widgets/app_text.dart';
import 'package:on_audio_query/on_audio_query.dart' hide context;
import '../core/extension/size_extension.dart';
import '../utils/audio_process_notifier.dart';
import '../widgets/album_widget.dart';
import '../widgets/next_song_button_widget.dart';
import '../widgets/pause_button_widget.dart';
import '../widgets/play_button_widget.dart';
import '../widgets/previous_song_button_widget.dart';
import '../widgets/volume_control_widget.dart';

class ControlPanelView extends StatefulWidget {
  final int selectedIndex;
  final List<AudioModel> songInfo;

  const ControlPanelView({Key? key, required this.songInfo, required this.selectedIndex}) : super(key: key);

  @override
  _ControlPanelViewState createState() => _ControlPanelViewState();
}

class _ControlPanelViewState extends State<ControlPanelView> {
  late final AudioProcessNotifier _audioProcessNotifier;

  @override
  void initState() {
    super.initState();

    _audioProcessNotifier = AudioProcessNotifier(songList: widget.songInfo, selectedIndex: widget.selectedIndex);
  }

  @override
  void dispose() {
    _audioProcessNotifier.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Stack(
          fit: StackFit.expand,
          children: [
            detailBackground(),
            artworkAndTitle(),
            controlPanel(),
          ],
        ),
      ),
    );
  }

  Align controlPanel() {
    return Align(
      alignment: Alignment.bottomCenter,
      child: Padding(
        padding: context.paddingAllLow,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            Padding(
              padding: context.paddingOnlyBottom(8),
              child: const VolumeControlWidget(),
            ),
            Padding(
              padding: context.paddingOnlyBottom(16),
              child: buildProgessBar(),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buildPreviousMusicButton(),
                buildPlayOrPauseMusicButton(),
                buildNextMusicButton(),
              ],
            ),
          ],
        ),
      ),
    );
  }

  Column artworkAndTitle() {
    return Column(
      mainAxisAlignment: MainAxisAlignment.start,
      children: [
        StreamBuilder<int?>(
            stream: _audioProcessNotifier.currentAudioIndex(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();

              return SongArtworkWidget(songInfo: widget.songInfo[snapshot.data!]);
            }),
        Expanded(
          child: songTextSection(),
        ),
      ],
    );
  }

  Positioned detailBackground() {
    return Positioned.fill(
      child: Image.asset(
        AssetConstants.DETAIL_BACKGROUND,
        fit: BoxFit.cover,
      ),
    );
  }

  songTextSection() => Container(
        padding: context.paddingAllMedium,
        child: Column(
          mainAxisSize: MainAxisSize.min,
          children: [
            StreamBuilder<int?>(
              stream: _audioProcessNotifier.currentAudioIndex(),
              builder: (context, snapshot) {
                if (snapshot.data == null) return const SizedBox();

                return Column(
                  children: <Widget>[
                    AppText(
                      text: widget.songInfo[snapshot.data!].title,
                      maxLines: 3,
                      fontWeight: FontWeight.bold,
                      size: 24,
                      textAlign: TextAlign.center,
                    ),
                    AppText(
                      text: widget.songInfo[snapshot.data!].artist ?? '-',
                      maxLines: 1,
                    ),
                  ],
                );
              },
            ),
          ],
        ),
      );

  buildProgessBar() {
    return Padding(
      padding: context.paddingHorizontalLow,
      child: ValueListenableBuilder<ProgressBarState>(
        valueListenable: _audioProcessNotifier.progressNotifier,
        builder: (_, value, __) => ProgressBar(
          thumbColor: ColorConstants.secondary,
          baseBarColor: ColorConstants.primaryLight,
          progressBarColor: ColorConstants.secondary,
          thumbRadius: 8,
          timeLabelTextStyle: const TextStyle(
            fontFamily: 'EvilEmpire',
            fontSize: 20,
            color: ColorConstants.primary,
          ),
          progress: value.current,
          buffered: value.buffered,
          total: value.total,
          onSeek: _audioProcessNotifier.seek,
        ),
      ),
    );
  }

  buildPreviousMusicButton() {
    return PreviousSongButtonWidget(
      size: context.getHeight,
      onTap: () async {
        await _audioProcessNotifier.previousSong();
      },
    );
  }

  buildPlayOrPauseMusicButton() {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _audioProcessNotifier.buttonNotifier,
      builder: (context, value, child) {
        switch (value) {
          case ButtonState.paused:
            return PlayButtonWidget(size: context.getHeight, onTap: _audioProcessNotifier.play);

          case ButtonState.playing:
            return PauseButtonWidget(size: context.getHeight, onTap: _audioProcessNotifier.pause);

          default:
        }

        return PauseButtonWidget(
          size: context.getHeight,
          onTap: () async {
            _audioProcessNotifier.pause();
          },
        );
      },
    );
  }

  buildNextMusicButton() {
    return NextSongButtonWidget(
      size: context.getHeight,
      onTap: () async {
        await _audioProcessNotifier.nextSong();
      },
    );
  }
}
