import 'dart:io';

import 'package:flutter/material.dart';
import 'package:on_audio_query/on_audio_query.dart';
import 'package:provider/provider.dart';

import '../core/constants/asset_constants.dart';
import '../viewmodel/song_view_model.dart';

class BlurBackgroundWidget extends StatelessWidget {
  const BlurBackgroundWidget({Key? key, required this.songInfo}) : super(key: key);

  final AudioModel songInfo;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: songInfo.id,
      child: FutureBuilder<File?>(
        future: context.read<SongViewModel>().getAlbumArtwork(songInfo),
        builder: (context, snapshot) {
          if (snapshot.connectionState == ConnectionState.waiting) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (snapshot.data == null && snapshot.connectionState == ConnectionState.done) {
            return const _BlurGradientWidget(image: AssetImage(AssetConstants.BACKGROUND));
          }

          return _BlurGradientWidget(image: Image.file(snapshot.data!).image);
        },
      ),
    );
  }
}

class _BlurGradientWidget extends StatelessWidget {
  const _BlurGradientWidget({required this.image});

  final ImageProvider<Object> image;

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        Container(
          decoration: BoxDecoration(
            color: Colors.transparent,
            image: DecorationImage(
              fit: BoxFit.cover,
              image: image,
            ),
          ),
        ),
        Container(
          decoration: BoxDecoration(
            gradient: LinearGradient(
              begin: FractionalOffset.topCenter,
              end: FractionalOffset.bottomCenter,
              colors: [
                Colors.transparent,
                Theme.of(context).canvasColor,
              ],
            ),
          ),
        ),
      ],
    );
  }
}
