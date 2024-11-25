import 'dart:async';

import 'package:flutter/material.dart';
import 'package:music_player/features/play_detail/play_detail_view.dart';
import 'package:music_player/features/play_detail/play_detail_view_model.dart';
import 'package:music_player/features/shared/domain/song.dart';
import 'package:provider/provider.dart';

mixin PlayDetailViewManager on State<PlayDetailView> {
  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) async {
      final argsMap = ModalRoute.settingsOf(context)!.arguments;
      if (argsMap is Map) {
        final itemIndex = argsMap['itemIndex'] as int;
        final songList = argsMap['songList'] as List<Song>;

        context.read<PlayDetailViewModel>().setPageInitialData(
              songList: songList,
              selectedItemIndex: itemIndex,
            );

        await context.read<PlayDetailViewModel>().initializePlayer();

        if (!mounted) return;
        context.read<PlayDetailViewModel>().listenPlayerStateStream();
      }
    });
  }

  Future<void> toPrevious() async {
    await context.read<PlayDetailViewModel>().toPrevious();
  }

  Future<void> toNext() async {
    await context.read<PlayDetailViewModel>().toNext();
  }

  Future<void> play() async {
    await context.read<PlayDetailViewModel>().play();
  }

  Future<void> pause() async {
    await context.read<PlayDetailViewModel>().pause();
  }
}
