import 'dart:io';

import 'package:flutter/material.dart';

import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../core/constants/asset_constants.dart';
import '../core/extension/size_extension.dart';
import '../viewmodel/song_view_model.dart';

class SongArtworkWidget extends StatelessWidget {
  final AudioModel songInfo;
  const SongArtworkWidget({Key? key, required this.songInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllHigh,
      child: Container(
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(64),
          boxShadow: [
            BoxShadow(
              color: Colors.black.withOpacity(0.4),
              offset: const Offset(0, 8),
              blurRadius: 20,
              spreadRadius: 5,
            ),
          ],
        ),
        child: ClipRRect(
          borderRadius: BorderRadius.circular(64),
          child: SizedBox(
            width: context.getWidth * 0.4,
            height: 320,
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
                    return Image.asset(
                      AssetConstants.ARTWORK_PLACEHOLDER,
                      fit: BoxFit.cover,
                    );
                  }

                  return Image.file(
                    snapshot.data!,
                    fit: BoxFit.cover,
                    gaplessPlayback: true,
                  );
                },
              ),
            ),
          ),
        ),
      ),
    );
  }
}
