import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:music_player/core/constants/string_constants.dart';
import 'package:music_player/features/home/home_view_manager.dart';
import 'package:music_player/features/home/home_view_view_model.dart';
import 'package:music_player/features/home/widget/header_submenu.dart';
import 'package:music_player/features/home/widget/song_grid_view.dart';
import 'package:music_player/features/shared/domain/song.dart';
import 'package:music_player/widgets/app_text.dart';
import 'package:provider/provider.dart';

class HomeView extends StatefulWidget {
  const HomeView({
    super.key,
  });

  @override
  HomeViewState createState() => HomeViewState();
}

class HomeViewState extends State<HomeView> with HomeViewManager {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Column(
          children: [
            const Padding(
              padding: EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: AppText(text: StringConstants.musicPlayer, size: 32),
                  ),
                  HeaderSubmenu(),
                ],
              ),
            ),
            Expanded(
              child: Consumer<HomeViewViewModel>(
                builder: (context, viewmodel, _) {
                  return switch (viewmodel.state.pageState) {
                    Initial() => const SizedBox(),
                    Loading() => const Center(
                        child: CircularProgressIndicator(),
                      ),
                    Error(error: final String? errorData) => Center(
                        child: AppText(text: errorData ?? StringConstants.errorGeneral),
                      ),
                    Loaded(data: final List<Song> data) => SongGridView(
                        songList: data,
                      ),
                  };
                },
              ),
            ),
          ],
        ),
      ),
    );
  }
}
