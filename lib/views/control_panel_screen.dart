import 'dart:ui';
import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
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
  final List<SongInfo> songInfo;

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
        color: Theme.of(context).backgroundColor,
        child: Stack(
          fit: StackFit.expand,
          children: [
            BlurBackgroundWidget(
              songInfo: widget.songInfo[widget.selectedIndex],
            ),
            blurFilter(),
            Column(
              mainAxisAlignment: MainAxisAlignment.start,
              children: [
                Expanded(
                  flex: 5,
                  child: SongArtworkWidget(songInfo: widget.songInfo[widget.selectedIndex]),
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
        Column(
          children: <Widget>[
            Text(
              widget.songInfo[widget.selectedIndex].title,
              style: Theme.of(context).textTheme.headline6,
              maxLines: 3,
              textAlign: TextAlign.center,
            ),
            Text(
              widget.songInfo[widget.selectedIndex].artist,
              style: Theme.of(context).textTheme.caption,
              maxLines: 1,
            ),
          ],
        ),
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ControlPanelView(
              songInfo: widget.songInfo,
              selectedIndex: widget.selectedIndex != 0 ? widget.selectedIndex - 1 : widget.songInfo.length - 1,
            ),
          ));
        });
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
          Navigator.of(context).pushReplacement(MaterialPageRoute(
            builder: (context) => ControlPanelView(
              songInfo: widget.songInfo,
              selectedIndex: widget.selectedIndex != widget.songInfo.length - 1 ? widget.selectedIndex + 1 : 0,
            ),
          ));
        });
  }
}
