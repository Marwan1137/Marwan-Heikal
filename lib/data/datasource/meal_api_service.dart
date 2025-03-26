import 'package:injectable/injectable.dart';
import 'package:dio/dio.dart';
import '../model/meal_api_model.dart';

@injectable
class MealApiService {
  final Dio _dio;

  MealApiService(this._dio);
  final String baseUrl = 'https://www.themealdb.com/api/json/v1/1';

  Future<List<MealApiModel>> searchMeals(String query) async {
    try {
      final response = await _dio.get('$baseUrl/search.php', queryParameters: {'s': query});

      if (response.data['meals'] == null) return [];

      return (response.data['meals'] as List)
          .map((meal) => MealApiModel.fromJson(meal))
          .toList();
    } catch (e) {
      throw Exception('Failed to search meals');
    }
  }

  Future<List<String>> getCategories() async {
    try {
      final response = await _dio.get('$baseUrl/categories.php');
      return (response.data['categories'] as List)
          .map((category) => category['strCategory'] as String)
          .toList();
    } catch (e) {
      throw Exception('Failed to fetch categories');
    }
  }
}
