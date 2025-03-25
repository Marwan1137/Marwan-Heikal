import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/core/failures.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';
import 'package:meal_tracker/core/result.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';
import 'package:meal_tracker/domain/usecases/add_meal_usecase.dart';
import 'package:meal_tracker/domain/usecases/delete_meal_usecase.dart';
import 'package:meal_tracker/domain/usecases/sort_meal_usecase.dart';
import 'package:meal_tracker/domain/usecases/update_meal_usecase.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_intent.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_state.dart';

import 'cubit_meal_test.mocks.dart';

@GenerateMocks([
  MealRepo,
  AddMealUsecase,
  DeleteMealUsecase,
  SortMealUsecase,
  UpdateMealUsecase,
])
void main() {
  late CubitMeal cubit;
  late MockMealRepo mockRepo;
  late MockAddMealUsecase mockAddMealUsecase;
  late MockDeleteMealUsecase mockDeleteMealUsecase;
  late MockSortMealUsecase mockSortMealUsecase;
  late MockUpdateMealUsecase mockUpdateMealUsecase;
  late Meal testMeal;

  setUp(() {
    mockRepo = MockMealRepo();
    mockAddMealUsecase = MockAddMealUsecase();
    mockDeleteMealUsecase = MockDeleteMealUsecase();
    mockSortMealUsecase = MockSortMealUsecase();
    mockUpdateMealUsecase = MockUpdateMealUsecase();

    cubit = CubitMeal(
      mockRepo,
      mockAddMealUsecase,
      mockDeleteMealUsecase,
      mockSortMealUsecase,
      mockUpdateMealUsecase,
    );

    testMeal = Meal(
      id: '1',
      name: 'Test Meal',
      type: MealType.breakfast,
      dateTime: DateTime(2024, 1, 1),
      calories: 300,
    );
  });

  group('CubitMeal Tests', () {
    test('initial state should be empty', () {
      expect(cubit.state, const MealState());
    });

    group('LoadMealsIntent', () {
      test('should load and sort meals successfully', () async {
        when(mockRepo.getMeals()).thenAnswer((_) async => Success([testMeal]));
        when(mockSortMealUsecase(
          meals: anyNamed('meals'),
          sortBy: anyNamed('sortBy'),
        )).thenAnswer((_) async => Success([testMeal]));

        cubit.onIntent(LoadMealsIntent());

        await untilCalled(mockRepo.getMeals());
        verify(mockRepo.getMeals()).called(1);

        await untilCalled(mockSortMealUsecase(
          meals: anyNamed('meals'),
          sortBy: anyNamed('sortBy'),
        ));

        expect(cubit.state.status, UIStatus.success);
        expect(cubit.state.meals.length, 1);
        expect(cubit.state.totalCalories, 300);
      });

      test('should handle error when loading meals fails', () async {
        when(mockRepo.getMeals())
            .thenAnswer((_) async => Error(StorageFailure('Test error')));

        cubit.onIntent(LoadMealsIntent());

        await untilCalled(mockRepo.getMeals());
        verify(mockRepo.getMeals()).called(1);

        expect(cubit.state.status, UIStatus.error);
      });
    });

    group('AddMealIntent', () {
      test('should add meal successfully', () async {
        when(mockAddMealUsecase(any))
            .thenAnswer((_) async => Success(testMeal));
        when(mockSortMealUsecase(
          meals: anyNamed('meals'),
          sortBy: anyNamed('sortBy'),
        )).thenAnswer((_) async => Success([testMeal]));

        cubit.onIntent(AddMealIntent(testMeal));

        await untilCalled(mockAddMealUsecase(any));
        verify(mockAddMealUsecase(testMeal)).called(1);

        await Future.delayed(Duration.zero);

        expect(cubit.state.status, UIStatus.success);
        expect(cubit.state.meals.length, 1);
      });
    });

    group('UpdateMealIntent', () {
      test('should update meal successfully', () async {
        when(mockUpdateMealUsecase(any))
            .thenAnswer((_) async => Success(testMeal));
        when(mockSortMealUsecase(
          meals: anyNamed('meals'),
          sortBy: anyNamed('sortBy'),
        )).thenAnswer((_) async => Success([testMeal]));

        cubit.onIntent(UpdateMealIntent(testMeal));

        await untilCalled(mockUpdateMealUsecase(any));
        verify(mockUpdateMealUsecase(testMeal)).called(1);

        // Wait for state changes
        await Future.delayed(Duration.zero);

        expect(cubit.state.status, UIStatus.success);
      });
    });

    group('DeleteMealIntent', () {
      test('should delete meal successfully', () async {
        when(mockDeleteMealUsecase(any))
            .thenAnswer((_) async => const Success(true));
        when(mockSortMealUsecase(
          meals: anyNamed('meals'),
          sortBy: anyNamed('sortBy'),
        )).thenAnswer((_) async => Success([]));

        cubit.onIntent(DeleteMealIntent(testMeal.id));

        await untilCalled(mockDeleteMealUsecase(any));
        verify(mockDeleteMealUsecase(testMeal.id)).called(1);

        // Wait for state changes
        await Future.delayed(Duration.zero);

        expect(cubit.state.status, UIStatus.success);
        expect(cubit.state.meals, isEmpty);
      });
    });

    group('SortMealsIntent', () {
      test('should sort meals successfully', () async {
        when(mockSortMealUsecase(
          meals: anyNamed('meals'),
          sortBy: anyNamed('sortBy'),
        )).thenAnswer((_) async => Success([testMeal]));

        cubit.onIntent(SortMealsIntent(SortBy.date));

        await untilCalled(mockSortMealUsecase(
          meals: anyNamed('meals'),
          sortBy: anyNamed('sortBy'),
        ));

        expect(cubit.state.status, UIStatus.success);
        expect(cubit.state.meals.length, 1);
      });
    });
  });
}
