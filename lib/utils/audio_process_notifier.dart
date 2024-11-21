import 'package:flutter/material.dart';
import 'package:just_audio/just_audio.dart';
import 'package:on_audio_query/on_audio_query.dart';

class AudioProcessNotifier {
  AudioProcessNotifier({required this.selectedIndex, required this.songList}) {
    _initPlayer();
  }
  final List<SongModel> songList;
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

  List<AudioSource> getAllAudioSource() {
    final sources = <AudioSource>[];
    for (var i = 0; i < songList.length; i++) {
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

  Future<void> _initPlayer() async {
    _audioPlayer = AudioPlayer();
    await _audioPlayer?.setLoopMode(LoopMode.off);
    await _audioPlayer?.setAudioSource(ConcatenatingAudioSource(children: getAllAudioSource()), initialIndex: selectedIndex);
    await _audioPlayer?.play();

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

  Future<void> play() async {
    await _audioPlayer?.play();
  }

  Future<void> pause() async {
    await _audioPlayer?.pause();
  }

  Future<void> seek(Duration position) async {
    await _audioPlayer?.seek(position);
  }

  Future<void> dispose() async {
    await _audioPlayer?.dispose();
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
