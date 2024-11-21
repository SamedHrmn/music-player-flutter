import 'package:flutter/material.dart';
import 'package:music_player/core/constants/color_constants.dart';
import 'package:volume_controller/volume_controller.dart';

class VolumeControlWidget extends StatefulWidget {
  const VolumeControlWidget({super.key});

  @override
  _VolumeControlWidgetState createState() => _VolumeControlWidgetState();
}

class _VolumeControlWidgetState extends State<VolumeControlWidget> {
  double _setVolumeValue = 0;

  @override
  void initState() {
    super.initState();

    VolumeController().getVolume().then((volume) {
      setState(() {
        _setVolumeValue = volume;
      });
    });
  }

  @override
  void dispose() {
    VolumeController().removeListener();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        Flexible(
          child: Theme(
            data: ThemeData(
              sliderTheme: const SliderThemeData(
                thumbShape: RoundSliderThumbShape(enabledThumbRadius: 8),
              ),
            ),
            child: Slider(
              activeColor: ColorConstants.secondary,
              inactiveColor: Colors.white30,
              onChanged: (double value) {
                setState(() {
                  _setVolumeValue = value;
                  VolumeController().setVolume(_setVolumeValue, showSystemUI: false);
                });
              },
              value: _setVolumeValue,
            ),
          ),
        ),
        IconButton(
          onPressed: () {
            VolumeController().getVolume().then((volume) {
              if (volume > 0) {
                VolumeController().muteVolume(showSystemUI: false);
                setState(() {
                  _setVolumeValue = 0;
                });
              } else {
                VolumeController().setVolume(0.33, showSystemUI: false);
                setState(() {
                  _setVolumeValue = 0.33;
                });
              }
            });
          },
          icon: Icon(
            _setVolumeValue == 0 ? Icons.volume_off_rounded : Icons.volume_up_rounded,
            color: ColorConstants.secondary,
          ),
        ),
      ],
    );
  }
}
