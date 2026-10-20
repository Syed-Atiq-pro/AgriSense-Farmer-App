import 'package:flutter_test/flutter_test.dart';
import 'package:provider/provider.dart';
import 'package:flutter/material.dart';
import 'package:agrisense/main.dart';
import 'package:agrisense/providers/crop_provider.dart';
import 'package:agrisense/providers/expense_provider.dart';

void main() {
  testWidgets('Agrisense app starts successfully', (WidgetTester tester) async {
    await tester.pumpWidget(
      MultiProvider(
        providers: [
          ChangeNotifierProvider(create: (_) => CropProvider()),
          ChangeNotifierProvider(create: (_) => ExpenseProvider()),
        ],
        child: const AgriSenseApp(),
      ),
    );

    expect(find.byType(MaterialApp), findsOneWidget);
  });
}
