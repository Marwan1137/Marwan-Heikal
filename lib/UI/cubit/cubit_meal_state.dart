import '../../domain/entity/meal.dart';
import '../../domain/repo/meal_repo.dart';

enum UIStatus { initial, loading, success, error }

class MealState {
  final UIStatus status;
  final List<Meal> meals;
  final int totalCalories;
  final String? errorMessage;
  final SortBy currentSort;

  const MealState({
    this.status = UIStatus.initial,
    this.meals = const [],
    this.totalCalories = 0,
    this.errorMessage,
    this.currentSort = SortBy.date,
  });

  MealState copyWith({
    UIStatus? status,
    List<Meal>? meals,
    int? totalCalories,
    String? errorMessage,
    SortBy? currentSort,
  }) {
    return MealState(
      status: status ?? this.status,
      meals: meals ?? this.meals,
      totalCalories: totalCalories ?? this.totalCalories,
      errorMessage: errorMessage ?? this.errorMessage,
      currentSort: currentSort ?? this.currentSort,
    );
  }
}