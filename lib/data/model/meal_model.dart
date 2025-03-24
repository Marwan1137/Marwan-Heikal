import '../../domain/entity/meal.dart';

class MealModel extends Meal {
  MealModel({
    required String id,
    required String name,
    required MealType type,
    required DateTime dateTime,
    required int calories,
  }) : super(
          id: id,
          name: name,
          type: type,
          dateTime: dateTime,
          calories: calories,
        );

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'],
      name: json['name'],
      type: MealType.values[json['type']],
      dateTime: DateTime.parse(json['dateTime']),
      calories: json['calories'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'dateTime': dateTime.toIso8601String(),
      'calories': calories,
    };
  }

  factory MealModel.fromMeal(Meal meal) {
    return MealModel(
      id: meal.id,
      name: meal.name,
      type: meal.type,
      dateTime: meal.dateTime,
      calories: meal.calories,
    );
  }
}
