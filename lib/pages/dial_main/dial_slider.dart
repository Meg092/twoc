import 'package:flutter/material.dart';

class DialSlider extends StatefulWidget {
  const DialSlider(this.type, this.value, this.onChanged, {Key? key})
      : super(key: key);
  final int type;
  final int value;
  final Function(int) onChanged;

  @override
  State<DialSlider> createState() => _DialSliderState();
}

class _DialSliderState extends State<DialSlider> {
  Color activeTrackColor = Colors.red;

  @override
  void initState() {
    // TODO: implement initState
    if (widget.type == 0) {
      activeTrackColor = const Color(0xffff0000);
    } else if (widget.type == 1) {
      activeTrackColor = const Color(0xff00ff45);
    } else if (widget.type == 2) {
      activeTrackColor = const Color(0xff1d00ff);
    }
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 30,
      child: SliderTheme(
        data: SliderTheme.of(context).copyWith(
          activeTrackColor: activeTrackColor,
          inactiveTrackColor: const Color(0xffe6e6e6),
          thumbColor: activeTrackColor,
          overlayColor: const Color(0xff3e3e3e),
          valueIndicatorColor: activeTrackColor,
          trackHeight: 20,
          showValueIndicator: ShowValueIndicator.always,
        ),
        child: Slider(
          value: widget.value.toDouble(),
          min: 0,
          max: 255,
          divisions: 255,
          onChanged: (v) {
            widget.onChanged(v.toInt());
          },
        ),
      ),
    );
  }
}
