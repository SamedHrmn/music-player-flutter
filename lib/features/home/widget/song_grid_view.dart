import 'package:flutter/material.dart';
import 'package:flutter_staggered_grid_view/flutter_staggered_grid_view.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:music_player/core/enum/route_enum.dart';
import 'package:music_player/core/navigation/app_navigation_manager.dart';
import 'package:music_player/features/shared/domain/song.dart';
import 'package:music_player/locator.dart';

class SongGridView extends StatelessWidget {
  const SongGridView({required this.songList, super.key});

  final List<Song> songList;

  @override
  Widget build(BuildContext context) {
    return GridView.custom(
      scrollDirection: Axis.horizontal,
      padding: const EdgeInsets.all(8) + const EdgeInsets.only(top: 16),
      gridDelegate: SliverQuiltedGridDelegate(
        crossAxisCount: 4,
        mainAxisSpacing: 12,
        crossAxisSpacing: 12,
        repeatPattern: QuiltedGridRepeatPattern.inverted,
        pattern: const [
          QuiltedGridTile(2, 2),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 1),
          QuiltedGridTile(1, 2),
        ],
      ),
      childrenDelegate: SliverChildBuilderDelegate(
        childCount: songList.length,
        (context, index) => _SongGridCard(
          song: songList[index],
          onTap: () {
            getIt<AppNavigationManager>().navigateTo(
              RouteEnum.playDetail,
              arguments: {
                'itemIndex': index,
                'songList': songList,
              },
            );
          },
        ),
      ),
    );
  }
}

class _SongGridCard extends StatelessWidget {
  const _SongGridCard({
    required this.song,
    required this.onTap,
  });

  final Song song;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return InkWell(
      onTap: onTap,
      child: Container(
        clipBehavior: Clip.antiAlias,
        decoration: const BoxDecoration(
          borderRadius: BorderRadius.all(Radius.circular(12)),
          color: ColorConstants.background,
          boxShadow: [
            BoxShadow(
              spreadRadius: 2,
              blurRadius: 8,
              color: Color.fromARGB(124, 9, 9, 11),
            ),
          ],
        ),
        child: Hero(
          key: Key(song.id.toString()),
          tag: 'artwork${song.id}',
          child: Image.memory(
            song.artwork!,
            fit: BoxFit.cover,
          ),
        ),
      ),
    );
  }
}
