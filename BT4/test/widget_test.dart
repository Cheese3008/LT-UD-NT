import 'package:flutter_test/flutter_test.dart';

import 'package:flutter_application_1/main.dart';

void main() {
  testWidgets('Home screen displays Exercise Week 4 title', (
    WidgetTester tester,
  ) async {
    await tester.pumpWidget(const ExerciseWeek4App());

    expect(find.text('Exercise Week 4'), findsOneWidget);
    expect(find.text('ListView Exercise'), findsOneWidget);
    expect(find.text('GridView Exercise'), findsOneWidget);
    expect(find.text('SharedPreferences Exercise'), findsOneWidget);
    expect(find.text('Async Programming Exercise'), findsOneWidget);
    expect(find.text('Isolate Factorial Exercise'), findsOneWidget);
  });
}