import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:music_player/core/constants/string_constants.dart';
import 'package:music_player/utils/helper_functions.dart';
import 'package:music_player/widgets/app_text.dart';

class HeaderSubmenu extends StatefulWidget {
  const HeaderSubmenu({super.key});

  @override
  State<HeaderSubmenu> createState() => _HeaderSubmenuState();
}

class _HeaderSubmenuState extends State<HeaderSubmenu> {
  late final MenuController menuController;

  @override
  void initState() {
    super.initState();
    menuController = MenuController();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: 48,
      child: ClipOval(
        child: SubmenuButton(
          controller: menuController,
          menuStyle: const MenuStyle(
            shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
            padding: WidgetStatePropertyAll(
              EdgeInsets.symmetric(horizontal: 8),
            ),
          ),
          menuChildren: [
            TextButton(
              onPressed: () async {
                menuController.close();
                await HelperFunctions.openPrivacyPolicyUrl();
              },
              style: const ButtonStyle(
                shape: WidgetStatePropertyAll(RoundedRectangleBorder()),
              ),
              child: const AppText(text: StringConstants.privacyPolicy),
            ),
          ],
          child: const Align(
            alignment: Alignment.centerRight,
            child: Icon(
              Icons.info,
              color: ColorConstants.wine,
            ),
          ),
        ),
      ),
    );
  }
}
