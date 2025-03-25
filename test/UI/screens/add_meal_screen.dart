import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:flutter_test/flutter_test.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_intent.dart';
import 'package:meal_tracker/UI/screens/add_meal_screen.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:mockito/annotations.dart';
import 'package:mockito/mockito.dart';

import 'home/widgets/sort_button_test.mocks.dart';

@GenerateMocks([CubitMeal])
void main() {
  late MockCubitMeal mockCubit;

  setUp(() {
    mockCubit = MockCubitMeal();
  });

  Widget createWidgetUnderTest({Meal? mealToUpdate}) {
    return MaterialApp(
      home: BlocProvider<CubitMeal>.value(
        value: mockCubit,
        child: AddMealScreen(mealToUpdate: mealToUpdate),
      ),
    );
  }

  group('AddMealScreen Tests', () {
    testWidgets('should render all form fields', (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      expect(find.widgetWithText(AppBar, 'Add Meal'), findsOneWidget);
      expect(find.byType(TextFormField), findsNWidgets(2));
      expect(find.byType(DropdownButtonFormField<MealType>), findsOneWidget);
      expect(find.byType(InputDecorator), findsAtLeastNWidgets(1));
      expect(find.byType(ElevatedButton), findsOneWidget);
    });

    testWidgets('should show validation errors for empty fields',
        (tester) async {
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
      
      await tester.pumpWidget(createWidgetUnderTest());

      final nameField = find.byWidgetPredicate(
        (widget) => widget is TextField && (widget.decoration?.labelText == 'Meal Name'),
      );
      final caloriesField = find.byWidgetPredicate(
        (widget) => widget is TextField && (widget.decoration?.labelText == 'Calories'),
      );

      await tester.enterText(nameField, '');
      await tester.enterText(caloriesField, '');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pump(); 
      await tester.pump(); 
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == 'Please enter a meal name',
        ),
        findsOneWidget,
      );
      expect(
        find.byWidgetPredicate(
          (widget) => widget is Text && widget.data == 'Please enter calories',
        ),
        findsOneWidget,
      );
    });

    testWidgets('should add new meal when form is valid', (tester) async {
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
      when(mockCubit.onIntent(any)).thenAnswer((_) => Future.value());

      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Meal Name'), 'Test Meal');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Calories'), '300');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(mockCubit.onIntent(argThat(isA<AddMealIntent>()))).called(1);
    });

    testWidgets('should show validation error for invalid calories',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Calories'), 'abc');
      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      expect(find.text('Please enter a valid number'), findsOneWidget);
    });

    testWidgets('should populate fields when updating meal', (tester) async {
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
      
      final mealToUpdate = Meal(
        id: '1',
        name: 'Test Meal',
        type: MealType.lunch,
        dateTime: DateTime.now(),
        calories: 300,
      );

      await tester.pumpWidget(createWidgetUnderTest(mealToUpdate: mealToUpdate));

      expect(find.widgetWithText(AppBar, 'Update Meal'), findsOneWidget);
      expect(
        find.descendant(
          of: find.byType(TextFormField),
          matching: find.text('Test Meal'),
        ),
        findsOneWidget,
      );
      expect(
        find.descendant(
          of: find.byType(TextFormField),
          matching: find.text('300'),
        ),
        findsOneWidget,
      );
    });

    testWidgets('should update meal when form is valid', (tester) async {
      when(mockCubit.stream).thenAnswer((_) => const Stream.empty());
      when(mockCubit.onIntent(any)).thenAnswer((_) => Future.value());

      final mealToUpdate = Meal(
        id: '1',
        name: 'Test Meal',
        type: MealType.lunch,
        dateTime: DateTime.now(),
        calories: 300,
      );

      await tester.pumpWidget(createWidgetUnderTest(mealToUpdate: mealToUpdate));

      await tester.enterText(
          find.widgetWithText(TextFormField, 'Meal Name'), 'Updated Meal');
      await tester.enterText(
          find.widgetWithText(TextFormField, 'Calories'), '400');

      await tester.tap(find.byType(ElevatedButton));
      await tester.pumpAndSettle();

      verify(mockCubit.onIntent(argThat(isA<UpdateMealIntent>()))).called(1);
    });

    testWidgets('should change meal type when dropdown value changes',
        (tester) async {
      await tester.pumpWidget(createWidgetUnderTest());

      await tester.tap(find.byType(DropdownButtonFormField<MealType>));
      await tester.pumpAndSettle();

      await tester.tap(find.text('LUNCH').last);
      await tester.pumpAndSettle();

      expect(find.text('LUNCH'), findsOneWidget);
    });
  });
}