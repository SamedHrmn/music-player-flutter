import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart' hide context;
import '../core/constants/size_constants.dart';
import '../core/extension/size_extension.dart';
import '../core/init/notifier/audio_process_notifier.dart';
import '../widgets/album_widget.dart';
import '../widgets/blur_widget.dart';
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
    return SafeArea(
        child: Scaffold(
      body: Container(
        height: context.getHeight,
        color: Theme.of(context).colorScheme.background,
        child: Stack(
          fit: StackFit.expand,
          children: [
            StreamBuilder<int?>(
                stream: _audioProcessNotifier.currentAudioIndex(),
                builder: (context, snapshot) {
                  if (snapshot.data == null) return const SizedBox();

                  return BlurBackgroundWidget(
                    songInfo: widget.songInfo[snapshot.data!],
                  );
                }),
            blurFilter(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: StreamBuilder<int?>(
                      stream: _audioProcessNotifier.currentAudioIndex(),
                      builder: (context, snapshot) {
                        if (snapshot.data == null) return const SizedBox();

                        return SongArtworkWidget(songInfo: widget.songInfo[snapshot.data!]);
                      }),
                ),
                Expanded(flex: 4, child: songTextSection()),
              ],
            ),
            Align(
              alignment: Alignment.bottomCenter,
              child: Padding(
                padding: context.paddingAllLow,
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Padding(
                      padding: context.paddingOnlyBottom(SizeConstants.LOW_VALUE),
                      child: const VolumeControlWidget(),
                    ),
                    Padding(
                      padding: context.paddingOnlyBottom(SizeConstants.MEDIUM_VALUE),
                      child: _buildProgessBar(),
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
            ),
          ],
        ),
      ),
    ));
  }

  blurFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
      ),
    );
  }

  songTextSection() => Container(
      padding: context.paddingAllMedium,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        StreamBuilder<int?>(
            stream: _audioProcessNotifier.currentAudioIndex(),
            builder: (context, snapshot) {
              if (snapshot.data == null) return const SizedBox();

              return Column(
                children: <Widget>[
                  Text(
                    widget.songInfo[snapshot.data!].title,
                    style: Theme.of(context).textTheme.titleLarge,
                    maxLines: 3,
                    textAlign: TextAlign.center,
                  ),
                  Text(
                    widget.songInfo[snapshot.data!].artist ?? '-',
                    style: Theme.of(context).textTheme.bodySmall,
                    maxLines: 1,
                  ),
                ],
              );
            }),
      ]));

  _buildProgessBar() {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _audioProcessNotifier.progressNotifier,
      builder: (_, value, __) => ProgressBar(
        thumbColor: Theme.of(context).colorScheme.secondary,
        baseBarColor: Theme.of(context).primaryColorLight,
        progressBarColor: Theme.of(context).colorScheme.secondary,
        progress: value.current,
        buffered: value.buffered,
        total: value.total,
        onSeek: _audioProcessNotifier.seek,
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
              setState(() {});
            });
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
