import '../../domain/entity/meal.dart';

class MealModel extends Meal {
  MealModel({
    required super.id,
    required super.name,
    required super.type,
    required super.dateTime,
    required super.calories,
    super.imageUrl,
  });

  factory MealModel.fromJson(Map<String, dynamic> json) {
    return MealModel(
      id: json['id'],
      name: json['name'],
      type: MealType.values[json['type']],
      dateTime: DateTime.parse(json['dateTime']),
      calories: json['calories'],
      imageUrl: json['imageUrl'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'type': type.index,
      'dateTime': dateTime.toIso8601String(),
      'calories': calories,
      'imageUrl': imageUrl,
    };
  }

  factory MealModel.fromMeal(Meal meal) {
    return MealModel(
      id: meal.id,
      name: meal.name,
      type: meal.type,
      dateTime: meal.dateTime,
      calories: meal.calories,
      imageUrl: meal.imageUrl,
    );
  }

  MealModel copyWith({
    String? id,
    String? name,
    MealType? type,
    DateTime? dateTime,
    int? calories,
  }) {
    return MealModel(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      calories: calories ?? this.calories,
    );
  }
}
