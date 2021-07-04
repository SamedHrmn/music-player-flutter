import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

import '../core/init/notifier/theme_notifier.dart';
import '../core/init/theme/app_theme_dark.dart';
import '../core/init/theme/app_theme_light.dart';

class CustomAppBarWidget extends StatefulWidget implements PreferredSizeWidget {
  const CustomAppBarWidget({
    Key key,
    @required this.prefferedSizeHeight,
  }) : super(key: key);

  final prefferedSizeHeight;

  @override
  CustomAppBarWidgetState createState() => CustomAppBarWidgetState();

  @override
  Size get preferredSize => Size.fromHeight(prefferedSizeHeight);
}

class CustomAppBarWidgetState extends State<CustomAppBarWidget> with SingleTickerProviderStateMixin {
  AnimationController _controller;
  Animation<double> animation;
  final double startingHeight = 20.0;
  final double offset = 130;
  final Duration animDuration = Duration(milliseconds: 2000);

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(vsync: this, duration: animDuration);
    animation = Tween<double>(begin: startingHeight - offset, end: widget.preferredSize.height).animate(_controller);

    _controller.forward();
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return AnimatedBuilder(
      animation: _controller,
      builder: (context, child) {
        return ClipPath(
          clipper: _CustomAppBarShape(animation.value),
          child: Container(
            height: widget.preferredSize.height,
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: Alignment.bottomLeft,
                end: Alignment.bottomRight,
                colors: [Theme.of(context).primaryColor, Theme.of(context).accentColor],
              ),
            ),
            child: Row(children: appBarActions),
          ),
        );
      },
    );
  }

  get appBarActions => [
        Spacer(),
        Flexible(
            child: Align(
          alignment: Alignment.centerRight,
          child: IconButton(
            color:
                context.watch<ThemeNotifier>().isThemeLight() ? AppThemeDark.instance.theme.primaryColor : AppThemeLight.instance.theme.primaryColor,
            icon: Icon(Icons.brightness_2),
            onPressed: () {
              context.read<ThemeNotifier>().changeTheme(context.read<ThemeNotifier>().isThemeLight() ? AppTheme.DARK : AppTheme.LIGHT);
            },
          ),
        ))
      ];
}

class _CustomAppBarShape extends CustomClipper<Path> {
  final double animatedHeight;

  _CustomAppBarShape(this.animatedHeight);

  @override
  Path getClip(Size size) {
    double height = animatedHeight;
    double width = size.width;

    var path = Path();

    path.lineTo(0, height - 40);
    path.quadraticBezierTo(width / 2, height, width, height - 40);
    path.lineTo(width, 0);
    path.close();

    return path;
  }

  @override
  bool shouldReclip(covariant CustomClipper<Path> oldClipper) {
    return true;
  }
}
