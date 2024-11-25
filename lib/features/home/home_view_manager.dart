import 'package:flutter/material.dart';
import 'package:music_player/features/home/home_view.dart';
import 'package:music_player/features/home/home_view_view_model.dart';
import 'package:music_player/utils/app_permission_manager.dart';
import 'package:provider/provider.dart';

mixin HomeViewManager on State<HomeView> {
  final menuController = MenuController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback(
      (_) async {
        await AppPermissionManager.askMediaPermission();
        if (!mounted) return;

        final isGranted = await context.read<HomeViewViewModel>().hasMediaPermission();
        if (isGranted && mounted) {
          await context.read<HomeViewViewModel>().fetchSongs();
        }
      },
    );
  }
}
