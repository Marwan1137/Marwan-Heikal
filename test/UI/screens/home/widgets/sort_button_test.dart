import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_intent.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_state.dart';
import 'package:meal_tracker/UI/screens/home/widgets/sort_button.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'sort_button_test.mocks.dart';

@GenerateMocks([CubitMeal])
void main() {
  late MockCubitMeal mockCubit;

  setUp(() {
    mockCubit = MockCubitMeal();
    when(mockCubit.stream).thenAnswer((_) => Stream.value(const MealState()));
    when(mockCubit.state).thenReturn(const MealState());
  });

  Widget createWidgetUnderTest() {
    return MaterialApp(
      home: BlocProvider<CubitMeal>.value(
        value: mockCubit,
        child: const Scaffold(
          body: SortButton(),
        ),
      ),
    );
  }

  group('SortButton Tests', () {
    testWidgets('should render sort icon button', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());
      expect(find.byIcon(Icons.sort), findsOneWidget);
    });

    testWidgets('should show popup menu on tap', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      expect(find.text('Sort by Date'), findsOneWidget);
      expect(find.text('Sort by Calories'), findsOneWidget);
      expect(find.text('Sort by Name'), findsOneWidget);
    });

    testWidgets('should call cubit with correct intent when date sort selected',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sort by Date'));
      await tester.pumpAndSettle();

      verify(mockCubit.onIntent(argThat(isA<SortMealsIntent>()))).called(1);
    });

    testWidgets(
        'should call cubit with correct intent when calories sort selected',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sort by Calories'));
      await tester.pumpAndSettle();

      verify(mockCubit.onIntent(argThat(isA<SortMealsIntent>()))).called(1);
    });

    testWidgets('should call cubit with correct intent when name sort selected',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byIcon(Icons.sort));
      await tester.pumpAndSettle();

      await tester.tap(find.text('Sort by Name'));
      await tester.pumpAndSettle();

      verify(mockCubit.onIntent(argThat(isA<SortMealsIntent>()))).called(1);
    });
  });
}
