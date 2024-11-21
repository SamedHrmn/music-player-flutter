import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

enum SongFetchState {
  initial,
  loading,
  loaded,
  permissionDenied,
}

class SongViewModel extends ChangeNotifier {
  List<SongModel> songInfos = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();
  SongFetchState _state = SongFetchState.initial;

  set state(SongFetchState state) {
    _state = state;
    notifyListeners();
  }

  SongFetchState get state => _state;

  Future<bool> _requestAudioPermissionIfNeeded() async {
    final ifNeeded = await _audioQuery.permissionsStatus();
    if (ifNeeded) return true;

    return _audioQuery.permissionsRequest();
  }

  Future<void> fetchSongs() async {
    state = SongFetchState.loading;
    final permission = await _requestAudioPermissionIfNeeded();
    if (permission) {
      songInfos = await _audioQuery.querySongs();
      state = SongFetchState.loaded;
    } else {
      state = SongFetchState.permissionDenied;
    }
  }

  int? shuffleSongIndex() {
    if (songInfos.isEmpty) return null;

    state = SongFetchState.loading;

    final rand = Random().nextInt(songInfos.length - 1);
    state = SongFetchState.loaded;
    return rand;
  }

  Future<File?> getAlbumArtwork(SongModel audioModel) async {
    try {
      if (audioModel.albumId == null) return null;
      final artWork = await _audioQuery.queryArtwork(audioModel.albumId!, ArtworkType.ALBUM);
      if (artWork == null) return null;
      return File.fromRawPath(artWork);
    } catch (e) {
      return null;
    }
  }
}
