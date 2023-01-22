import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:provider/provider.dart';

import '../core/constants/asset_constants.dart';
import '../core/constants/size_constants.dart';
import '../core/extension/size_extension.dart';
import '../viewmodel/song_view_model.dart';

class SongArtworkWidget extends StatelessWidget {
  final SongInfo songInfo;
  const SongArtworkWidget({Key? key, required this.songInfo}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: context.paddingAllHigh,
      child: Hero(
        tag: songInfo.title,
        child: context.read<SongViewModel>().getAlbumArtwork(songInfo) != null
            ? ClipRRect(
                borderRadius: BorderRadius.circular(SizeConstants.MEDIUM_VALUE),
                child: Image.file(
                  context.read<SongViewModel>().getAlbumArtwork(songInfo)!,
                  fit: BoxFit.fitWidth,
                  gaplessPlayback: true,
                ),
              )
            : ClipRRect(
                borderRadius: BorderRadius.circular((SizeConstants.HIGH_VALUE)),
                child: Image.asset(
                  AssetConstants.ARTWORK_PLACEHOLDER,
                ),
              ),
      ),
    );
  }
}
