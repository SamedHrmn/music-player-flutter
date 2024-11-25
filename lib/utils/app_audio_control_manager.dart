import 'package:just_audio/just_audio.dart';
import 'package:music_player/features/shared/domain/song.dart';

final class AppAudioControlManager {
  AppAudioControlManager() {
    _audioPlayer = AudioPlayer();
  }

  late final AudioPlayer _audioPlayer;

  Future<void> initializePlayer({required List<Song> songList, int? initialIndex}) async {
    await _audioPlayer.setLoopMode(LoopMode.off);
    await _audioPlayer.setAudioSource(
      ConcatenatingAudioSource(children: _prepareAudioSource(songList: songList)),
      initialIndex: initialIndex,
    );
  }

  List<AudioSource> _prepareAudioSource({required List<Song> songList}) {
    final sources = <AudioSource>[];
    for (var i = 0; i < songList.length; i++) {
      if (songList[i].uri == null) continue;

      sources.add(AudioSource.uri(Uri.parse(songList[i].uri!)));
    }
    return sources;
  }

  Stream<PlayerState> playerStream() {
    return _audioPlayer.playerStateStream;
  }

  Stream<Duration> positionStream() {
    return _audioPlayer.positionStream;
  }

  Stream<Duration?> durationStream() {
    return _audioPlayer.durationStream;
  }

  Stream<Duration> bufferedPositionStream() {
    return _audioPlayer.bufferedPositionStream;
  }

  Future<void> play() async {
    await _audioPlayer.play();
  }

  Future<void> pause() async {
    await _audioPlayer.pause();
  }

  Future<void> seek(Duration? position) async {
    await _audioPlayer.seek(position);
  }

  Future<void> dispose() async {
    await _audioPlayer.dispose();
  }

  Future<void> previousSong() async {
    await _audioPlayer.seekToPrevious();
  }

  Future<void> nextSong() async {
    await _audioPlayer.seekToNext();
  }
}
