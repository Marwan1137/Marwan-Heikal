import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:meal_tracker/core/result.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';
import 'package:meal_tracker/domain/usecases/sort_meal_usecase.dart';

import 'add_meal_usecase_test.mocks.dart';

@GenerateMocks([MealRepo])
void main() {
  late SortMealUsecase usecase;
  late MockMealRepo mockRepo;
  late List<Meal> testMeals;

  setUp(() {
    mockRepo = MockMealRepo();
    usecase = SortMealUsecase(mockRepo);
    testMeals = [
      Meal(
        id: '1',
        name: 'Test Meal 1',
        type: MealType.breakfast,
        dateTime: DateTime(2024, 1, 1),
        calories: 300,
      ),
    ];
  });

  test('should sort meals successfully', () async {
    when(mockRepo.sortMeals(meals: testMeals, sortBy: SortBy.date))
        .thenAnswer((_) async => Success(testMeals));

    final result = await usecase(meals: testMeals, sortBy: SortBy.date);
    expect(result, isA<Success<List<Meal>>>());
    verify(mockRepo.sortMeals(meals: testMeals, sortBy: SortBy.date)).called(1);
  });
}
