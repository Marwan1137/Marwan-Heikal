import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import '../../cubit/theme_cubit.dart';

class SettingsScreen extends StatelessWidget {
  const SettingsScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Settings'),
        centerTitle: true,
        backgroundColor: Colors.green,
      ),
      body: ListView(
        children: [
          BlocBuilder<ThemeCubit, bool>(
            builder: (context, isDarkMode) {
              return SwitchListTile(
                title: const Text('Dark Mode'),
                subtitle: const Text('Toggle between light and dark theme'),
                value: isDarkMode,
                onChanged: (_) {
                  context.read<ThemeCubit>().toggleTheme();
                },
                secondary: Icon(
                  isDarkMode ? Icons.dark_mode : Icons.light_mode,
                ),
              );
            },
          ),
          const Divider(),
          // Add more settings here if needed
        ],
      ),
    );
  }
}
