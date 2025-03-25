import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:meal_tracker/core/result.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';
import 'package:meal_tracker/domain/usecases/update_meal_usecase.dart';

import 'add_meal_usecase_test.mocks.dart';

@GenerateMocks([MealRepo])
void main() {
  late UpdateMealUsecase usecase;
  late MockMealRepo mockRepo;
  late Meal testMeal;

  setUp(() {
    mockRepo = MockMealRepo();
    usecase = UpdateMealUsecase(mockRepo);
    testMeal = Meal(
      id: '1',
      name: 'Updated Meal',
      type: MealType.breakfast,
      dateTime: DateTime(2024, 1, 1),
      calories: 400,
    );
  });

  test('should update meal successfully', () async {
    when(mockRepo.updateMeal(testMeal))
        .thenAnswer((_) async => Success(testMeal));

    final result = await usecase(testMeal);
    expect(result, isA<Success<Meal>>());
    verify(mockRepo.updateMeal(testMeal)).called(1);
  });
}
