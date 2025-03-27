import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../cubit/meal_search_cubit.dart';
import '../widgets/search_meal_card.dart';

class MealSearchDelegate extends SearchDelegate {
  final MealSearchCubit searchCubit;
  String? selectedCategory;

  MealSearchDelegate(this.searchCubit);

  @override
  List<Widget> buildActions(BuildContext context) {
    return [
      IconButton(
        icon: const Icon(Icons.clear),
        onPressed: () => query = '',
      ),
    ];
  }

  @override
  Widget buildLeading(BuildContext context) {
    return IconButton(
      icon: const Icon(Icons.arrow_back),
      onPressed: () => close(context, null),
    );
  }

  @override
  Widget buildSuggestions(BuildContext context) {
    return buildResults(context);
  }

  @override
  Widget buildResults(BuildContext context) {
    searchCubit.searchMeals(query);
    return Column(
      children: [
        FutureBuilder<List<String>>(
          future: searchCubit.getCategories(),
          builder: (context, snapshot) {
            if (!snapshot.hasData) return const SizedBox();

            return SingleChildScrollView(
              scrollDirection: Axis.horizontal,
              padding: const EdgeInsets.all(8),
              child: Row(
                children: [
                  FilterChip(
                    label: const Text('All'),
                    selected: selectedCategory == null,
                    onSelected: (_) {
                      selectedCategory = null;
                      searchCubit.searchMeals(query);
                    },
                  ),
                  ...snapshot.data!.map((category) => Padding(
                        padding: const EdgeInsets.only(left: 8),
                        child: FilterChip(
                          label: Text(category),
                          selected: category == selectedCategory,
                          onSelected: (_) {
                            selectedCategory = category;
                            searchCubit.searchMeals(query);
                          },
                        ),
                      )),
                ],
              ),
            );
          },
        ),
        Expanded(
          child: BlocBuilder<MealSearchCubit, MealSearchState>(
            bloc: searchCubit,
            builder: (context, state) {
              if (state.isLoading) {
                return const Center(child: CircularProgressIndicator());
              }
              if (state.error != null) {
                return Center(child: Text(state.error!));
              }
              return GridView.builder(
                padding: const EdgeInsets.all(8),
                gridDelegate: const SliverGridDelegateWithFixedCrossAxisCount(
                  crossAxisCount: 2,
                  childAspectRatio: 0.7,
                  crossAxisSpacing: 10,
                  mainAxisSpacing: 10,
                ),
                itemCount: state.meals.length,
                itemBuilder: (context, index) {
                  final meal = state.meals[index];
                  return SearchMealCard(meal: meal);
                },
              );
            },
          ),
        ),
      ],
    );
  }
}
