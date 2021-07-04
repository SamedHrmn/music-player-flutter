import 'dart:io';
import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

class BlurBackgroundWidget extends StatelessWidget {
  const BlurBackgroundWidget({Key key, this.songInfo}) : super(key: key);

  final SongInfo songInfo;

  @override
  Widget build(BuildContext context) {
    return Hero(
      tag: songInfo.artist,
      child: gradientEffect(context),
    );
  }

  gradientEffect(BuildContext context) {
    return Stack(children: <Widget>[
      Container(
        decoration: BoxDecoration(
          color: Colors.transparent,
          image: DecorationImage(
            fit: BoxFit.cover,
            image: albumArtWork != null
                ? FileImage(
                    albumArtWork,
                  )
                : AssetImage(
                    'assets/background.jpg',
                  ),
          ),
        ),
      ),
      Container(
        decoration: BoxDecoration(
            gradient: LinearGradient(begin: FractionalOffset.topCenter, end: FractionalOffset.bottomCenter, colors: [
          Colors.transparent,
          Theme.of(context).canvasColor,
        ])),
      )
    ]);
  }

  get albumArtWork => songInfo.albumArtwork == null ? null : File.fromUri(Uri.parse(songInfo.albumArtwork));
}
