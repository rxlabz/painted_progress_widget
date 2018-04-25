import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class ProgressButton extends StatelessWidget {
  final double percentProgress;
  final Size size;
  final Color primaryColor;
  final Color contrastColor;

  ProgressButton({
    Key key,
    @required this.percentProgress,
    this.size: const Size(64.0, 64.0),
    this.primaryColor: Colors.cyan,
    this.contrastColor: Colors.white,
  }) : super(key: key) {
    assert(percentProgress != null);
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      color: primaryColor,
      width: size.width,
      height: size.height,
      child: Stack(children: [
        Center(
            child: Text(
          '${percentProgress.round()} %',
          style: TextStyle(color: contrastColor),
        ))
      ]),
    );
  }
}
