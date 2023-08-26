import 'dart:io';

import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../core/constants/asset_constants.dart';
import '../core/constants/size_constants.dart';
import '../core/extension/size_extension.dart';
import '../viewmodel/song_view_model.dart';

class SongArtworkWidget extends StatelessWidget {
  final AudioModel songInfo;
  const SongArtworkWidget({Key? key, required this.songInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllHigh,
      child: Hero(
        tag: songInfo.title,
        child: FutureBuilder<File?>(
          future: context.read<SongViewModel>().getAlbumArtwork(songInfo),
          builder: (context, snapshot) {
            if (snapshot.connectionState == ConnectionState.waiting) {
              return const Center(
                child: CircularProgressIndicator(),
              );
            } else if (snapshot.data == null && snapshot.connectionState == ConnectionState.done) {
              return ClipRRect(
                borderRadius: BorderRadius.circular((SizeConstants.HIGH_VALUE)),
                child: Image.asset(
                  AssetConstants.ARTWORK_PLACEHOLDER,
                ),
              );
            }

            return ClipRRect(
              borderRadius: BorderRadius.circular(SizeConstants.MEDIUM_VALUE),
              child: Image.file(
                snapshot.data!,
                fit: BoxFit.fitWidth,
                gaplessPlayback: true,
              ),
            );
          },
        ),
      ),
    );
  }
}
