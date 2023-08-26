import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';

enum SongFetchState {
  INIT,
  LOADING,
  LOADED,
  PERMISSION_DENIED,
}

class SongViewModel extends ChangeNotifier {
  List<AudioModel> songInfos = [];
  final OnAudioQuery _audioQuery = OnAudioQuery();
  SongFetchState _state = SongFetchState.INIT;

  set state(val) {
    _state = val;
    notifyListeners();
  }

  get state => _state;

  Future<bool> _requestAudioPermissionIfNeeded() async {
    final ifNeeded = await _audioQuery.permissionsStatus();
    if (ifNeeded) return true;

    return _audioQuery.permissionsRequest();
  }

  Future<void> fetchSongs() async {
    state = SongFetchState.LOADING;
    final permission = await _requestAudioPermissionIfNeeded();
    if (permission) {
      songInfos = await _audioQuery.querySongs();
      state = SongFetchState.LOADED;
    } else {
      state = SongFetchState.PERMISSION_DENIED;
    }
  }

  int? shuffleSongIndex() {
    if (songInfos.isEmpty) return null;

    state = SongFetchState.LOADING;

    var rand = Random().nextInt(songInfos.length - 1);
    state = SongFetchState.LOADED;
    return rand;
  }

  Future<File?> getAlbumArtwork(AudioModel audioModel) async {
    try {
      if (audioModel.albumId == null) return null;
      final artWork = await _audioQuery.queryArtwork(audioModel.albumId!, ArtworkType.ALBUM);
      if (artWork?.artwork == null) return null;
      return File.fromRawPath(artWork!.artwork!);
    } catch (e) {
      return null;
    }
  }
}
