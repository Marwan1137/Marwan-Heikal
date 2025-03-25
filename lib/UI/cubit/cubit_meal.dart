import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:injectable/injectable.dart';
import 'package:meal_tracker/domain/entity/meal.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';
import 'cubit_meal_state.dart';
import 'cubit_meal_intent.dart';
import '../../domain/usecases/add_meal_usecase.dart';
import '../../domain/usecases/delete_meal_usecase.dart';
import '../../domain/usecases/sort_meal_usecase.dart';
import '../../domain/usecases/update_meal_usecase.dart';
import '../../core/result.dart';

@injectable
class CubitMeal extends Cubit<MealState> {
  final MealRepo _repo;
  final AddMealUsecase _addMealUsecase;
  final DeleteMealUsecase _deleteMealUsecase;
  final SortMealUsecase _sortMealUsecase;
  final UpdateMealUsecase _updateMealUsecase;

  CubitMeal(
    this._repo,
    this._addMealUsecase,
    this._deleteMealUsecase,
    this._sortMealUsecase,
    this._updateMealUsecase,
  ) : super(const MealState());

  void onIntent(MealIntent intent) async {
    switch (intent.runtimeType) {
      case const (LoadMealsIntent):
        await _handleLoadMeals();
        break;
      case const (AddMealIntent):
        await _handleAddMeal((intent as AddMealIntent).meal);
        break;
      case const (UpdateMealIntent):
        await _handleUpdateMeal((intent as UpdateMealIntent).meal);
        break;
      case const (DeleteMealIntent):
        await _handleDeleteMeal((intent as DeleteMealIntent).id);
        break;
      case const (SortMealsIntent):
        await _handleSortMeals((intent as SortMealsIntent).sortBy);
        break;
    }
  }

  Future<void> _handleLoadMeals() async {
    emit(state.copyWith(status: UIStatus.loading));
    // First, get meals from repository
    final mealsResult = await _repo.getMeals();
    if (mealsResult is Success<List<Meal>>) {
      // Then sort them
      final sortResult = await _sortMealUsecase(
        meals: mealsResult.data,
        sortBy: state.currentSort,
      );
      _handleResult(sortResult);
    } else if (mealsResult is Error<List<Meal>>) {
      emit(state.copyWith(
        status: UIStatus.error,
        errorMessage: mealsResult.failure.message,
      ));
    }
  }

  Future<void> _handleAddMeal(Meal meal) async {
    emit(state.copyWith(status: UIStatus.loading));
    final result = await _addMealUsecase(meal);
    if (result is Success<Meal>) {
      final updatedMeals = [...state.meals, result.data];
      final sortResult = await _sortMealUsecase(
        meals: updatedMeals,
        sortBy: state.currentSort,
      );
      _handleResult(sortResult);
    } else if (result is Error<Meal>) {
      emit(state.copyWith(
        status: UIStatus.error,
        errorMessage: result.failure.message,
      ));
    }
  }

  Future<void> _handleUpdateMeal(Meal meal) async {
    emit(state.copyWith(status: UIStatus.loading));
    final result = await _updateMealUsecase(meal);
    if (result is Success<Meal>) {
      final updatedMeals = state.meals.map((m) {
        return m.id == meal.id ? result.data : m;
      }).toList();
      final sortResult = await _sortMealUsecase(
        meals: updatedMeals,
        sortBy: state.currentSort,
      );
      _handleResult(sortResult);
    } else if (result is Error<Meal>) {
      emit(state.copyWith(
        status: UIStatus.error,
        errorMessage: result.failure.message,
      ));
    }
  }

  Future<void> _handleDeleteMeal(String id) async {
    emit(state.copyWith(status: UIStatus.loading));
    final result = await _deleteMealUsecase(id);
    if (result is Success<bool>) {
      final updatedMeals = state.meals.where((meal) => meal.id != id).toList();
      final sortResult = await _sortMealUsecase(
        meals: updatedMeals,
        sortBy: state.currentSort,
      );
      _handleResult(sortResult);
    } else if (result is Error<bool>) {
      emit(state.copyWith(
        status: UIStatus.error,
        errorMessage: result.failure.message,
      ));
    }
  }

  void _handleResult(Result<List<Meal>> result) {
    if (result is Success<List<Meal>>) {
      final totalCalories = result.data.fold<int>(
        0,
        (sum, meal) => sum + meal.calories,
      );
      emit(state.copyWith(
        status: UIStatus.success,
        meals: result.data,
        totalCalories: totalCalories,
        errorMessage: null,
      ));
    } else if (result is Error<List<Meal>>) {
      emit(state.copyWith(
        status: UIStatus.error,
        errorMessage: result.failure.message,
      ));
    }
  }

  Future<void> _handleSortMeals(SortBy sortBy) async {
    emit(state.copyWith(status: UIStatus.loading));
    final result = await _sortMealUsecase(
      meals: state.meals,
      sortBy: sortBy,
    );
    _handleResult(result);
  }
}
