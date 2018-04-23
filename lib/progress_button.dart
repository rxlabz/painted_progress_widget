import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressButton extends StatefulWidget {
  final double percentProgress;
  final Size size;
  final VoidCallback onPressed;

  bool get started => percentProgress > 0;

  const ProgressButton(
      {Key key,
      this.percentProgress,
      this.size: const Size(64.0, 64.0),
      this.onPressed})
      : super(key: key);

  @override
  ProgressButtonState createState() {
    return new ProgressButtonState();
  }
}

class ProgressButtonState extends State<ProgressButton>
    with TickerProviderStateMixin {
  AnimationController _controller;

  RectTween innerRectTween;

  ProgressButtonState();

  final padding = Offset(10.0, 10.0);

  Rect innerRect;
  Rect maxInnerRect;

  @override
  void initState() {
    super.initState();

    innerRect = Offset.zero & widget.size;
    maxInnerRect =
        (Offset.zero + padding) & (widget.size - (padding + padding));

    _controller = new AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 166),
      value: 0.0,
    )..addListener(() {
        print('_controller.value ${_controller.value} $innerRect');
        setState(() => innerRect = innerRectTween.evaluate(_controller));
      });

    initTweens();
  }

  @override
  void didUpdateWidget(ProgressButton oldWidget) {
    if (widget.percentProgress > 0 && _controller.isDismissed)
      _controller.forward();

    if (widget.percentProgress >= 100) {
      print('widget.percentProgress >= 100... ${widget.percentProgress}');
      _controller.reverse();
    }
    super.didUpdateWidget(oldWidget);
  }

  void initTweens() {
    innerRectTween =
        new RectTween(begin: Offset.zero & widget.size, end: maxInnerRect);
    /*primaryColorTween =
    new ColorTween(begin: widget.primaryColor, end: widget.secondaryColor);

    secondaryColorTween =
    new ColorTween(begin: widget.secondaryColor, end: widget.primaryColor);*/
  }

  @override
  Widget build(BuildContext context) {
    return InkWell(
        onTap: widget.onPressed,
        child: Container(
          width: widget.size.width,
          height: widget.size.height,
          child: Stack(children: [
            CustomPaint(
              painter: ProgressButtonPainter(
                  progress: widget.percentProgress, innerRect: innerRect),
              size: widget.size,
            ),
            Center(
                child: widget.percentProgress < 100
                    ? Text(widget.started
                        ? widget.percentProgress.toInt().toString()
                        : "Start")
                    : Icon(Icons.check))
          ]),
        ));
  }
}

class ProgressButtonPainter extends CustomPainter {
  final double progress;
  final Color fillColor;
  final Color progressColor;
  final Color backgroundColor;
  final Rect innerRect;

  ProgressButtonPainter(
      {this.progress,
      this.fillColor: Colors.white,
      this.backgroundColor: Colors.cyan,
      this.progressColor: Colors.lime,
      this.innerRect});

  @override
  void paint(Canvas canvas, Size size) {
    final fillRect = Offset.zero & size;

    if (progress == 0.0 || progress == 100.0)
      canvas.drawShadow(Path()..addRect(fillRect), Colors.black, 2.0, true);

    final fill = Paint()
      ..style = PaintingStyle.fill
      ..color = backgroundColor;
    canvas.drawRect(fillRect, fill);

    final progressFill = Paint()
      ..style = PaintingStyle.fill
      ..color = progressColor;
    canvas.drawRect(
        new Rect.fromPoints(
            Offset.zero, Offset(size.width * progress / 100, size.height)),
        progressFill);

    /*final padding = Offset(10.0, 10.0);
    final innerRect = (Offset.zero + padding) & (size - (padding + padding));*/

    if (progress > 0.0 && progress < 100.0)
      canvas.drawShadow(Path()..addRect(innerRect), Colors.black, 2.0, true);

    final innerFill = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor;
    canvas.drawRect(innerRect, innerFill);
  }

  @override
  bool shouldRepaint(ProgressButtonPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.innerRect != innerRect ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
