import 'package:injectable/injectable.dart';
import '../entity/meal.dart';
import '../repo/meal_repo.dart';
import '../../core/result.dart';

@injectable
class UpdateMealUsecase {
  final MealRepo _repo;

  UpdateMealUsecase(this._repo);

  Future<Result<Meal>> call(Meal meal) async {
    return await _repo.updateMeal(meal);
  }
}