import 'package:flutter/material.dart';
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
      body: SafeArea(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            ElevatedButton(
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
                backgroundColor: Theme.of(context).colorScheme.primary,
                minimumSize: Size.zero,
                padding: const EdgeInsets.symmetric(vertical: 4, horizontal: 32),
              ),
              child: Icon(
                Icons.shuffle,
                color: Theme.of(context).colorScheme.background,
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
                      child: Text("No song data"),
                    );
                  } else if (viewmodel.state == SongFetchState.PERMISSION_DENIED) {
                    return const Center(
                      child: Text("Please allow media permission."),
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
}
