import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/UI/screens/home/widgets/total_calories_card.dart';

void main() {
  group('TotalCaloriesCard Tests', () {
    testWidgets('should display total calories correctly', (tester) async {
      const totalCalories = 1500;

      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TotalCaloriesCard(
              totalCalories: totalCalories,
            ),
          ),
        ),
      );

      expect(find.text('1500 cal'), findsOneWidget);
      expect(find.text('Total Calories'), findsOneWidget);
    });

    testWidgets('should have correct styling', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TotalCaloriesCard(
              totalCalories: 1500,
            ),
          ),
        ),
      );

      final iconFinder = find.byType(Icon);
      final Icon icon = tester.widget(iconFinder);
      expect(icon.color, Colors.orange);
      expect(icon.size, 32);
      expect(icon.icon, Icons.local_fire_department);

      final labelFinder = find.text('Total Calories');
      final Text labelText = tester.widget(labelFinder);
      expect(labelText.style?.fontSize, 14);
      expect(labelText.style?.color, Colors.grey);

      final valueText = tester.widget<Text>(find.text('1500 cal'));
      expect(valueText.style?.fontSize, 24);
      expect(valueText.style?.fontWeight, FontWeight.bold);
    });

    testWidgets('should have correct layout structure', (tester) async {
      await tester.pumpWidget(
        const MaterialApp(
          home: Scaffold(
            body: TotalCaloriesCard(
              totalCalories: 1500,
            ),
          ),
        ),
      );

      final containerFinder = find.byType(Container);
      final Container container = tester.widget(containerFinder);
      expect(container.margin, const EdgeInsets.all(16));
      expect(container.padding, const EdgeInsets.all(16));

      final BoxDecoration decoration = container.decoration as BoxDecoration;
      expect(decoration.color, Colors.green[10]);
      expect(decoration.borderRadius, BorderRadius.circular(16));
      expect(decoration.boxShadow?.length, 1);

      expect(find.byType(Row), findsOneWidget);
      expect(find.byType(Column), findsOneWidget);
      
      // Verify specific SizedBox
      final sizedBox = find.byWidgetPredicate(
        (widget) => widget is SizedBox && widget.width == 16,
      );
      expect(sizedBox, findsOneWidget);
    });
  });
}
