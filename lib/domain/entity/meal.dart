enum MealType {
  breakfast,
  lunch,
  dinner,
  snack,
  dessert,
}

class Meal {
  final String id;
  final String name;
  final MealType type;
  final DateTime dateTime;
  final int calories;

  Meal({
    required this.id,
    required this.name,
    required this.type,
    required this.dateTime,
    required this.calories,
  });

  Meal copywith({
    String? id,
    String? name,
    MealType? type,
    DateTime? dateTime,
    int? calories,
  }) {
    return Meal(
      id: id ?? this.id,
      name: name ?? this.name,
      type: type ?? this.type,
      dateTime: dateTime ?? this.dateTime,
      calories: calories ?? this.calories,
    );
  }
}
