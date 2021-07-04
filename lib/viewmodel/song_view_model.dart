import 'dart:math';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

enum SongFetchState { LOADING, LOADED }

class SongViewModel extends ChangeNotifier {
  List<SongInfo> songInfos = [];
  FlutterAudioQuery _audioQuery = FlutterAudioQuery();
  SongFetchState _state;

  set state(val) {
    _state = val;
    notifyListeners();
  }

  get state => _state;

  Future fetchSongs() async {
    state = SongFetchState.LOADING;
    songInfos = await _audioQuery.getSongs();
    state = SongFetchState.LOADED;
  }

  Future shuffleSongAndSelectRandomly() async {
    state = SongFetchState.LOADING;
    if (songInfos != null) {
      var rand = Random().nextInt(songInfos.length - 1);
      state = SongFetchState.LOADED;
      return songInfos[rand];
    }
  }
}
