import 'package:injectable/injectable.dart';
import '../../domain/repo/meal_repository.dart';
import '../datasource/meal_api_service.dart';
import '../model/meal_api_model.dart';

@Injectable(as: MealRepository)
class MealRepositoryImpl implements MealRepository {
  final MealApiService _apiService;

  MealRepositoryImpl(this._apiService);

  @override
  Future<List<MealApiModel>> searchMeals(String query) {
    return _apiService.searchMeals(query);
  }

  @override
  Future<List<String>> getCategories() {
    return _apiService.getCategories();
  }
}