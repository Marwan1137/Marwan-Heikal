import 'package:injectable/injectable.dart';
import '../entity/meal.dart';
import '../repo/meal_repo.dart';
import '../../core/result.dart';

@injectable
class SortMealUsecase {
  final MealRepo _repo;

  SortMealUsecase(this._repo);

  Future<Result<List<Meal>>> call({
    required List<Meal> meals,
    required SortBy sortBy,
  }) async {
    return await _repo.sortMeals(
      meals: meals,
      sortBy: sortBy,
    );
  }
}