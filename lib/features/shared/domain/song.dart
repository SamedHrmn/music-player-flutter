import 'dart:typed_data';

import 'package:on_audio_query/on_audio_query.dart';

class Song {
  const Song({
    required this.title,
    required this.album,
    required this.id,
    required this.artist,
    required this.uri,
    required this.artwork,
  });

  final String title;
  final String? album;
  final String? artist;
  final String? uri;
  final int id;
  final Uint8List? artwork;

  factory Song.fromSongModel(SongModel model) {
    return Song(
      title: model.title,
      album: model.album,
      id: model.id,
      artist: model.artist,
      uri: model.uri,
      artwork: null,
    );
  }

  Song copyWith({
    String? title,
    String? album,
    int? id,
    String? artist,
    String? uri,
    Uint8List? artwork,
  }) {
    return Song(
      title: title ?? this.title,
      album: album ?? this.album,
      id: id ?? this.id,
      uri: uri ?? this.uri,
      artist: artist ?? this.artist,
      artwork: artwork ?? this.artwork,
    );
  }
}
