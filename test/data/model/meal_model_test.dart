import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/data/model/meal_model.dart';
import 'package:meal_tracker/domain/entity/meal.dart';

void main() {
  late MealModel testModel;
  final testDateTime = DateTime(2024, 1, 1);
  final testJson = {
    'id': '1',
    'name': 'Test Meal',
    'type': MealType.breakfast.index,
    'dateTime': testDateTime.toIso8601String(),
    'calories': 300,
  };

  setUp(() {
    testModel = MealModel(
      id: '1',
      name: 'Test Meal',
      type: MealType.breakfast,
      dateTime: testDateTime,
      calories: 300,
    );
  });

  group('MealModel Tests', () {
    test('should create MealModel from constructor', () {
      expect(testModel.id, '1');
      expect(testModel.name, 'Test Meal');
      expect(testModel.type, MealType.breakfast);
      expect(testModel.dateTime, testDateTime);
      expect(testModel.calories, 300);
    });

    test('should create MealModel from JSON', () {
      final model = MealModel.fromJson(testJson);
      
      expect(model.id, testModel.id);
      expect(model.name, testModel.name);
      expect(model.type, testModel.type);
      expect(model.dateTime, testModel.dateTime);
      expect(model.calories, testModel.calories);
    });

    test('should convert MealModel to JSON', () {
      final json = testModel.toJson();
      
      expect(json['id'], testModel.id);
      expect(json['name'], testModel.name);
      expect(json['type'], testModel.type.index);
      expect(json['dateTime'], testModel.dateTime.toIso8601String());
      expect(json['calories'], testModel.calories);
    });

    test('should create MealModel from Meal', () {
      final meal = Meal(
        id: '1',
        name: 'Test Meal',
        type: MealType.breakfast,
        dateTime: testDateTime,
        calories: 300,
      );

      final model = MealModel.fromMeal(meal);
      
      expect(model.id, meal.id);
      expect(model.name, meal.name);
      expect(model.type, meal.type);
      expect(model.dateTime, meal.dateTime);
      expect(model.calories, meal.calories);
    });

    group('copyWith Tests', () {
      test('should copy with new values', () {
        final newDateTime = DateTime(2024, 2, 1);
        final copied = testModel.copyWith(
          id: '2',
          name: 'New Meal',
          type: MealType.lunch,
          dateTime: newDateTime,
          calories: 400,
        );

        expect(copied.id, '2');
        expect(copied.name, 'New Meal');
        expect(copied.type, MealType.lunch);
        expect(copied.dateTime, newDateTime);
        expect(copied.calories, 400);
      });

      test('should keep original values when not specified', () {
        final copied = testModel.copyWith();
        
        expect(copied.id, testModel.id);
        expect(copied.name, testModel.name);
        expect(copied.type, testModel.type);
        expect(copied.dateTime, testModel.dateTime);
        expect(copied.calories, testModel.calories);
      });
    });
  });
}