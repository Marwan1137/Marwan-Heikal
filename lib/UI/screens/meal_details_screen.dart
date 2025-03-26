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
                  const SizedBox(height: 8),
                  if (meal.strCategory != null) 
                    Text(
                      'Category: ${meal.strCategory}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  if (meal.strArea != null) ...[
                    const SizedBox(height: 8),
                    Text(
                      'Area: ${meal.strArea}',
                      style: Theme.of(context).textTheme.titleMedium,
                    ),
                  ],
                  const SizedBox(height: 16),
                  Text(
                    'Instructions',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  Text(
                    meal.strInstructions ?? 'No instructions available',
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  const SizedBox(height: 16),
                  Text(
                    'Ingredients',
                    style: Theme.of(context).textTheme.titleLarge,
                  ),
                  const SizedBox(height: 8),
                  _buildIngredientsList(meal),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}

  Widget _buildIngredientsList(MealApiModel meal) {
    List<Widget> ingredients = [];
    
    // Add non-null ingredients with their measurements
    for (int i = 1; i <= 20; i++) {
      final ingredient = meal.getIngredient(i);
      final measure = meal.getMeasure(i);
      
      if (ingredient != null && ingredient.isNotEmpty) {
        ingredients.add(
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 4),
            child: Text(
              '• ${measure ?? ''} ${ingredient}',
              style: const TextStyle(fontSize: 16),
            ),
          ),
        );
      }
    }
    
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: ingredients,
    );
  }