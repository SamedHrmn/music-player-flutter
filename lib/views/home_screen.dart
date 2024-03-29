import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:music_player/core/constants/string_constants.dart';
import 'package:music_player/utils/helper_functions.dart';
import 'package:music_player/widgets/app_text.dart';
import 'package:provider/provider.dart';

import '../viewmodel/song_view_model.dart';
import '../widgets/song_listview_widget.dart';
import 'control_panel_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key? key,
  }) : super(key: key);

  @override
  HomeScreenState createState() => HomeScreenState();
}

class HomeScreenState extends State<HomeScreen> {
  final menuController = MenuController();

  @override
  void initState() {
    super.initState();

    WidgetsBinding.instance.addPostFrameCallback((_) {
      context.read<SongViewModel>().fetchSongs();
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: ColorConstants.background,
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            Padding(
              padding: const EdgeInsets.only(left: 8, right: 8, top: 16),
              child: Row(
                children: [
                  Expanded(
                    child: header(),
                  ),
                  const _ShuffleButton(),
                ],
              ),
            ),
            Expanded(
              child: Consumer<SongViewModel>(
                builder: (context, viewmodel, child) {
                  if (viewmodel.state == SongFetchState.LOADING) {
                    return const Center(
                      child: CircularProgressIndicator(),
                    );
                  } else if (viewmodel.state == SongFetchState.LOADED && viewmodel.songInfos.isEmpty) {
                    return const Center(
                      child: AppText(text: StringConstants.noSongData),
                    );
                  } else if (viewmodel.state == SongFetchState.PERMISSION_DENIED) {
                    return const Center(
                      child: AppText(text: StringConstants.allowMediaPermission),
                    );
                  }

                  return const SongListViewWidget();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

  Column header() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        const AppText(text: StringConstants.musicPlayer, size: 32),
        SubmenuButton(
          controller: menuController,
          menuStyle: const MenuStyle(
            padding: MaterialStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          style: const ButtonStyle(
            overlayColor: MaterialStatePropertyAll(Colors.transparent),
            minimumSize: MaterialStatePropertyAll(Size.fromHeight(32)),
            padding: MaterialStatePropertyAll(EdgeInsets.zero),
          ),
          menuChildren: [
            TextButton(
              onPressed: () async {
                menuController.close();
                await HelperFunctions.instance.openPrivacyPolicyUrl();
              },
              style: const ButtonStyle(
                overlayColor: MaterialStatePropertyAll(ColorConstants.cardColor),
                padding: MaterialStatePropertyAll(EdgeInsets.symmetric(horizontal: 8)),
              ),
              child: const AppText(text: StringConstants.privacyPolicy),
            ),
          ],
          child: const AppText(
            text: StringConstants.about,
          ),
        )
      ],
    );
  }
}

class _ShuffleButton extends StatelessWidget {
  const _ShuffleButton();

  @override
  Widget build(BuildContext context) {
    return ElevatedButton(
      onPressed: () {
        final safeContext = Navigator.of(context);
        final randIndex = context.read<SongViewModel>().shuffleSongIndex();
        if (randIndex == null) return;
        safeContext.push(
          MaterialPageRoute(
            builder: (context) => ControlPanelView(
              songInfo: context.read<SongViewModel>().songInfos,
              selectedIndex: randIndex,
            ),
          ),
        );
      },
      style: ElevatedButton.styleFrom(
        backgroundColor: ColorConstants.primary,
        minimumSize: Size.zero,
        padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
      ),
      child: const Icon(
        Icons.shuffle,
        color: ColorConstants.background,
      ),
    );
  }
}
