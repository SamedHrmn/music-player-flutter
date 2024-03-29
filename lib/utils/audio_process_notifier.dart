import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioProcessNotifier {
  final List<AudioModel> songList;
  AudioPlayer? _audioPlayer;
  final int selectedIndex;

  final progressNotifier = ValueNotifier<ProgressBarState>(
    ProgressBarState(
      current: Duration.zero,
      buffered: Duration.zero,
      total: Duration.zero,
    ),
  );
  final buttonNotifier = ValueNotifier<ButtonState>(ButtonState.playing);

  AudioProcessNotifier({required this.selectedIndex, required this.songList}) {
    _initPlayer();
  }

  List<AudioSource> getAllAudioSource() {
    List<AudioSource> sources = [];
    for (int i = 0; i < songList.length; i++) {
      if (songList[i].uri == null) continue;

      sources.add(AudioSource.uri(Uri.parse(songList[i].uri!)));
    }
    return sources;
  }

  Stream<int?>? currentAudioIndex() => _audioPlayer?.currentIndexStream;

  Future<void> nextSong() async {
    await _audioPlayer?.seekToNext();
  }

  Future<void> previousSong() async {
    await _audioPlayer?.seekToPrevious();
  }

  _initPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer?.setLoopMode(LoopMode.off);
    _audioPlayer?.setAudioSource(ConcatenatingAudioSource(children: getAllAudioSource()), initialIndex: selectedIndex);
    _audioPlayer?.play();

    _audioPlayer?.playerStateStream.listen((playerState) {
      final isPlaying = playerState.playing;
      final processingState = playerState.processingState;
      if (processingState == ProcessingState.loading || processingState == ProcessingState.buffering) {
        buttonNotifier.value = ButtonState.loading;
      } else if (!isPlaying) {
        buttonNotifier.value = ButtonState.paused;
      } else if (processingState != ProcessingState.completed) {
        buttonNotifier.value = ButtonState.playing;
      } else {
        _audioPlayer?.seek(Duration.zero);
        _audioPlayer?.pause();
      }
    });

    _audioPlayer?.positionStream.listen((position) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: position,
        buffered: oldState.buffered,
        total: oldState.total,
      );
    });

    _audioPlayer?.bufferedPositionStream.listen((bufferedPosition) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: bufferedPosition,
        total: oldState.total,
      );
    });

    _audioPlayer?.durationStream.listen((totalDuration) {
      final oldState = progressNotifier.value;
      progressNotifier.value = ProgressBarState(
        current: oldState.current,
        buffered: oldState.buffered,
        total: totalDuration ?? Duration.zero,
      );
    });
  }

  void play() async {
    _audioPlayer?.play();
  }

  void pause() {
    _audioPlayer?.pause();
  }

  void seek(Duration position) {
    _audioPlayer?.seek(position);
  }

  void dispose() {
    _audioPlayer?.dispose();
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
}

enum ButtonState { paused, playing, loading }
