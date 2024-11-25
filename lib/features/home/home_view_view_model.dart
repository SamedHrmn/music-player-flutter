import 'dart:math';

import 'package:flutter/material.dart';
import 'package:music_player/core/constants/string_constants.dart';
import 'package:music_player/features/shared/domain/song.dart';
import 'package:music_player/utils/app_audio_query_manager.dart';
import 'package:music_player/utils/app_permission_manager.dart';

class HomeViewViewModel extends ChangeNotifier {
  HomeViewViewModel({required this.appAudioManager});

  final AppAudioQueryManager appAudioManager;

  HomeState<List<Song>> state = HomeState(pageState: Initial());

  void _updatePageState(PageState<List<Song>>? newPageState) {
    state = state.copyWith(pageState: newPageState);
    notifyListeners();
  }

  void _updatePlayingState(Song? song) {
    state = state.copyWith(playingSong: song);
    notifyListeners();
  }

  Future<void> fetchSongs() async {
    _updatePageState(Loading());
    final data = await appAudioManager.fetchAudioFiles();
    if (data == null) {
      _updatePageState(const Error('Error during fetching'));
      return;
    }

    final songList = <Song>[];
    for (final element in data) {
      if (element.uri == null) continue;

      final artwork = await appAudioManager.getAlbumArtwork(element.id);
      var songModel = Song.fromSongModel(element);
      songModel = songModel.copyWith(artwork: artwork);
      songList.add(songModel);
    }

    _updatePageState(Loaded(songList));
  }

  void shuffleAndPlay() {
    if (state.pageState is Loaded<List<Song>>) {
      final loadedState = state.pageState as Loaded<List<Song>>;
      final songList = loadedState.data;

      final rand = Random().nextInt(songList.length);
      _updatePlayingState(songList[rand]);
    }
  }

  Future<void> askMediaPermission() async {
    _updatePageState(Loading());
    await AppPermissionManager.askMediaPermission();

    final isGranted = await AppPermissionManager.isGrantedMediaPermission();
    if (!isGranted) {
      _updatePageState(const Error(StringConstants.allowMediaPermission));
    }
  }

  Future<bool> hasMediaPermission() async {
    return AppPermissionManager.isGrantedMediaPermission();
  }
}

class HomeState<T> {
  const HomeState({
    required this.pageState,
    this.playingSong,
  });

  final PageState<T> pageState;
  final Song? playingSong;

  HomeState<T> copyWith({
    PageState<T>? pageState,
    Song? playingSong,
  }) {
    return HomeState(
      pageState: pageState ?? this.pageState,
      playingSong: playingSong ?? this.playingSong,
    );
  }
}

sealed class PageState<T> {
  const PageState();
}

class Initial<T> extends PageState<T> {}

class Loading<T> extends PageState<T> {}

class Loaded<T> extends PageState<T> {
  const Loaded(this.data);
  final T data;
}

class Error<T> extends PageState<T> {
  const Error(this.error);
  final String? error;
}
