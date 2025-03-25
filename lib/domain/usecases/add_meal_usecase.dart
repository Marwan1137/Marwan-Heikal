import 'package:injectable/injectable.dart';
import '../entity/meal.dart';
import '../repo/meal_repo.dart';
import '../../core/result.dart';

@injectable
class AddMealUsecase {
  final MealRepo _repo;

  AddMealUsecase(this._repo);

  Future<Result<Meal>> call(Meal meal) async {
    return await _repo.addMeal(meal);
  }
}
