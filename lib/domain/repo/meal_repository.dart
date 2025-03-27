import '../../data/model/meal_api_model.dart';

abstract class MealRepository {
  Future<List<MealApiModel>> searchMeals(String query);
  Future<List<String>> getCategories();
}