class MealApiModel {
  final String idMeal;
  final String strMeal;
  final String strMealThumb;
  final String? strCategory;

  MealApiModel({
    required this.idMeal,
    required this.strMeal,
    required this.strMealThumb,
    this.strCategory,
  });

  factory MealApiModel.fromJson(Map<String, dynamic> json) {
    return MealApiModel(
      idMeal: json['idMeal'] ?? '',
      strMeal: json['strMeal'] ?? '',
      strMealThumb: json['strMealThumb'] ?? '',
      strCategory: json['strCategory'],
    );
  }
}