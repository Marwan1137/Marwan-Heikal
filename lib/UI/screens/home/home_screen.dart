import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_intent.dart';
import 'package:meal_tracker/UI/cubit/cubit_meal_state.dart';
import 'package:meal_tracker/UI/screens/add_meal_screen.dart';
import 'package:meal_tracker/UI/screens/home/widgets/empty_meals_view.dart';
import 'package:meal_tracker/UI/screens/home/widgets/meals_list.dart';
import 'package:meal_tracker/UI/screens/home/widgets/sort_button.dart';
import 'package:meal_tracker/UI/screens/home/widgets/total_calories_card.dart';
import 'package:meal_tracker/domain/entity/meal.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<CubitMeal, MealState>(
      builder: (context, state) {
        return Scaffold(
          backgroundColor: Colors.grey[100],
          appBar: _buildAppBar(),
          body: _buildBody(context, state),
          floatingActionButton: _buildFloatingActionButton(context),
        );
      },
    );
  }

  PreferredSizeWidget _buildAppBar() {
    return AppBar(
      backgroundColor: Colors.green,
      title: const Text(
        'Meal Tracker',
        style: TextStyle(color: Colors.white),
      ),
      actions: const [SortButton()],
    );
  }

  Widget _buildBody(BuildContext context, MealState state) {
    return switch (state.status) {
      UIStatus.loading => const Center(child: CircularProgressIndicator()),
      _ when state.meals.isEmpty => const EmptyMealsView(),
      _ => Column(
          children: [
            TotalCaloriesCard(totalCalories: state.totalCalories),
            Expanded(
              child: MealsList(
                meals: state.meals,
                onUpdate: (meal) => _navigateToUpdateMeal(context, meal),
                onDelete: (id) => _deleteMeal(context, id),
              ),
            ),
          ],
        ),
    };
  }

  Widget _buildFloatingActionButton(BuildContext context) {
    return FloatingActionButton(
      onPressed: () => _navigateToAddMeal(context),
      child: const Icon(Icons.add),
    );
  }

  void _navigateToAddMeal(BuildContext context) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<CubitMeal>(),
          child: const AddMealScreen(),
        ),
      ),
    );
  }

  void _navigateToUpdateMeal(BuildContext context, Meal meal) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => BlocProvider.value(
          value: context.read<CubitMeal>(),
          child: AddMealScreen(mealToUpdate: meal),
        ),
      ),
    );
  }

  void _deleteMeal(BuildContext context, String id) {
    context.read<CubitMeal>().onIntent(DeleteMealIntent(id));
  }
}
