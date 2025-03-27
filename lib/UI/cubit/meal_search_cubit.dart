import 'package:injectable/injectable.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../data/model/meal_api_model.dart';
import '../../domain/repo/meal_repository.dart';

class MealSearchState {
  final List<MealApiModel> meals;
  final bool isLoading;
  final String? error;

  MealSearchState({
    this.meals = const [],
    this.isLoading = false,
    this.error,
  });
}

@injectable
class MealSearchCubit extends Cubit<MealSearchState> {
  final MealRepository _repository;

  MealSearchCubit(this._repository) : super(MealSearchState());

  Future<List<String>> getCategories() => _repository.getCategories();

  Future<void> searchMeals(String query) async {
    if (query.isEmpty) {
      emit(MealSearchState());
      return;
    }

    emit(MealSearchState(isLoading: true));
    try {
      final meals = await _repository.searchMeals(query);
      emit(MealSearchState(meals: meals));
    } catch (e) {
      emit(MealSearchState(error: e.toString()));
    }
  }
}
