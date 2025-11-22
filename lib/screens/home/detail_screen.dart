import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../../main.dart';
import '../../utils/colors.dart';
import 'package:intl/intl.dart';

class DetailScreen extends StatefulWidget {
  final Map<String, dynamic> habit;
  final int habitIndex;

  const DetailScreen({
    super.key,
    required this.habit,
    required this.habitIndex,
  });

  @override
  State<DetailScreen> createState() => _DetailScreenState();
}

class _DetailScreenState extends State<DetailScreen> {
  late bool isCompleted;
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isCompleted = widget.habit['isCompleted'] ?? false;
    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    isFavorite = habitProvider.isFavorite(widget.habit['id']);
  }

  void _toggleCompletion() {
    setState(() {
      isCompleted = !isCompleted;
    });

    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    final updatedHabit = Map<String, dynamic>.from(widget.habit);
    updatedHabit['isCompleted'] = isCompleted;

    if (isCompleted) {
      final today = DateFormat('yyyy-MM-dd').format(DateTime.now());
      final completedDates = List<String>.from(updatedHabit['completedDates'] ?? []);
      if (!completedDates.contains(today)) {
        completedDates.add(today);
        updatedHabit['completedDates'] = completedDates;
      }
    }

    habitProvider.updateHabit(widget.habitIndex, updatedHabit);
  }

  void _toggleFavorite() {
    setState(() {
      isFavorite = !isFavorite;
    });

    final habitProvider = Provider.of<HabitProvider>(context, listen: false);
    habitProvider.toggleFavorite(widget.habit['id']);

    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(
        content: Text(
          isFavorite ? 'Added to favorites' : 'Removed from favorites',
        ),
        duration: const Duration(seconds: 2),
      ),
    );
  }

  void _deleteHabit() {
    showDialog(
      context: context,
      builder: (context) => AlertDialog(
        title: const Text('Delete Habit'),
        content: const Text('Are you sure you want to delete this habit?'),
        actions: [
          TextButton(
            onPressed: () => Navigator.pop(context),
            child: const Text('Cancel'),
          ),
          ElevatedButton(
            onPressed: () {
              final habitProvider = Provider.of<HabitProvider>(context, listen: false);
              habitProvider.deleteHabit(widget.habitIndex);
              Navigator.pop(context); // Close dialog
              Navigator.pop(context); // Go back to home
            },
            style: ElevatedButton.styleFrom(
              backgroundColor: AppColors.error,
            ),
            child: const Text('Delete'),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    final habitColor = Color(widget.habit['colorValue'] ?? 0xFF6C63FF);
    final completedDates = List<String>.from(widget.habit['completedDates'] ?? []);

    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        backgroundColor: AppColors.background,
        elevation: 0,
        leading: IconButton(
          icon: const Icon(Icons.arrow_back),
          onPressed: () => Navigator.pop(context),
        ),
        actions: [
          IconButton(
            icon: Icon(
              isFavorite ? Icons.favorite : Icons.favorite_outline,
              color: isFavorite ? AppColors.error : null,
            ),
            onPressed: _toggleFavorite,
          ),
          IconButton(
            icon: const Icon(Icons.delete_outline),
            onPressed: _deleteHabit,
          ),
        ],
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(24),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            // Habit Icon
            Center(
              child: Container(
                width: 100,
                height: 100,
                decoration: BoxDecoration(
                  color: habitColor.withOpacity(0.2),
                  shape: BoxShape.circle,
                ),
                child: Icon(
                  Icons.check_circle,
                  size: 50,
                  color: habitColor,
                ),
              ),
            ),

            const SizedBox(height: 24),

            // Habit Name
            Center(
              child: Text(
                widget.habit['name'] ?? 'Habit',
                style: const TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: AppColors.textPrimary,
                ),
                textAlign: TextAlign.center,
              ),
            ),

            const SizedBox(height: 12),

            // Frequency Badge
            Center(
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                decoration: BoxDecoration(
                  color: habitColor.withOpacity(0.2),
                  borderRadius: BorderRadius.circular(20),
                ),
                child: Text(
                  widget.habit['frequency'] ?? 'Daily',
                  style: TextStyle(
                    color: habitColor,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
            ),

            const SizedBox(height: 32),

            // Description Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Description',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 12),
                  Text(
                    widget.habit['description'] ?? 'No description',
                    style: const TextStyle(
                      fontSize: 16,
                      color: AppColors.textSecondary,
                      height: 1.5,
                    ),
                  ),
                ],
              ),
            ),

            const SizedBox(height: 24),

            // Stats Card
            Container(
              width: double.infinity,
              padding: const EdgeInsets.all(20),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                boxShadow: [
                  BoxShadow(
                    color: Colors.black.withOpacity(0.05),
                    blurRadius: 10,
                    offset: const Offset(0, 4),
                  ),
                ],
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  const Text(
                    'Statistics',
                    style: TextStyle(
                      fontSize: 18,
                      fontWeight: FontWeight.bold,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 16),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      _buildStatItem(
                        'Streak',
                        '${completedDates.length}',
                        Icons.local_fire_department,
                        AppColors.habitOrange,
                      ),
                      _buildStatItem(
                        'Completed',
                        '${completedDates.length}',
                        Icons.check_circle,
                        AppColors.success,
                      ),
                      _buildStatItem(
                        'Total',
                        '${completedDates.length}',
                        Icons.calendar_today,
                        AppColors.primary,
                      ),
                    ],
                  ),
                ],
              ),
            ),

            const SizedBox(height: 32),

            // Mark Complete Button
            SizedBox(
              width: double.infinity,
              child: ElevatedButton(
                onPressed: _toggleCompletion,
                style: ElevatedButton.styleFrom(
                  backgroundColor: isCompleted ? AppColors.success : habitColor,
                  foregroundColor: Colors.white,
                  padding: const EdgeInsets.symmetric(vertical: 16),
                  shape: RoundedRectangleBorder(
                    borderRadius: BorderRadius.circular(12),
                  ),
                  elevation: 0,
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(
                      isCompleted ? Icons.check_circle : Icons.check_circle_outline,
                      size: 24,
                    ),
                    const SizedBox(width: 8),
                    Text(
                      isCompleted ? 'Completed Today' : 'Mark as Complete',
                      style: const TextStyle(
                        fontSize: 16,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

  Widget _buildStatItem(String label, String value, IconData icon, Color color) {
    return Column(
      children: [
        Container(
          padding: const EdgeInsets.all(12),
          decoration: BoxDecoration(
            color: color.withOpacity(0.1),
            shape: BoxShape.circle,
          ),
          child: Icon(icon, color: color, size: 24),
        ),
        const SizedBox(height: 8),
        Text(
          value,
          style: TextStyle(
            fontSize: 20,
            fontWeight: FontWeight.bold,
            color: color,
          ),
        ),
        const SizedBox(height: 4),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: AppColors.textSecondary,
          ),
        ),
      ],
    );
  }
}
