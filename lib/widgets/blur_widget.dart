import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

import '../core/constants/asset_constants.dart';
import '../viewmodel/song_view_model.dart';

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
            image: context.read<SongViewModel>().getAlbumArtwork(songInfo) != null
                ? FileImage(
                    context.read<SongViewModel>().getAlbumArtwork(songInfo),
                  )
                : AssetImage(AssetConstants.BACKGROUND),
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
}
