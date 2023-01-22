import 'package:flutter/material.dart';
import 'package:flutter_audio_query/flutter_audio_query.dart';
import 'package:music_player/viewmodel/song_view_model.dart';
import 'package:provider/provider.dart';

import '../core/constants/size_constants.dart';
import '../core/extension/size_extension.dart';
import '../views/control_panel_screen.dart';
import 'custom_avatar_widget.dart';

class SongListViewWidget extends StatefulWidget {
  const SongListViewWidget({Key? key}) : super(key: key);

  @override
  _SongListViewWidgetState createState() => _SongListViewWidgetState();
}

class _SongListViewWidgetState extends State<SongListViewWidget> {
  final List<MaterialColor> _colors = Colors.primaries;
  late final ScrollController scrollController;
  double topItem = 0;
  final opacityDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      double val = scrollController.offset / (context.getHeight * 0.18);
      setState(() {
        topItem = val;
      });
    });
  }

  @override
  void dispose() {
    scrollController.dispose();

    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scrollbar(
      child: Consumer<SongViewModel>(builder: (context, viewmodel, _) {
        return ListView.builder(
          controller: scrollController,
          itemCount: viewmodel.songInfos.length,
          itemBuilder: (context, index) {
            double scale = 1.0;
            if (topItem > 0.5) {
              scale = index + 0.5 - topItem;
              if (scale < 0) {
                scale = 0;
              } else if (scale > 1) {
                scale = 1;
              }
            }

            return AnimatedOpacity(
              opacity: scale,
              duration: opacityDuration,
              child: Transform(
                transform: Matrix4.identity()..scale(scale, scale),
                alignment: index % 2 == 0 ? Alignment.topLeft : Alignment.topRight,
                child: Align(
                  heightFactor: 0.75,
                  alignment: Alignment.topCenter,
                  child: songItemListTile(index, viewmodel.songInfos, context),
                ),
              ),
            );
          },
        );
      }),
    );
  }

  Widget songItemListTile(int index, List<SongInfo> songInfos, BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute(
            builder: (context) => ControlPanelView(
              songInfo: songInfos,
              selectedIndex: index,
            ),
          ),
        );
      },
      child: Container(
        height: context.getHeight * 0.2,
        margin: context.paddingSymetricSpecific(SizeConstants.LOW_VALUE, SizeConstants.LOW_VALUE / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(SizeConstants.MEDIUM_VALUE),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 10.0, offset: Offset(0, 2)),
          ],
        ),
        child: Row(
          children: [
            Flexible(
              flex: 2,
              child: Padding(
                padding: context.paddingOnlyLeft(SizeConstants.LOW_VALUE),
                child: Hero(
                  tag: index,
                  child: CustomCircleAvatarWidget(
                    color: _colors[index % _colors.length],
                  ),
                ),
              ),
            ),
            Expanded(
              flex: 6,
              child: Padding(
                padding: context.paddingHorizontalMedium,
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                  children: [
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerLeft,
                        child: Text(
                          songInfos[index].title,
                          textAlign: TextAlign.start,
                          maxLines: 2,
                        ),
                      ),
                    ),
                    Flexible(
                      child: Align(
                        alignment: Alignment.centerRight,
                        child: Text(
                          songInfos[index].artist,
                          style: Theme.of(context).textTheme.caption?.copyWith(fontStyle: FontStyle.italic),
                          maxLines: 1,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class CustomScrollPhysics extends ScrollPhysics {
  const CustomScrollPhysics({required ScrollPhysics parent}) : super(parent: parent);

  @override
  ScrollPhysics applyTo(ScrollPhysics? ancestor) {
    return CustomScrollPhysics(parent: buildParent(ancestor)!);
  }

  @override
  Simulation createBallisticSimulation(ScrollMetrics position, double velocity) {
    final tolerance = this.tolerance;
    if ((velocity.abs() < tolerance.velocity) ||
        (velocity > 0.0 && position.pixels >= position.maxScrollExtent) ||
        (velocity < 0.0 && position.pixels <= position.minScrollExtent)) {
      return ClampingScrollSimulation(position: position.pixels, velocity: 0);
    }
    return ClampingScrollSimulation(
      position: position.pixels,
      velocity: velocity,
      friction: 0.030,
      tolerance: tolerance,
    );
  }
}
