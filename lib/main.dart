import 'dart:async';

import 'package:flutter/material.dart';

import 'progress_button.dart';

void main() => runApp(new App());

class App extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      debugShowCheckedModeBanner: false,
      home: Scaffold(
        body: ProgressButtonDemo(),
      ),
    );
  }
}

const double kStep = 2.0;

class ProgressButtonDemo extends StatefulWidget {
  @override
  _ProgressButtonDemoState createState() => new _ProgressButtonDemoState();
}

class _ProgressButtonDemoState extends State<ProgressButtonDemo> {
  double progress = 0.0;
  Timer timer;

  void start() {
    if (progress == 100.0)
      setState(() => progress = 0.0);
    else
      timer = Timer.periodic(Duration(milliseconds: 50), (t) {
        if (progress == 100.0)
          t.cancel();
        else
          setState(() => progress = progress + kStep);
      });
  }

  @override
  void dispose() {
    super.dispose();
    if (timer != null) timer.cancel();
  }

  @override
  Widget build(BuildContext context) {
    return new Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      children: <Widget>[
        ProgressButton(
          key: Key('progressButton'),
          percentProgress: progress,
          onPressed: start,
        ),
        Slider(
          value: progress,
          min: 0.0,
          max: 100.0,
          onChanged: (double value) => setState(() => progress = value),
        )
      ],
    );
  }
}
