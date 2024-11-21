import 'package:flutter/material.dart';
import 'package:music_player/core/constants/asset_constants.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:music_player/core/extension/size_extension.dart';
import 'package:music_player/utils/helper_functions.dart';
import 'package:music_player/viewmodel/song_view_model.dart';
import 'package:music_player/views/control_panel_screen.dart';
import 'package:music_player/widgets/app_text.dart';
import 'package:on_audio_query/on_audio_query.dart';

import 'package:provider/provider.dart';

class SongListViewWidget extends StatefulWidget {
  const SongListViewWidget({super.key});

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
      WidgetsBinding.instance.addPostFrameCallback((_) {
        final val = scrollController.offset / (MediaQuery.sizeOf(context).height * 0.18);
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
          padding: const EdgeInsets.only(top: 24),
          controller: scrollController,
          itemCount: viewmodel.songInfos.length,
          itemBuilder: (context, index) {
            var scale = 1.0;
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
                alignment: index.isEven ? Alignment.topLeft : Alignment.topRight,
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
  const _SongItemListCard({required this.songInfos, required this.index});

  final List<SongModel> songInfos;
  final int index;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.of(context).push(
          MaterialPageRoute<void>(
            builder: (context) => ControlPanelView(
              songInfo: songInfos,
              selectedIndex: index,
            ),
          ),
        );
      },
      child: Container(
        height: context.getHeight * 0.15,
        margin: context.paddingSymetricSpecific(8, 4),
        decoration: BoxDecoration(
          color: ColorConstants.cardColor,
          borderRadius: BorderRadius.circular(8),
          boxShadow: const [
            BoxShadow(blurRadius: 10, offset: Offset(0, 2)),
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
                        children: [
                          Expanded(
                            child: AppText(
                              text: songInfos[index].title,
                              maxLines: 2,
                              size: 18,
                            ),
                          ),
                          AppText(
                            text: HelperFunctions.parseToMinutesSeconds(songInfos[index].duration ?? 0),
                            size: 14,
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
    final tolerance = toleranceFor(position);
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
