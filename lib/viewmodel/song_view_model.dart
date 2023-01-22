import 'dart:io';
import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

enum SongFetchState { INIT, LOADING, LOADED }

class SongViewModel extends ChangeNotifier {
  List<SongInfo> songInfos = [];
  final FlutterAudioQuery _audioQuery = FlutterAudioQuery();
  SongFetchState _state = SongFetchState.INIT;

  set state(val) {
    _state = val;
    notifyListeners();
  }

  get state => _state;

  Future fetchSongs() async {
    state = SongFetchState.LOADING;
    songInfos = await _audioQuery.getSongs();
    songInfos += songInfos + songInfos + songInfos + songInfos;
    state = SongFetchState.LOADED;
  }

  Future<int?> shuffleSongIndex() async {
    if (songInfos.isEmpty) return null;

    state = SongFetchState.LOADING;

    var rand = Random().nextInt(songInfos.length - 1);
    state = SongFetchState.LOADED;
    return rand;
  }

  File? getAlbumArtwork(SongInfo songInfo) {
    try {
      if (songInfo.albumArtwork.isEmpty) return null;
      return File.fromUri(Uri.parse(songInfo.albumArtwork));
    } catch (e) {
      return null;
    }
  }
}
