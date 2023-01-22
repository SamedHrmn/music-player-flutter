import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/extension/size_extension.dart';
import '../viewmodel/song_view_model.dart';
import '../widgets/custom_appbar_widget.dart';
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
      appBar: CustomAppBarWidget(
        prefferedSizeHeight: context.getHeight * 0.2,
      ),
      floatingActionButton: shuffleAndSelectRandomlyFloatingButton,
      body: SafeArea(child: Consumer<SongViewModel>(
        builder: (context, viewmodel, child) {
          if (viewmodel.state == SongFetchState.LOADING) {
            return const Center(
              child: CircularProgressIndicator(),
            );
          } else if (viewmodel.state == SongFetchState.LOADED && viewmodel.songInfos.isEmpty) {
            return const Center(
              child: Text("No song data"),
            );
          }

          return const SongListViewWidget();
        },
      )),
    );
  }

  Widget get shuffleAndSelectRandomlyFloatingButton {
    return FloatingActionButton(
      child: const Icon(Icons.shuffle),
      onPressed: () async {
        final safeContext = Navigator.of(context);
        final randIndex = await context.read<SongViewModel>().shuffleSongIndex();
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
    );
  }
}
