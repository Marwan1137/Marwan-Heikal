// Mocks generated by Mockito 5.4.5 from annotations
// in meal_tracker/test/UI/screens/add_meal_screen.dart.
// Do not manually edit this file.

// ignore_for_file: no_leading_underscores_for_library_prefixes
import 'dart:async' as _i4;

import 'package:flutter_bloc/flutter_bloc.dart' as _i6;
import 'package:meal_tracker/UI/cubit/cubit_meal.dart' as _i3;
import 'package:meal_tracker/UI/cubit/cubit_meal_intent.dart' as _i5;
import 'package:meal_tracker/UI/cubit/cubit_meal_state.dart' as _i2;
import 'package:mockito/mockito.dart' as _i1;

// ignore_for_file: type=lint
// ignore_for_file: avoid_redundant_argument_values
// ignore_for_file: avoid_setters_without_getters
// ignore_for_file: comment_references
// ignore_for_file: deprecated_member_use
// ignore_for_file: deprecated_member_use_from_same_package
// ignore_for_file: implementation_imports
// ignore_for_file: invalid_use_of_visible_for_testing_member
// ignore_for_file: must_be_immutable
// ignore_for_file: prefer_const_constructors
// ignore_for_file: unnecessary_parenthesis
// ignore_for_file: camel_case_types
// ignore_for_file: subtype_of_sealed_class

class _FakeMealState_0 extends _i1.SmartFake implements _i2.MealState {
  _FakeMealState_0(Object parent, Invocation parentInvocation)
    : super(parent, parentInvocation);
}

/// A class which mocks [CubitMeal].
///
/// See the documentation for Mockito's code generation for more information.
class MockCubitMeal extends _i1.Mock implements _i3.CubitMeal {
  MockCubitMeal() {
    _i1.throwOnMissingStub(this);
  }

  @override
  _i2.MealState get state =>
      (super.noSuchMethod(
            Invocation.getter(#state),
            returnValue: _FakeMealState_0(this, Invocation.getter(#state)),
          )
          as _i2.MealState);

  @override
  _i4.Stream<_i2.MealState> get stream =>
      (super.noSuchMethod(
            Invocation.getter(#stream),
            returnValue: _i4.Stream<_i2.MealState>.empty(),
          )
          as _i4.Stream<_i2.MealState>);

  @override
  bool get isClosed =>
      (super.noSuchMethod(Invocation.getter(#isClosed), returnValue: false)
          as bool);

  @override
  void onIntent(_i5.MealIntent? intent) => super.noSuchMethod(
    Invocation.method(#onIntent, [intent]),
    returnValueForMissingStub: null,
  );

  @override
  void emit(_i2.MealState? state) => super.noSuchMethod(
    Invocation.method(#emit, [state]),
    returnValueForMissingStub: null,
  );

  @override
  void onChange(_i6.Change<_i2.MealState>? change) => super.noSuchMethod(
    Invocation.method(#onChange, [change]),
    returnValueForMissingStub: null,
  );

  @override
  void addError(Object? error, [StackTrace? stackTrace]) => super.noSuchMethod(
    Invocation.method(#addError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  void onError(Object? error, StackTrace? stackTrace) => super.noSuchMethod(
    Invocation.method(#onError, [error, stackTrace]),
    returnValueForMissingStub: null,
  );

  @override
  _i4.Future<void> close() =>
      (super.noSuchMethod(
            Invocation.method(#close, []),
            returnValue: _i4.Future<void>.value(),
            returnValueForMissingStub: _i4.Future<void>.value(),
          )
          as _i4.Future<void>);
}
