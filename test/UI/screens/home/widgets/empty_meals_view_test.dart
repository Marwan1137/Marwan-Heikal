import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/UI/screens/home/widgets/empty_meals_view.dart';

void main() {
  group('EmptyMealsView Tests', () {
    testWidgets('should display correct icon and text', (tester) async {
      // Build the widget
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyMealsView(),
          ),
        ),
      );

      // Verify icon is present
      expect(find.byIcon(Icons.restaurant_menu), findsOneWidget);
      
      // Verify icon properties
      final iconFinder = find.byType(Icon);
      final Icon icon = tester.widget(iconFinder);
      expect(icon.size, 64);
      expect(icon.color, Colors.grey[400]);

      // Verify text is present
      expect(find.text('No meals added\nClick + to add meals'), findsOneWidget);
      
      // Verify text properties
      final textFinder = find.byType(Text);
      final Text text = tester.widget(textFinder);
      expect(text.textAlign, TextAlign.center);
      expect((text.style?.fontSize), 16);
      expect(text.style?.color, Colors.grey[600]);
    });

    testWidgets('should be centered in the screen', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: EmptyMealsView(),
          ),
        ),
      );

      // Find the Center widget that contains our Column
      final centerFinder = find.ancestor(
        of: find.byType(Column),
        matching: find.byType(Center),
      );
      expect(centerFinder, findsOneWidget);

      // Verify Column is centered
      final columnFinder = find.byType(Column);
      expect(columnFinder, findsOneWidget);
      final Column column = tester.widget(columnFinder);
      expect(column.mainAxisAlignment, MainAxisAlignment.center);
    });
  });
}