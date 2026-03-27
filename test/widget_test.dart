// This is a basic Flutter widget test.
//
// To perform an interaction with a widget in your test, use the WidgetTester
// utility in the flutter_test package. For example, you might send tap and
// scroll gestures. You can also use WidgetTester to find child widgets in the
// widget tree, read text, and verify that the values of widget properties are
// correct.

import 'package:flutter_test/flutter_test.dart';

import 'package:beatflow/main.dart';

void main() {
  testWidgets('beatflow app loads', (WidgetTester tester) async {
    // Build our app and trigger a frame.
    await tester.pumpWidget(const MyApp());

    // Verify that the BeatFlow text is displayed.
    expect(find.text('BeatFlow'), findsWidgets);
  });
}
