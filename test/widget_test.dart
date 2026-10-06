import 'package:flutter_test/flutter_test.dart';
import 'package:radiant_clock/main.dart';

void main() {
  testWidgets('Clock app loads successfully', (WidgetTester tester) async {
    await tester.pumpWidget(const RadiantClockApp());
    expect(find.byType(RadiantClockApp), findsOneWidget);
  });
}