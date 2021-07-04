import 'dart:ui';

import 'package:audio_video_progress_bar/audio_video_progress_bar.dart';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../core/constants/size_constants.dart';
import '../core/extension/size_extension.dart';
import '../core/init/notifier/audio_process_notifier.dart';
import '../widgets/album_widget.dart';
import '../widgets/blur_widget.dart';
import '../widgets/pause_button_widget.dart';
import '../widgets/play_button_widget.dart';

class ControlPanelView extends StatefulWidget {
  final SongInfo songInfo;

  const ControlPanelView({Key key, @required this.songInfo}) : super(key: key);

  @override
  _ControlPanelViewState createState() => _ControlPanelViewState();
}

class _ControlPanelViewState extends State<ControlPanelView> {
  AudioProcessNotifier _audioProcessNotifier;

  @override
  void initState() {
    super.initState();

    _audioProcessNotifier = AudioProcessNotifier(audioFilePath: widget.songInfo.filePath);
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
            Positioned.fill(
                child: Align(
              alignment: Alignment.topCenter,
              child: appBar(),
            )),
            BlurBackgroundWidget(
              songInfo: widget.songInfo,
            ),
            blurFilter(),
            Positioned.fill(
              child: Align(
                alignment: Alignment.center,
                child: playerUI(),
              ),
            ),
            Positioned.fill(
              child: Align(
                alignment: Alignment.bottomCenter,
                child: Padding(
                  padding: context.paddingAllLow,
                  child: Column(
                    mainAxisSize: MainAxisSize.min,
                    children: [_buildProgessBar(), buildPlayOrPauseMusicButton()],
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    ));
  }

  appBar() {
    return Row(
      children: [
        Expanded(
            child: Align(
          alignment: Alignment.centerLeft,
          child: IconButton(
            onPressed: () => Navigator.of(context).pop(),
            icon: Icon(Icons.arrow_back),
          ),
        )),
        Spacer()
      ],
    );
  }

  blurFilter() {
    return BackdropFilter(
      filter: ImageFilter.blur(sigmaX: 10.0, sigmaY: 10.0),
      child: Container(
        decoration: BoxDecoration(color: Colors.black87.withOpacity(0.1)),
      ),
    );
  }

  buildPlayOrPauseMusicButton() {
    return ValueListenableBuilder<ButtonState>(
      valueListenable: _audioProcessNotifier.buttonNotifier,
      builder: (context, value, child) {
        switch (value) {
          case ButtonState.paused:
            return PlayButtonWidget(onTap: _audioProcessNotifier.play);
            break;
          case ButtonState.playing:
            return PauseButtonWidget(onTap: _audioProcessNotifier.pause);
            break;
          default:
        }

        return PauseButtonWidget(onTap: () async {
          _audioProcessNotifier.pause();
          setState(() {});
        });
      },
    );
  }

  _buildProgessBar() {
    return ValueListenableBuilder<ProgressBarState>(
      valueListenable: _audioProcessNotifier.progressNotifier,
      builder: (_, value, __) => ProgressBar(
        progress: value.current,
        buffered: value.buffered,
        total: value.total,
        onSeek: _audioProcessNotifier.seek,
      ),
    );
  }

  playerUI() {
    return Column(mainAxisAlignment: MainAxisAlignment.center, mainAxisSize: MainAxisSize.min, children: [
      AlbumUI(widget.songInfo),
      Material(
        child: _buildPlayer(),
        color: Colors.transparent,
      )
    ]);
  }

  _buildPlayer() => new Container(
      padding: context.paddingAllMedium,
      child: Column(mainAxisSize: MainAxisSize.min, children: [
        Column(
          children: <Widget>[
            Text(
              widget.songInfo.title,
              style: Theme.of(context).textTheme.headline6,
              textAlign: TextAlign.center,
            ),
            Text(
              widget.songInfo.artist,
              style: Theme.of(context).textTheme.caption,
            ),
            Padding(padding: context.paddingOnlyBottom(SizeConstants.HIGH_VALUE))
          ],
        ),
      ]));
}
