import 'package:flutter_test/flutter_test.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:meal_tracker/core/result.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';
import 'package:meal_tracker/domain/usecases/delete_meal_usecase.dart';

import 'add_meal_usecase_test.mocks.dart';

@GenerateMocks([MealRepo])
void main() {
  late DeleteMealUsecase usecase;
  late MockMealRepo mockRepo;

  setUp(() {
    mockRepo = MockMealRepo();
    usecase = DeleteMealUsecase(mockRepo);
  });

  test('should delete meal successfully', () async {
    const mealId = '1';
    when(mockRepo.deleteMeal(mealId))
        .thenAnswer((_) async => const Success(true));

    final result = await usecase(mealId);
    expect(result, isA<Success<bool>>());
    verify(mockRepo.deleteMeal(mealId)).called(1);
  });
}
