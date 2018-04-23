import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressButton extends StatelessWidget {
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
  Widget build(BuildContext context) {
    return InkWell(
        onTap: onPressed,
        child: Container(
          width: size.width,
          height: size.height,
          child: Stack(children: [
            CustomPaint(
              painter: ProgressButtonPainter(
                progress: percentProgress,
              ),
              size: size,
            ),
            Center(
                child: percentProgress < 100
                    ? Text(
                        started ? percentProgress.toInt().toString() : "Start")
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

  ProgressButtonPainter({
    this.progress,
    this.fillColor: Colors.white,
    this.backgroundColor: Colors.cyan,
    this.progressColor: Colors.lime,
  });

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

    final padding = Offset(10.0, 10.0);
    final innerRect = (Offset.zero + padding) & (size - (padding + padding));

    if (progress > 0.0)
      canvas.drawShadow(Path()..addRect(innerRect), Colors.black, 2.0, true);

    final innerFill = Paint()
      ..style = PaintingStyle.fill
      ..color = fillColor;
    canvas.drawRect(
        progress > 0 && progress < 100 ? innerRect : fillRect, innerFill);
  }

  @override
  bool shouldRepaint(ProgressButtonPainter oldDelegate) {
    return oldDelegate.progress != progress ||
        oldDelegate.fillColor != fillColor ||
        oldDelegate.progressColor != progressColor ||
        oldDelegate.backgroundColor != backgroundColor;
  }
}
