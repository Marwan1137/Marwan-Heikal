class Validators {
  static String? validateMealName(String? value) {
    if (value == null || value.isEmpty) {
      return 'Meal name is required';
    }
    if (value.length < 2) {
      return 'Meal name must be at least 2 characters';
    }
    return null;
  }

  static String? validateCalories(String? value) {
    if (value == null || value.isEmpty) {
      return 'Calories are required';
    }
    final calories = int.tryParse(value);
    if (calories == null) {
      return 'Please enter a valid number';
    }
    if (calories <= 0) {
      return 'Calories must be greater than 0';
    }
    if (calories > 5000) {
      return 'Calories seem too high';
    }
    return null;
  }

  static String? validateMealType(String? value) {
    if (value == null || value.isEmpty) {
      return 'Please select a meal type';
    }
    return null;
  }
}