import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_tracker/domain/repo/meal_repo.dart';
import '../../../cubit/cubit_meal.dart';
import '../../../cubit/cubit_meal_intent.dart';

class SortButton extends StatelessWidget {
  const SortButton({super.key});

  @override
  Widget build(BuildContext context) {
    return PopupMenuButton<SortBy>(
      icon: const Icon(Icons.sort),
      onSelected: (SortBy sortBy) {
        context.read<CubitMeal>().onIntent(SortMealsIntent(sortBy));
      },
      itemBuilder: (BuildContext context) => [
        const PopupMenuItem(
          value: SortBy.date,
          child: Text('Sort by Date'),
        ),
        const PopupMenuItem(
          value: SortBy.calories,
          child: Text('Sort by Calories'),
        ),
        const PopupMenuItem(
          value: SortBy.name,
          child: Text('Sort by Name'),
        ),
      ],
    );
  }
}