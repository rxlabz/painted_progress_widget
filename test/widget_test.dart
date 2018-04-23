import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:painted_progress_button/main.dart';
// This is a basic Flutter widget test.
// To perform an interaction with a widget in your test, use the WidgetTester utility that Flutter
// provides. For example, you can send tap and scroll gestures. You can also use WidgetTester to
// find child widgets in the widget tree, read text, and verify that the values of widget properties
// are correct.

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(new App());

    // Verify that our counter starts at 0.
    expect(find.text('Start'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    // Tap the '+' icon and trigger a frame.
    //await tester.tap(find.byElementType(ProgressButton));
    await tester.tap(find.byKey(Key('progressButton')));
    await tester.pump(Duration(milliseconds: 50));
    expect(find.text('Start'), findsNothing);
    expect(find.text('$kStep'), findsOneWidget);

    /*
    // Verify that our counter has incremented.
    expect(find.text('1'), findsOneWidget);*/
  });
}
