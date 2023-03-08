import 'package:flutter/material.dart';
import 'package:flutter/services.dart';

class CustomSlider extends StatefulWidget {

  final double thumbRadius;
  final ValueChanged dragSlider;
  const CustomSlider({Key key, this.thumbRadius = 6.0, this.dragSlider,}) : super(key: key);

  @override
  State<CustomSlider> createState() => _CustomSliderState();
}

class _CustomSliderState extends State<CustomSlider> {

  var _thumbRadius = 0.0;
  ValueChanged _dragSlider;

  @override
  void initState() {
    _thumbRadius = widget.thumbRadius;
    _dragSlider = widget.dragSlider;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliderTheme(
      data: SliderThemeData(
        trackHeight: 2,
        activeTrackColor: Colors.transparent,
        inactiveTrackColor: Colors.transparent,
        overlayColor: Colors.transparent,
        trackShape: CustomTrackShape(),
        thumbShape: RetroSliderThumbShape(
          thumbRadius: _thumbRadius,
        ),
      ),
      child: Slider(
        value: 50,
        max: 100,
        onChanged: (newValue) {
          HapticFeedback.lightImpact();
          if (_dragSlider != null) {
            _dragSlider.call(newValue);
          }
        },
      ),
    );
  }
}

class CustomTrackShape extends RoundedRectSliderTrackShape {

  @override
  Rect getPreferredRect({
    @required RenderBox parentBox,
    Offset offset = Offset.zero,
    @required SliderThemeData sliderTheme,
    bool isEnabled = false,
    bool isDiscrete = false,
  }) {
    final double trackHeight = sliderTheme.trackHeight;
    final double trackLeft = offset.dx;
    final double trackTop =
        offset.dy + (parentBox.size.height - trackHeight) / 2;
    final double trackWidth = parentBox.size.width;
    return Rect.fromLTWH(trackLeft, trackTop, trackWidth, trackHeight);
  }
}

class RetroSliderThumbShape extends SliderComponentShape {
  final double thumbRadius;
  const RetroSliderThumbShape({
    this.thumbRadius = 8.0,
  });

  @override
  Size getPreferredSize(bool isEnabled, bool isDiscrete) {
    return Size.fromRadius(thumbRadius);
  }

  @override
  void paint(
      PaintingContext context,
      Offset center, {
        Animation<double> activationAnimation,
        Animation<double> enableAnimation,
        bool isDiscrete,
        TextPainter labelPainter,
        RenderBox parentBox,
        SliderThemeData sliderTheme,
        TextDirection textDirection,
        double value,
        double textScaleFactor,
        Size sizeWithOverflow,
      }) {
    final Canvas canvas = context.canvas;

    final rect = Rect.fromCircle(center: center, radius: thumbRadius);

    final RRect rrect = RRect.fromRectAndRadius(
      Rect.fromPoints(
        Offset(rect.left, rect.top),
        Offset(rect.right, rect.bottom),
      ),
      Radius.circular(thumbRadius),
    );

    final fillPaint = Paint()
      ..color = Colors.black
      ..style = PaintingStyle.fill;

    final borderPaint = Paint()
      ..color = Colors.red
      ..strokeWidth = 2.0
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke;

    canvas.drawRRect(rrect, fillPaint);
    canvas.drawRRect(rrect, borderPaint);
  }
}
