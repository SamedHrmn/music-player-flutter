import 'package:flutter/material.dart';
import 'package:music_player/core/constants/asset_constants.dart';
import 'package:music_player/utils/helper_functions.dart';
import 'package:music_player/viewmodel/song_view_model.dart';
import 'package:music_player/widgets/app_text.dart';
import 'package:on_audio_query/on_audio_query.dart' hide context;
import 'package:provider/provider.dart';

import '../core/constants/size_constants.dart';
import '../core/extension/size_extension.dart';
import '../views/control_panel_screen.dart';

class SongListViewWidget extends StatefulWidget {
  const SongListViewWidget({Key? key}) : super(key: key);

  @override
  _SongListViewWidgetState createState() => _SongListViewWidgetState();
}

class _SongListViewWidgetState extends State<SongListViewWidget> {
  late final ScrollController scrollController;
  double topItem = 0;
  final opacityDuration = const Duration(milliseconds: 200);

  @override
  void initState() {
    super.initState();
    scrollController = ScrollController();
    scrollController.addListener(() {
      Future.microtask(() {
        double val = scrollController.offset / (MediaQuery.sizeOf(context).height * 0.18);
        setState(() {
          topItem = val;
        });
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
    return Consumer<SongViewModel>(
      builder: (context, viewmodel, _) {
        return ListView.builder(
          padding: const EdgeInsets.only(top: 32),
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
                  child: _SongItemListCard(index: index, songInfos: viewmodel.songInfos),
                ),
              ),
            );
          },
        );
      },
    );
  }
}

class _SongItemListCard extends StatelessWidget {
  const _SongItemListCard({super.key, required this.songInfos, required this.index});

  final List<AudioModel> songInfos;
  final int index;

  @override
  Widget build(BuildContext context) {
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
        height: context.getHeight * 0.15,
        margin: context.paddingSymetricSpecific(SizeConstants.LOW_VALUE, SizeConstants.LOW_VALUE / 2),
        decoration: BoxDecoration(
          color: Theme.of(context).cardColor,
          borderRadius: BorderRadius.circular(SizeConstants.LOW_VALUE),
          boxShadow: const [
            BoxShadow(color: Colors.black, blurRadius: 10.0, offset: Offset(0, 2)),
          ],
        ),
        child: Stack(
          children: [
            RotatedBox(
              quarterTurns: 3,
              child: Image.asset(
                AssetConstants.CORNER_FRAME,
                height: 64,
              ),
            ),
            Align(
              alignment: Alignment.topRight,
              child: Image.asset(
                AssetConstants.CORNER_FRAME,
                height: 64,
              ),
            ),
            Align(
              alignment: Alignment.bottomLeft,
              child: RotatedBox(
                quarterTurns: 2,
                child: Image.asset(
                  AssetConstants.CORNER_FRAME,
                  height: 64,
                ),
              ),
            ),
            Align(
              alignment: Alignment.bottomRight,
              child: RotatedBox(
                quarterTurns: 1,
                child: Image.asset(
                  AssetConstants.CORNER_FRAME,
                  height: 64,
                ),
              ),
            ),
            Padding(
              padding: context.paddingHorizontalHigh + context.paddingVerticalMedium,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerLeft,
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          AppText(
                            text: songInfos[index].title,
                            maxLines: 2,
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                          AppText(
                            text: HelperFunctions.instance.parseToMinutesSeconds(songInfos[index].duration ?? 0),
                            maxLines: 2,
                            size: 14,
                            fontWeight: FontWeight.w600,
                          ),
                        ],
                      ),
                    ),
                  ),
                  Flexible(
                    child: Align(
                      alignment: Alignment.centerRight,
                      child: AppText(
                        text: songInfos[index].artist ?? '-',
                        size: 10,
                        maxLines: 1,
                      ),
                    ),
                  ),
                ],
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
