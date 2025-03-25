import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_intent.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_state.dart';
import 'package:meal_tracker/UI/screens/add_meal_screen.dart';
import 'package:meal_tracker/UI/screens/home/home_screen.dart';
import 'package:meal_tracker/UI/screens/home/widgets/empty_meals_view.dart';
import 'package:meal_tracker/UI/screens/home/widgets/meals_list.dart';
import 'package:meal_tracker/UI/screens/home/widgets/total_calories_card.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'widgets/sort_button_test.mocks.dart';

@GenerateMocks([CubitMeal])
void main() {
  late MockCubitMeal mockCubit;

  setUp(() {
    mockCubit = MockCubitMeal();
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<CubitMeal>.value(
        value: mockCubit,
        child: const HomeScreen(),
      ),
    );
  }

  group('HomeScreen Tests', () {
    testWidgets('should show loading indicator when status is loading',
        (tester) async {
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          const MealState(status: UIStatus.loading),
        ),
      );
      when(mockCubit.state).thenReturn(
        const MealState(status: UIStatus.loading),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(CircularProgressIndicator), findsOneWidget);
    });

    testWidgets('should show empty view when no meals are available',
        (tester) async {
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          const MealState(status: UIStatus.success, meals: []),
        ),
      );
      when(mockCubit.state).thenReturn(
        const MealState(status: UIStatus.success, meals: []),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(EmptyMealsView), findsOneWidget);
    });

    testWidgets('should show meals list when meals are available',
        (tester) async {
      final testMeals = [
        Meal(
          id: '1',
          name: 'Test Meal',
          type: MealType.breakfast,
          dateTime: DateTime.now(),
          calories: 300,
        ),
      ];

      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          MealState(
            status: UIStatus.success,
            meals: testMeals,
            totalCalories: 300,
          ),
        ),
      );
      when(mockCubit.state).thenReturn(
        MealState(
          status: UIStatus.success,
          meals: testMeals,
          totalCalories: 300,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.byType(MealsList), findsOneWidget);
      expect(find.byType(TotalCaloriesCard), findsOneWidget);
    });

    testWidgets('should navigate to add meal screen when FAB is pressed',
        (tester) async {
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(const MealState()),
      );
      when(mockCubit.state).thenReturn(const MealState());

      await tester.pumpWidget(
        BlocProvider<CubitMeal>.value(
          value: mockCubit,
          child: MaterialApp(
            home: const HomeScreen(),
            onGenerateRoute: (settings) {
              return MaterialPageRoute(
                builder: (context) => const AddMealScreen(),
              );
            },
          ),
        ),
      );

      await tester.tap(find.byType(FloatingActionButton));
      await tester.pumpAndSettle();

      expect(find.byType(AddMealScreen), findsOneWidget);
    });

    testWidgets('should delete meal when delete is called', (tester) async {
      final testMeals = [
        Meal(
          id: '1',
          name: 'Test Meal',
          type: MealType.breakfast,
          dateTime: DateTime.now(),
          calories: 300,
        ),
      ];

      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(
          MealState(
            status: UIStatus.success,
            meals: testMeals,
            totalCalories: 300,
          ),
        ),
      );
      when(mockCubit.state).thenReturn(
        MealState(
          status: UIStatus.success,
          meals: testMeals,
          totalCalories: 300,
        ),
      );

      await tester.pumpWidget(createWidgetUnderTest());

      final mealsList = tester.widget<MealsList>(find.byType(MealsList));
      mealsList.onDelete('1');
      await tester.pump();

      verify(mockCubit.onIntent(argThat(
        isA<DeleteMealIntent>().having(
          (intent) => intent.id,
          'id',
          '1',
        ),
      ))).called(1);
    });

    testWidgets('should have correct app bar', (tester) async {
      when(mockCubit.stream).thenAnswer(
        (_) => Stream.value(const MealState()),
      );
      when(mockCubit.state).thenReturn(const MealState());

      await tester.pumpWidget(createWidgetUnderTest());

      final appBar = find.byType(AppBar);
      expect(appBar, findsOneWidget);

      expect(find.text('Meal Tracker'), findsOneWidget);
      expect(
        (tester.widget(appBar) as AppBar).backgroundColor,
        Colors.green,
      );
    });
  });
}
