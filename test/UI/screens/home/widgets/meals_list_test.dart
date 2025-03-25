import 'package:flutter/material.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:meal_tracker/UI/screens/home/widgets/meals_list.dart';
import 'package:meal_tracker/UI/screens/home/widgets/meal_card.dart';

void main() {
  late List<Meal> testMeals;

  setUp(() {
    testMeals = [
      Meal(
        id: '1',
        name: 'Breakfast',
        type: MealType.breakfast,
        dateTime: DateTime(2024, 1, 1, 8, 0),
        calories: 300,
      ),
      Meal(
        id: '2',
        name: 'Lunch',
        type: MealType.lunch,
        dateTime: DateTime(2024, 1, 1, 13, 0),
        calories: 500,
      ),
    ];
  });

  group('MealsList Tests', () {
    testWidgets('should render empty list when no meals provided',
        (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MealsList(
              meals: const [],
              onUpdate: (_) {},
              onDelete: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MealCard), findsNothing);
    });

    testWidgets('should render correct number of MealCards', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MealsList(
              meals: testMeals,
              onUpdate: (_) {},
              onDelete: (_) {},
            ),
          ),
        ),
      );

      expect(find.byType(MealCard), findsNWidgets(2));
      expect(find.text('Breakfast'), findsOneWidget);
      expect(find.text('Lunch'), findsOneWidget);
    });

    testWidgets('should pass correct meal to MealCard', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MealsList(
              meals: testMeals,
              onUpdate: (_) {},
              onDelete: (_) {},
            ),
          ),
        ),
      );

      final mealCards = tester.widgetList<MealCard>(find.byType(MealCard));
      expect(mealCards.length, 2);

      expect(mealCards.elementAt(0).meal, equals(testMeals[0]));
      expect(mealCards.elementAt(1).meal, equals(testMeals[1]));
    });

    testWidgets('should call onUpdate with correct meal', (tester) async {
      Meal? updatedMeal;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MealsList(
              meals: testMeals,
              onUpdate: (meal) => updatedMeal = meal,
              onDelete: (_) {},
            ),
          ),
        ),
      );

      final firstMealCard = find.byType(MealCard).first;
      final mealCardWidget = tester.widget<MealCard>(firstMealCard);
      
      // Call onUpdate through the MealCard's callback
      mealCardWidget.onUpdate(testMeals[0]);

      expect(updatedMeal, equals(testMeals[0]));
    });

    testWidgets('should call onDelete with correct id', (tester) async {
      String? deletedId;

      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MealsList(
              meals: testMeals,
              onUpdate: (_) {},
              onDelete: (id) => deletedId = id,
            ),
          ),
        ),
      );

      final firstMealCard = find.byType(MealCard).first;
      final mealCardWidget = tester.widget<MealCard>(firstMealCard);
      
      // Call onDelete through the MealCard's callback
      mealCardWidget.onDelete(testMeals[0].id);

      expect(deletedId, equals(testMeals[0].id));
    });

    testWidgets('should have correct ListView padding', (tester) async {
      await tester.pumpWidget(
        MaterialApp(
          home: Scaffold(
            body: MealsList(
              meals: testMeals,
              onUpdate: (_) {},
              onDelete: (_) {},
            ),
          ),
        ),
      );

      final listView = tester.widget<ListView>(find.byType(ListView));
      expect(listView.padding, const EdgeInsets.only(top: 8));
    });
  });
}