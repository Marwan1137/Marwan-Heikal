import 'package:injectable/injectable.dart';
import '../repo/meal_repo.dart';
import '../../core/result.dart';

@injectable
class DeleteMealUsecase {
  final MealRepo _repo;

  DeleteMealUsecase(this._repo);

  Future<Result<bool>> call(String id) async {
    return await _repo.deleteMeal(id);
  }
}