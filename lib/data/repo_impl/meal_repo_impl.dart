import 'package:injectable/injectable.dart';
import '../../domain/repo/meal_repo.dart';
import '../../domain/entity/meal.dart';
import '../datasource/meal_datasource.dart';
import '../model/meal_model.dart';
import '../../core/result.dart';
import '../../core/failures.dart';

@Injectable(as: MealRepo)
class MealRepoImpl implements MealRepo {
  final MealDatasource _datasource;

  MealRepoImpl(this._datasource);

  @override
  Future<Result<List<Meal>>> getMeals() async {
    try {
      final meals = await _datasource.getMeals();
      return Success(meals);
    } catch (e) {
      return Error(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<Meal>> addMeal(Meal meal) async {
    try {
      final mealModel = MealModel.fromMeal(meal);
      final result = await _datasource.addMeal(mealModel);
      return Success(result);
    } catch (e) {
      return Error(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<Meal>> updateMeal(Meal meal) async {
    try {
      final mealModel = MealModel.fromMeal(meal);
      final result = await _datasource.updateMeal(mealModel);
      return Success(result);
    } catch (e) {
      return Error(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<bool>> deleteMeal(String id) async {
    try {
      final result = await _datasource.deleteMeal(id);
      return Success(result);
    } catch (e) {
      return Error(StorageFailure(e.toString()));
    }
  }

  @override
  Future<Result<List<Meal>>> sortMeals({
    required List<Meal> meals,
    required SortBy sortBy,
  }) async {
    try {
      final sortedMeals = List<Meal>.from(meals);
      switch (sortBy) {
        case SortBy.date:
          sortedMeals.sort((a, b) => b.dateTime.compareTo(a.dateTime));
          break;
        case SortBy.calories:
          sortedMeals.sort((a, b) => b.calories.compareTo(a.calories));
          break;
        case SortBy.name:
          sortedMeals.sort((a, b) => a.name.compareTo(b.name));
          break;
      }
      return Success(sortedMeals);
    } catch (e) {
      return Error(GeneralFailure(e.toString()));
    }
  }
}
