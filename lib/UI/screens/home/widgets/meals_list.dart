import 'package:flutter/material.dart';
import 'package:meal_tracker/UI/screens/home/widgets/meal_card.dart';
import 'package:meal_tracker/domain/entity/meal.dart';

class MealsList extends StatelessWidget {
  final List<Meal> meals;
  final Function(Meal) onUpdate;
  final Function(String) onDelete;

  const MealsList({
    super.key,
    required this.meals,
    required this.onUpdate,
    required this.onDelete,
  });

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      padding: const EdgeInsets.only(top: 8),
      itemCount: meals.length,
      itemBuilder: (context, index) => MealCard(
        meal: meals[index],
        onUpdate: onUpdate,
        onDelete: onDelete,
      ),
    );
  }
}
