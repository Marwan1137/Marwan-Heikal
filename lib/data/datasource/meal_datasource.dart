import '../model/meal_model.dart';

abstract class MealDatasource {
  Future<List<MealModel>> getMeals();
  Future<MealModel> addMeal(MealModel meal);
  Future<MealModel> updateMeal(MealModel meal);
  Future<bool> deleteMeal(String id);
  Future<void> saveMeals(List<MealModel> meals);
}
