import 'dart:convert';
import 'package:injectable/injectable.dart';
import 'package:shared_preferences/shared_preferences.dart';
import '../datasource/meal_datasource.dart';
import '../model/meal_model.dart';
import '../../core/failures.dart';

@Injectable(as: MealDatasource)
class MealDatasourceImpl implements MealDatasource {
  final SharedPreferences _prefs;
  static const String _mealsKey = 'meals';

  MealDatasourceImpl(this._prefs);

  @override
  Future<List<MealModel>> getMeals() async {
    final mealsJson = _prefs.getStringList(_mealsKey) ?? [];
    return mealsJson
        .map((json) => MealModel.fromJson(jsonDecode(json)))
        .toList();
  }

  @override
  Future<MealModel> addMeal(MealModel meal) async {
    final meals = await getMeals();
    meals.add(meal);
    await saveMeals(meals);
    return meal;
  }

  @override
  Future<MealModel> updateMeal(MealModel meal) async {
    final meals = await getMeals();
    final index = meals.indexWhere((m) => m.id == meal.id);
    if (index != -1) {
      meals[index] = meal;
      await saveMeals(meals);
      return meal;
    }
    throw StorageFailure('Meal not found');
  }

  @override
  Future<bool> deleteMeal(String id) async {
    final meals = await getMeals();
    final filtered = meals.where((meal) => meal.id != id).toList();
    await saveMeals(filtered);
    return true;
  }

  @override
  Future<void> saveMeals(List<MealModel> meals) async {
    final mealsJson = meals.map((meal) => jsonEncode(meal.toJson())).toList();
    await _prefs.setStringList(_mealsKey, mealsJson);
  }
}
