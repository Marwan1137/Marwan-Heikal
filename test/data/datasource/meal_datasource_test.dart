import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:meal_tracker/data/datasource/meal_datasource.dart';
import 'package:meal_tracker/data/model/meal_model.dart';
import 'package:meal_tracker/domain/entity/meal.dart';

import 'meal_datasource_test.mocks.dart';

@GenerateMocks([MealDatasource])
void main() {
  late MockMealDatasource datasource;
  late MealModel testMealModel;

  setUp(() {
    datasource = MockMealDatasource();
    testMealModel = MealModel(
      id: '1',
      name: 'Test Meal',
      type: MealType.breakfast,
      dateTime: DateTime(2024, 1, 1),
      calories: 300,
    );
  });

  group('MealDatasource Tests', () {
    test('getMeals should return list of meals', () async {
      when(datasource.getMeals()).thenAnswer((_) async => [testMealModel]);

      final meals = await datasource.getMeals();
      expect(meals.length, 1);
      expect(meals.first.id, '1');
      verify(datasource.getMeals()).called(1);
    });

    test('addMeal should return added meal', () async {
      when(datasource.addMeal(testMealModel))
          .thenAnswer((_) async => testMealModel);

      final result = await datasource.addMeal(testMealModel);
      expect(result.id, testMealModel.id);
      verify(datasource.addMeal(testMealModel)).called(1);
    });

    test('updateMeal should return updated meal', () async {
      when(datasource.updateMeal(testMealModel))
          .thenAnswer((_) async => testMealModel);

      final result = await datasource.updateMeal(testMealModel);
      expect(result.id, testMealModel.id);
      verify(datasource.updateMeal(testMealModel)).called(1);
    });

    test('deleteMeal should return true on success', () async {
      when(datasource.deleteMeal(testMealModel.id))
          .thenAnswer((_) async => true);

      final result = await datasource.deleteMeal(testMealModel.id);
      expect(result, true);
      verify(datasource.deleteMeal(testMealModel.id)).called(1);
    });

    test('saveMeals should complete successfully', () async {
      when(datasource.saveMeals([testMealModel])).thenAnswer((_) async => {});

      await datasource.saveMeals([testMealModel]);
      verify(datasource.saveMeals([testMealModel])).called(1);
    });
  });
}
