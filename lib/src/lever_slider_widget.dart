import 'package:flutter/material.dart';
import 'package:flutter_lever_slider/src/custom_slider.dart';
import 'package:flutter_lever_slider/src/lever_slider_indicator.dart';

class LeverSliderWidget extends StatefulWidget {
  final double thumbRadius;
  final double height;
  final ValueChanged dragSlider;

  const LeverSliderWidget({
    Key key,
    this.thumbRadius = 6.0,
    this.height = 50,
    this.dragSlider,
  }) : super(key: key);

  @override
  State<LeverSliderWidget> createState() => _LeverSliderWidgetState();
}

class _LeverSliderWidgetState extends State<LeverSliderWidget> {
  var _thumbRadius = 0.0;
  var _height = 0.0;
  var _sliderValue = 0.0;
  ValueChanged _dragSlider;

  @override
  void initState() {
    _thumbRadius = widget.thumbRadius;
    _height = widget.height;
    _dragSlider = widget.dragSlider;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Stack(
      children: [
        LeverSliderIndicator(
          circleWidth: 10.0,
          sliderValue: _sliderValue,
        ),
        Positioned(
          left: _thumbRadius,
          right: _thumbRadius,
          top: 0,
          height: _height,
          child: CustomSlider(
            thumbRadius: _thumbRadius,
            dragSlider: (value) async {
              _sliderValue = value;
              _dragSlider.call(value);
            },
          ),
        )
      ],
    );
  }
}
