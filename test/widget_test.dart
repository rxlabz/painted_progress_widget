import 'package:flutter/widgets.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:painted_progress_button/main.dart';

void main() {
  testWidgets('Counter increments smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(new App());

    expect(find.text('Start'), findsOneWidget);
    expect(find.text('0'), findsNothing);

    await tester.tap(find.byKey(Key('progressButton')));
    await tester.pump(Duration(milliseconds: 50));
    expect(find.text('Start'), findsNothing);
    expect(find.text('$kStep'), findsOneWidget);
  });
}
