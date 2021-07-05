import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/extension/size_extension.dart';
import '../viewmodel/song_view_model.dart';
import '../widgets/custom_appbar_widget.dart';
import '../widgets/song_listview_widget.dart';
import 'control_panel_screen.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({
    Key key,
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
          if (viewmodel.state == SongFetchState.LOADED) {
            return SongListViewWidget(songInfos: viewmodel.songInfos);
          }
          return Center(
            child: CircularProgressIndicator(),
          );
        },
      )),
    );
  }

  get shuffleAndSelectRandomlyFloatingButton {
    return FloatingActionButton(
      child: Icon(Icons.shuffle),
      onPressed: () async {
        int randIndex = await context.read<SongViewModel>().shuffleSongIndex();
        Navigator.of(context).push(
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
