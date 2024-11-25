import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';

import 'package:music_player/features/home/home_view_view_model.dart';
import 'package:music_player/features/shared/domain/song.dart';
import 'package:music_player/utils/app_audio_control_manager.dart';

class PlayDetailViewModel extends ChangeNotifier {
  PlayDetailState playDetailState = PlayDetailState.initial();

  final AppAudioControlManager appAudioControlManager;

  PlayDetailViewModel({required this.appAudioControlManager});

  void _updateButtonState(ButtonState buttonState) {
    playDetailState = playDetailState.copyWith(buttonState: buttonState);
    notifyListeners();
  }

  void _updateProgressBarState(ProgressBarState progressBarState) {
    playDetailState = playDetailState.copyWith(progressBarState: progressBarState);
    notifyListeners();
  }

  void setPageInitialData({required List<Song> songList, required int selectedItemIndex}) {
    playDetailState = PlayDetailState.loading();
    notifyListeners();

    playDetailState = playDetailState = playDetailState.copyWith(
      playingSongState: Loaded(songList[selectedItemIndex]),
      songListState: Loaded(songList),
    );
    notifyListeners();
  }

  Future<void> initializePlayer() async {
    final songList = (playDetailState.songListState as Loaded<List<Song>?>).data;
    final playingSong = (playDetailState.playingSongState as Loaded<Song?>).data;

    if (songList == null || playingSong == null) return;

    final selectedSongIndex = songList.indexOf(playingSong);

    await appAudioControlManager.initializePlayer(songList: songList, initialIndex: selectedSongIndex);
  }

  void listenPlayerStateStream() {
    appAudioControlManager.playerStream().listen((playerState) async {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        _updateButtonState(ButtonState.loading);
      } else if (!isPlaying) {
        _updateButtonState(ButtonState.paused);
      } else if (processingState != ProcessingState.completed) {
        _updateButtonState(ButtonState.playing);
      } else {
        await appAudioControlManager.seek(Duration.zero);
        await appAudioControlManager.pause();
      }
    });
  }

  void listenPositionStream() {
    appAudioControlManager.positionStream().listen((position) {
      final oldState = playDetailState.progressBarState;
      _updateProgressBarState(
        ProgressBarState(
          current: position,
          buffered: oldState.buffered,
          total: oldState.total,
        ),
      );
    });
  }

  void listenDurationStream() {
    appAudioControlManager.durationStream().listen((totalDuration) {
      final oldState = playDetailState.progressBarState;
      _updateProgressBarState(
        ProgressBarState(
          current: oldState.current,
          buffered: oldState.buffered,
          total: totalDuration ?? Duration.zero,
        ),
      );
    });
  }

  void listenBufferedPositionStream() {
    appAudioControlManager.bufferedPositionStream().listen((bufferedPosition) {
      final oldState = playDetailState.progressBarState;
      _updateProgressBarState(
        ProgressBarState(
          current: oldState.current,
          buffered: bufferedPosition,
          total: oldState.total,
        ),
      );
    });
  }

  Future<void> closePlayer() async {
    await appAudioControlManager.dispose();
  }

  Future<void> seek(Duration? position) async {
    await appAudioControlManager.seek(position);
  }

  Future<void> toPrevious() async {
    await appAudioControlManager.previousSong();
  }

  Future<void> toNext() async {
    await appAudioControlManager.nextSong();
  }

  Future<void> play() async {
    await appAudioControlManager.play();
  }

  Future<void> pause() async {
    await appAudioControlManager.pause();
  }
}

class PlayDetailState {
  final PageState<List<Song>?> songListState;
  final PageState<Song?> playingSongState;
  final ButtonState buttonState;
  final ProgressBarState progressBarState;

  const PlayDetailState._({
    required this.songListState,
    required this.playingSongState,
    required this.buttonState,
    required this.progressBarState,
  });

  factory PlayDetailState.initial() => PlayDetailState._(
        songListState: Initial(),
        playingSongState: Initial(),
        buttonState: ButtonState.loading,
        progressBarState: ProgressBarState.initial(),
      );
  factory PlayDetailState.loading() => PlayDetailState._(
        songListState: Loading(),
        playingSongState: Loading(),
        buttonState: ButtonState.loading,
        progressBarState: ProgressBarState.initial(),
      );

  PlayDetailState copyWith({
    PageState<List<Song>?>? songListState,
    PageState<Song?>? playingSongState,
    ButtonState? buttonState,
    ProgressBarState? progressBarState,
  }) {
    return PlayDetailState._(
      songListState: songListState ?? this.songListState,
      playingSongState: playingSongState ?? this.playingSongState,
      buttonState: buttonState ?? this.buttonState,
      progressBarState: progressBarState ?? this.progressBarState,
    );
  }
}

class ProgressBarState {
  ProgressBarState({
    required this.current,
    required this.buffered,
    required this.total,
  });
  final Duration current;
  final Duration buffered;
  final Duration total;

  factory ProgressBarState.initial() => ProgressBarState(
        current: Duration.zero,
        buffered: Duration.zero,
        total: Duration.zero,
      );
}

enum ButtonState { paused, playing, loading }
