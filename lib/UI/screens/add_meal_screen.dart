import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:uuid/uuid.dart';
import '../../core/utils/validators.dart';
import '../../domain/entity/meal.dart';
import '../cubit/cubit_meal.dart';
import '../cubit/cubit_meal_intent.dart';

class AddMealScreen extends StatefulWidget {
  final Meal? mealToUpdate;

  const AddMealScreen({super.key, this.mealToUpdate});

  @override
  State<AddMealScreen> createState() => _AddMealScreenState();
}

class _AddMealScreenState extends State<AddMealScreen> {
  final _formKey = GlobalKey<FormState>();
  final _nameController = TextEditingController();
  final _caloriesController = TextEditingController();
  DateTime _selectedDateTime = DateTime.now();
  MealType _selectedType = MealType.breakfast;

  @override
  void initState() {
    super.initState();
    if (widget.mealToUpdate != null) {
      _nameController.text = widget.mealToUpdate!.name;
      _caloriesController.text = widget.mealToUpdate!.calories.toString();
      _selectedDateTime = widget.mealToUpdate!.dateTime;
      _selectedType = widget.mealToUpdate!.type;
    }
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.green,
        title: Text(widget.mealToUpdate == null ? 'Add Meal' : 'Update Meal'),
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16),
        child: Form(
          key: _formKey,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              TextFormField(
                controller: _nameController,
                decoration: const InputDecoration(
                  labelText: 'Meal Name',
                  border: OutlineInputBorder(),
                ),
                validator: Validators.validateMealName,
              ),
              const SizedBox(height: 16),
              DropdownButtonFormField<MealType>(
                value: _selectedType,
                decoration: const InputDecoration(
                  labelText: 'Meal Type',
                  border: OutlineInputBorder(),
                ),
                items: MealType.values.map((type) {
                  return DropdownMenuItem(
                    value: type,
                    child: Text(type.name.toUpperCase()),
                  );
                }).toList(),
                onChanged: (value) {
                  setState(() {
                    _selectedType = value!;
                  });
                },
                validator: (value) =>
                    value == null ? 'Please select a meal type' : null,
              ),
              const SizedBox(height: 16),
              InkWell(
                onTap: () => _selectDateTime(context),
                child: InputDecorator(
                  decoration: const InputDecoration(
                    labelText: 'Date & Time',
                    border: OutlineInputBorder(),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        DateFormat('MMM dd, yyyy - hh:mm a')
                            .format(_selectedDateTime),
                      ),
                      const Icon(Icons.calendar_today),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              TextFormField(
                controller: _caloriesController,
                decoration: const InputDecoration(
                  labelText: 'Calories',
                  border: OutlineInputBorder(),
                ),
                keyboardType: TextInputType.number,
                validator: Validators.validateCalories,
              ),
              const SizedBox(height: 32),
              ElevatedButton(
                onPressed: _saveMeal,
                style: ElevatedButton.styleFrom(
                  padding: const EdgeInsets.all(16),
                ),
                child: Text(
                  widget.mealToUpdate == null ? 'Add Meal' : 'Update Meal',
                  style: const TextStyle(fontSize: 16),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Future<void> _selectDateTime(BuildContext context) async {
    final date = await showDatePicker(
      context: context,
      initialDate: _selectedDateTime,
      firstDate: DateTime(2000),
      lastDate: DateTime.now(),
    );

    if (date != null) {
      final time = await showTimePicker(
        context: context,
        initialTime: TimeOfDay.fromDateTime(_selectedDateTime),
      );

      if (time != null) {
        setState(() {
          _selectedDateTime = DateTime(
            date.year,
            date.month,
            date.day,
            time.hour,
            time.minute,
          );
        });
      }
    }
  }

  void _saveMeal() {
    if (_formKey.currentState!.validate()) {
      final meal = Meal(
        id: widget.mealToUpdate?.id ?? const Uuid().v4(),
        name: _nameController.text,
        type: _selectedType,
        dateTime: _selectedDateTime,
        calories: int.parse(_caloriesController.text),
      );

      if (widget.mealToUpdate == null) {
        context.read<CubitMeal>().onIntent(AddMealIntent(meal));
      } else {
        context.read<CubitMeal>().onIntent(UpdateMealIntent(meal));
      }

      Navigator.pop(context);
    }
  }

  @override
  void dispose() {
    _nameController.dispose();
    _caloriesController.dispose();
    super.dispose();
  }
}
