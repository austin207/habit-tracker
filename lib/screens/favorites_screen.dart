import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../main.dart';
import '../utils/colors.dart';
import '../widgets/habit_card.dart';
import 'home/detail_screen.dart';

class FavoritesScreen extends StatelessWidget {
  const FavoritesScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        title: const Text(
          'Favorites',
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: AppColors.textPrimary,
          ),
        ),
      ),
      body: Consumer<HabitProvider>(
        builder: (context, habitProvider, child) {
          final favorites = habitProvider.favorites;
          final habits = habitProvider.habits;

          // Filter habits that are in favorites
          final favoriteHabits = habits.asMap().entries.where((entry) {
            return favorites.contains(entry.value['id']);
          }).toList();

          if (favoriteHabits.isEmpty) {
            return Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  Icon(
                    Icons.favorite_outline,
                    size: 64,
                    color: AppColors.textLight,
                  ),
                  const SizedBox(height: 16),
                  const Text(
                    'No favorite habits yet',
                    style: TextStyle(
                      fontSize: 18,
                      color: AppColors.textSecondary,
                    ),
                  ),
                  const SizedBox(height: 8),
                  const Text(
                    'Tap the heart icon on habits to add them here',
                    style: TextStyle(
                      fontSize: 14,
                      color: AppColors.textLight,
                    ),
                    textAlign: TextAlign.center,
                  ),
                ],
              ),
            );
          }

          return ListView.builder(
            padding: const EdgeInsets.all(16),
            itemCount: favoriteHabits.length,
            itemBuilder: (context, index) {
              final entry = favoriteHabits[index];
              final habitIndex = entry.key;
              final habit = entry.value;

              return HabitCard(
                habit: habit,
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (_) => DetailScreen(
                        habit: habit,
                        habitIndex: habitIndex,
                      ),
                    ),
                  );
                },
              );
            },
          );
        },
      ),
    );
  }
}
