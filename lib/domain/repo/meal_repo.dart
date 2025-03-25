import '../entity/meal.dart';
import '../../core/result.dart';

abstract class MealRepo {
  Future<Result<List<Meal>>> getMeals();
  Future<Result<Meal>> addMeal(Meal meal);
  Future<Result<Meal>> updateMeal(Meal meal);
  Future<Result<bool>> deleteMeal(String id);
  Future<Result<List<Meal>>> sortMeals({
    required List<Meal> meals,
    required SortBy sortBy,
  });
}

enum SortBy {
  date,
  calories,
  name,
}
