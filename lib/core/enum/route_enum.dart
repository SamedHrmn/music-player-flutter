import 'package:flutter/material.dart';
import 'package:music_player/core/constants/route_constants.dart';
import 'package:music_player/features/home/home_view.dart';
import 'package:music_player/features/play_detail/play_detail_view.dart';
import 'package:music_player/main.dart';

enum RouteEnum {
  initial(RouteConstants.initialPath),
  home(RouteConstants.homeViewPath),
  playDetail(RouteConstants.playDetailViewPath);

  const RouteEnum(this.path);
  final String path;

  Widget toPage() {
    switch (this) {
      case RouteEnum.initial:
        return const InitialView();
      case RouteEnum.home:
        return const HomeView();
      case RouteEnum.playDetail:
        return const PlayDetailView();
    }
  }
}
