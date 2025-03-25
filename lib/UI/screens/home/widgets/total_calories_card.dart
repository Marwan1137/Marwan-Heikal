// ignore_for_file: deprecated_member_use

import 'package:flutter/material.dart';

class TotalCaloriesCard extends StatelessWidget {
  final int totalCalories;

  const TotalCaloriesCard({super.key, required this.totalCalories});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.all(16),
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        color: Colors.white,
        border:
            Border.all(color: Colors.green.shade300, width: 2), // Add border
        borderRadius: BorderRadius.circular(16),
        // boxShadow: [
        //   BoxShadow(
        //     color: Colors.green.shade300,
        //     blurRadius: 10,
        //     offset: const Offset(0, 4),
        //   ),
        // ],
      ),
      child: Row(
        children: [
          const Icon(
            Icons.local_fire_department,
            color: Colors.orange,
            size: 32,
          ),
          const SizedBox(width: 16),
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Total Calories',
                style: TextStyle(fontSize: 22, color: Colors.black),
              ),
              Text(
                '$totalCalories cal',
                style: const TextStyle(
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                  color: Colors.black,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }
}
