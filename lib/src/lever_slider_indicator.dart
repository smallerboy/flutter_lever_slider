import 'package:flutter/material.dart';

class LeverSliderIndicator extends StatefulWidget {
  final int count;
  final int max;
  final double sliderValue;
  final double circleWidth;
  const LeverSliderIndicator({
    Key key,
    this.count = 5,
    this.max = 100,
    this.sliderValue,
    this.circleWidth,
  }) : super(key: key);

  @override
  State<LeverSliderIndicator> createState() => _LeverSliderIndicatorState();
}

class _LeverSliderIndicatorState extends State<LeverSliderIndicator> {
  var _circleWidth = 0.0;
  var _sliderValue = 0.0;
  int get _count => widget.max ~/ widget.count + 1;

  @override
  void initState() {
    _circleWidth = widget.circleWidth;
    _sliderValue = widget.sliderValue;
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: List.generate(_count, (index) {
        if (_count == index + 1) {
          return MarketCircle(
            width: _circleWidth,
          );
        }
        return MarketProgress(
          sliderValue: _sliderValue,
        );
      }),
    );
  }
}

class MarketCircle extends StatelessWidget {
  final double width;
  const MarketCircle({Key key, this.width}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return CustomPaint(
      size: Size(width, width),
      painter: CirclePainter(
        borderColor: Colors.red,
      ),
    );
  }
}

class MarketProgress extends StatelessWidget {
  final double sliderValue;
  final double width;
  const MarketProgress({Key key, this.sliderValue, this.width})
      : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Expanded(
      child: Row(
        children: [
          MarketCircle(
            width: width,
          ),
          Expanded(
            child: LinearProgressIndicator(
              minHeight: 1.0,
              value: sliderValue,
              backgroundColor: Colors.green,
              valueColor: const AlwaysStoppedAnimation(Colors.pink),
            ),
          )
        ],
      ),
    );
  }
}

class CirclePainter extends CustomPainter {
  final Color borderColor;
  CirclePainter({this.borderColor});

  @override
  void paint(Canvas canvas, Size size) {
    Offset center = Offset(size.width / 2, size.height / 2);

    Paint line = Paint()
      ..color = borderColor
      ..strokeCap = StrokeCap.round
      ..style = PaintingStyle.stroke
      ..strokeWidth = 1.5;
    canvas.drawCircle(
      center,
      size.width / 2,
      line,
    );
  }

  @override
  bool shouldRepaint(covariant CustomPainter oldDelegate) => false;
}
