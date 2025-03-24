import '../../domain/entity/meal.dart';
import '../../domain/repo/meal_repo.dart';

abstract class MealIntent {}

class LoadMealsIntent extends MealIntent {}

class AddMealIntent extends MealIntent {
  final Meal meal;
  AddMealIntent(this.meal);
}

class UpdateMealIntent extends MealIntent {
  final Meal meal;
  UpdateMealIntent(this.meal);
}

class DeleteMealIntent extends MealIntent {
  final String id;
  DeleteMealIntent(this.id);
}

class SortMealsIntent extends MealIntent {
  final SortBy sortBy;
  SortMealsIntent(this.sortBy);
}