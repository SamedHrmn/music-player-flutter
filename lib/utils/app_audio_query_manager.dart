import 'dart:math';
import 'package:flutter/services.dart';
import 'package:music_player/core/constants/asset_constants.dart';
import 'package:music_player/core/utils/app_logger.dart';
import 'package:on_audio_query/on_audio_query.dart';

final class AppAudioQueryManager {
  AppAudioQueryManager() {
    _onAudioQuery = OnAudioQuery();
  }

  late final OnAudioQuery _onAudioQuery;

  Future<List<SongModel>?> fetchAudioFiles() async {
    try {
      final songs = await _onAudioQuery.querySongs();
      return songs;
    } catch (e) {
      AppLogger.debugLog(msg: e.toString());
      return null;
    }
  }

  Future<Uint8List> getAlbumArtwork(int id) async {
    return _loadAssetFromBundle(_generateArtworkFromAsset());
  }

  Future<Uint8List> _loadAssetFromBundle(String assetPath) async {
    final data = await rootBundle.load(assetPath);
    return data.buffer.asUint8List();
  }

  String _generateArtworkFromAsset() {
    const artworkAssets = [
      AssetConstants.cover1,
      AssetConstants.cover2,
      AssetConstants.cover3,
      AssetConstants.cover4,
      AssetConstants.cover5,
      AssetConstants.cover6,
      AssetConstants.cover7,
      AssetConstants.cover8,
      AssetConstants.cover9,
      AssetConstants.cover10,
      AssetConstants.cover11,
      AssetConstants.cover12,
      AssetConstants.cover13,
      AssetConstants.cover14,
      AssetConstants.cover15,
      AssetConstants.cover16,
      AssetConstants.cover17,
      AssetConstants.cover18,
    ];

    final rand = Random().nextInt(artworkAssets.length);
    return artworkAssets[rand];
  }
}
