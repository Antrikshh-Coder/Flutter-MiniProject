import 'package:flutter_test/flutter_test.dart';
import 'package:shopease/main.dart';

void main() {
  testWidgets('ShopEase app smoke test', (WidgetTester tester) async {
    await tester.pumpWidget(const ShopEaseApp());
    expect(find.text('ShopEase'), findsOneWidget);
  });
}
