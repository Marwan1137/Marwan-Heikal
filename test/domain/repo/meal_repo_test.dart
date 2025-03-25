import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:meal_tracker/core/result.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';

import '../usecases/add_meal_usecase_test.mocks.dart';

@GenerateMocks([MealRepo])
void main() {
  late MockMealRepo repo;
  late Meal testMeal;

  setUp(() {
    repo = MockMealRepo();
    testMeal = Meal(
      id: '1',
      name: 'Test Meal',
      type: MealType.breakfast,
      dateTime: DateTime(2024, 1, 1),
      calories: 300,
    );
  });

  group('MealRepo Tests', () {
    test('getMeals should return list of meals', () async {
      when(repo.getMeals()).thenAnswer((_) async => Success([testMeal]));

      final result = await repo.getMeals();
      expect(result, isA<Success<List<Meal>>>());
      verify(repo.getMeals()).called(1);
    });

    test('addMeal should return added meal', () async {
      when(repo.addMeal(testMeal)).thenAnswer((_) async => Success(testMeal));

      final result = await repo.addMeal(testMeal);
      expect(result, isA<Success<Meal>>());
      verify(repo.addMeal(testMeal)).called(1);
    });

    test('updateMeal should return updated meal', () async {
      when(repo.updateMeal(testMeal))
          .thenAnswer((_) async => Success(testMeal));

      final result = await repo.updateMeal(testMeal);
      expect(result, isA<Success<Meal>>());
      verify(repo.updateMeal(testMeal)).called(1);
    });

    test('deleteMeal should return success', () async {
      when(repo.deleteMeal(testMeal.id))
          .thenAnswer((_) async => const Success(true));

      final result = await repo.deleteMeal(testMeal.id);
      expect(result, isA<Success<bool>>());
      verify(repo.deleteMeal(testMeal.id)).called(1);
    });

    test('sortMeals should return sorted list', () async {
      final meals = [testMeal];
      when(repo.sortMeals(meals: meals, sortBy: SortBy.date))
          .thenAnswer((_) async => Success(meals));

      final result = await repo.sortMeals(
        meals: meals,
        sortBy: SortBy.date,
      );
      expect(result, isA<Success<List<Meal>>>());
      verify(repo.sortMeals(meals: meals, sortBy: SortBy.date)).called(1);
    });
  });
}
