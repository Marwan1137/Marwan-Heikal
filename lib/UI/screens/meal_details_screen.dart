import 'package:flutter/material.dart';
import '../../data/model/meal_api_model.dart';

class MealDetailsScreen extends StatelessWidget {
  final MealApiModel meal;

  const MealDetailsScreen({super.key, required this.meal});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(meal.strMeal),
      ),
      body: SingleChildScrollView(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Image.network(
              meal.strMealThumb,
              width: double.infinity,
              height: 250,
              fit: BoxFit.cover,
            ),
            Padding(
              padding: const EdgeInsets.all(16.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    meal.strMeal,
                    style: Theme.of(context).textTheme.headlineSmall,
                  ),
                  if (meal.strCategory != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Category: ${meal.strCategory}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}