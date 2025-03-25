import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:meal_tracker/core/result.dart';
import 'package:meal_tracker/core/failures.dart';
import 'package:meal_tracker/data/datasource/meal_datasource.dart';
import 'package:meal_tracker/data/model/meal_model.dart';
import 'package:meal_tracker/data/repo_impl/meal_repo_impl.dart';
import 'package:meal_tracker/domain/entity/meal.dart';

import '../datasource/meal_datasource_test.mocks.dart';

@GenerateMocks([MealDatasource])
void main() {
  late MealRepoImpl repo;
  late MockMealDatasource mockDatasource;
  late Meal testMeal;
  late MealModel testMealModel;

  setUp(() {
    mockDatasource = MockMealDatasource();
    repo = MealRepoImpl(mockDatasource);
    testMeal = Meal(
      id: '1',
      name: 'Test Meal',
      type: MealType.breakfast,
      dateTime: DateTime(2024, 1, 1),
      calories: 300,
    );
    testMealModel = MealModel.fromMeal(testMeal);
  });

  group('MealRepoImpl Tests', () {
    group('getMeals', () {
      test('should return Success with meals when datasource succeeds',
          () async {
        when(mockDatasource.getMeals())
            .thenAnswer((_) async => [testMealModel]);

        final result = await repo.getMeals();
        expect(result, isA<Success<List<Meal>>>());
        verify(mockDatasource.getMeals()).called(1);
      });

      test('should return Error when datasource throws', () async {
        when(mockDatasource.getMeals()).thenThrow(Exception('Test error'));

        final result = await repo.getMeals();
        expect(result, isA<Error>());
        expect((result as Error).failure, isA<StorageFailure>());
      });
    });

    group('addMeal', () {
      test('should return Success with meal when datasource succeeds',
          () async {
        when(mockDatasource.addMeal(any))
            .thenAnswer((_) async => testMealModel);

        final result = await repo.addMeal(testMeal);
        expect(result, isA<Success<Meal>>());
        verify(mockDatasource.addMeal(any)).called(1);
      });

      test('should return Error when datasource throws', () async {
        when(mockDatasource.addMeal(any)).thenThrow(Exception('Test error'));

        final result = await repo.addMeal(testMeal);
        expect(result, isA<Error>());
        expect((result as Error).failure, isA<StorageFailure>());
      });
    });

    group('updateMeal', () {
      test('should return Success with meal when datasource succeeds',
          () async {
        when(mockDatasource.updateMeal(any))
            .thenAnswer((_) async => testMealModel);

        final result = await repo.updateMeal(testMeal);
        expect(result, isA<Success<Meal>>());
        verify(mockDatasource.updateMeal(any)).called(1);
      });

      test('should return Error when datasource throws', () async {
        when(mockDatasource.updateMeal(any)).thenThrow(Exception('Test error'));

        final result = await repo.updateMeal(testMeal);
        expect(result, isA<Error>());
        expect((result as Error).failure, isA<StorageFailure>());
      });
    });

    group('deleteMeal', () {
      test('should return Success when datasource succeeds', () async {
        when(mockDatasource.deleteMeal(any)).thenAnswer((_) async => true);

        final result = await repo.deleteMeal('1');
        expect(result, isA<Success<bool>>());
        verify(mockDatasource.deleteMeal('1')).called(1);
      });

      test('should return Error when datasource throws', () async {
        when(mockDatasource.deleteMeal(any)).thenThrow(Exception('Test error'));

        final result = await repo.deleteMeal('1');
        expect(result, isA<Error>());
        expect((result as Error).failure, isA<StorageFailure>());
      });
    });

    group('sortMeals', () {
      test('should sort meals by date in descending order', () async {
        final meals = [
          testMeal,
          testMeal.copywith(
            id: '2',
            dateTime: DateTime(2024, 1, 2),
          ),
        ];

        final result = await repo.sortMeals(
          meals: meals,
          sortBy: SortBy.date,
        );

        expect(result, isA<Success<List<Meal>>>());
        final success = result as Success<List<Meal>>;
        expect(success.data.first.id, '2');
      });

      test('should sort meals by calories in descending order', () async {
        final meals = [
          testMeal,
          testMeal.copywith(
            id: '2',
            calories: 500,
          ),
        ];

        final result = await repo.sortMeals(
          meals: meals,
          sortBy: SortBy.calories,
        );

        expect(result, isA<Success<List<Meal>>>());
        final success = result as Success<List<Meal>>;
        expect(success.data.first.id, '2');
      });

      test('should sort meals by name in ascending order', () async {
        final meals = [
          testMeal.copywith(name: 'B Meal'),
          testMeal.copywith(name: 'A Meal'),
        ];

        final result = await repo.sortMeals(
          meals: meals,
          sortBy: SortBy.name,
        );

        expect(result, isA<Success<List<Meal>>>());
        final success = result as Success<List<Meal>>;
        expect(success.data.first.name, 'A Meal');
      });
    });
  });
}
