import 'dart:convert';
import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:shared_preferences/shared_preferences.dart';
import 'package:meal_tracker/data/datasourceimpl/meal_datasource_impl.dart';
import 'package:meal_tracker/data/model/meal_model.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:meal_tracker/core/failures.dart';

import 'meal_datasource_impl_test.mocks.dart';

@GenerateMocks([SharedPreferences])
void main() {
  late MealDatasourceImpl datasource;
  late MockSharedPreferences mockPrefs;
  late MealModel testMeal;
  late String testMealJson;

  setUp(() {
    mockPrefs = MockSharedPreferences();
    datasource = MealDatasourceImpl(mockPrefs);
    testMeal = MealModel(
      id: '1',
      name: 'Test Meal',
      type: MealType.breakfast,
      dateTime: DateTime(2024, 1, 1),
      calories: 300,
    );
    testMealJson = jsonEncode(testMeal.toJson());
  });

  group('MealDatasourceImpl Tests', () {
    test('getMeals should return empty list when no meals saved', () async {
      when(mockPrefs.getStringList('meals')).thenReturn([]);

      final meals = await datasource.getMeals();
      expect(meals, isEmpty);
    });

    test('getMeals should return list of meals', () async {
      when(mockPrefs.getStringList('meals')).thenReturn([testMealJson]);

      final meals = await datasource.getMeals();
      expect(meals.length, 1);
      expect(meals.first.id, '1');
    });

    test('addMeal should save and return meal', () async {
      when(mockPrefs.getStringList('meals')).thenReturn([]);
      when(mockPrefs.setStringList('meals', any)).thenAnswer((_) async => true);

      final result = await datasource.addMeal(testMeal);
      expect(result.id, testMeal.id);
      verify(mockPrefs.setStringList('meals', any)).called(1);
    });

    test('updateMeal should update existing meal', () async {
      when(mockPrefs.getStringList('meals')).thenReturn([testMealJson]);
      when(mockPrefs.setStringList('meals', any)).thenAnswer((_) async => true);

      final updatedMeal = testMeal.copyWith(name: 'Updated Meal');
      final result = await datasource.updateMeal(updatedMeal);
      expect(result.name, 'Updated Meal');
      verify(mockPrefs.setStringList('meals', any)).called(1);
    });

    test('updateMeal should throw error when meal not found', () async {
      when(mockPrefs.getStringList('meals')).thenReturn([]);

      expect(
        () => datasource.updateMeal(testMeal),
        throwsA(isA<StorageFailure>()),
      );
    });

    test('deleteMeal should remove meal', () async {
      when(mockPrefs.getStringList('meals')).thenReturn([testMealJson]);
      when(mockPrefs.setStringList('meals', any)).thenAnswer((_) async => true);

      final result = await datasource.deleteMeal(testMeal.id);
      expect(result, true);
      verify(mockPrefs.setStringList('meals', [])).called(1);
    });

    test('saveMeals should save meals to SharedPreferences', () async {
      when(mockPrefs.setStringList('meals', any)).thenAnswer((_) async => true);

      await datasource.saveMeals([testMeal]);
      verify(mockPrefs.setStringList('meals', [testMealJson])).called(1);
    });
  });
}
