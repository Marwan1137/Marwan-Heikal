import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/domain/entity/meal.dart';

void main() {
  late Meal testMeal;

  setUp(() {
    testMeal = Meal(
      id: '1',
      name: 'Test Meal',
      type: MealType.breakfast,
      dateTime: DateTime(2024, 1, 1),
      calories: 300,
    );
  });

  group('Meal Entity Tests', () {
    test('should create Meal instance with correct values', () {
      expect(testMeal.id, '1');
      expect(testMeal.name, 'Test Meal');
      expect(testMeal.type, MealType.breakfast);
      expect(testMeal.dateTime, DateTime(2024, 1, 1));
      expect(testMeal.calories, 300);
    });

    group('copyWith Tests', () {
      test('should copy with new id', () {
        final copiedMeal = testMeal.copywith(id: '2');
        expect(copiedMeal.id, '2');
        expect(copiedMeal.name, testMeal.name);
        expect(copiedMeal.type, testMeal.type);
        expect(copiedMeal.dateTime, testMeal.dateTime);
        expect(copiedMeal.calories, testMeal.calories);
      });

      test('should copy with new name', () {
        final copiedMeal = testMeal.copywith(name: 'New Meal');
        expect(copiedMeal.id, testMeal.id);
        expect(copiedMeal.name, 'New Meal');
        expect(copiedMeal.type, testMeal.type);
        expect(copiedMeal.dateTime, testMeal.dateTime);
        expect(copiedMeal.calories, testMeal.calories);
      });

      test('should copy with new type', () {
        final copiedMeal = testMeal.copywith(type: MealType.lunch);
        expect(copiedMeal.id, testMeal.id);
        expect(copiedMeal.name, testMeal.name);
        expect(copiedMeal.type, MealType.lunch);
        expect(copiedMeal.dateTime, testMeal.dateTime);
        expect(copiedMeal.calories, testMeal.calories);
      });

      test('should copy with new dateTime', () {
        final newDate = DateTime(2024, 2, 1);
        final copiedMeal = testMeal.copywith(dateTime: newDate);
        expect(copiedMeal.id, testMeal.id);
        expect(copiedMeal.name, testMeal.name);
        expect(copiedMeal.type, testMeal.type);
        expect(copiedMeal.dateTime, newDate);
        expect(copiedMeal.calories, testMeal.calories);
      });

      test('should copy with new calories', () {
        final copiedMeal = testMeal.copywith(calories: 500);
        expect(copiedMeal.id, testMeal.id);
        expect(copiedMeal.name, testMeal.name);
        expect(copiedMeal.type, testMeal.type);
        expect(copiedMeal.dateTime, testMeal.dateTime);
        expect(copiedMeal.calories, 500);
      });
    });
  });
}