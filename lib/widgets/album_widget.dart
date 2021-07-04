import 'dart:io';

import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';

import '../core/constants/size_constants.dart';
import '../core/extension/size_extension.dart';

class AlbumUI extends StatefulWidget {
  final SongInfo songInfo;

  AlbumUI(this.songInfo);
  @override
  AlbumUIState createState() {
    return new AlbumUIState();
  }
}

class AlbumUIState extends State<AlbumUI> {
  @override
  Widget build(BuildContext context) {
    var f = widget.songInfo.albumArtwork == null ? null : new File.fromUri(Uri.parse(widget.songInfo.albumArtwork));

    return Padding(
      padding: context.paddingAllHigh,
      child: Hero(
        tag: widget.songInfo.title,
        child: f != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(SizeConstants.MEDIUM_VALUE),
                child: new Image.file(
                  f,
                  fit: BoxFit.fitWidth,
                  gaplessPlayback: true,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular((SizeConstants.HIGH_VALUE)),
                child: Image.asset(
                  "assets/artwork_placeholder.jpg",
                ),
              ),
      ),
    );
  }
}
