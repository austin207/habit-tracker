import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'screens/auth/login_screen.dart';
import 'services/storage_service.dart';
import 'services/notification_service.dart';
import 'utils/colors.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await StorageService.init();
  await NotificationService.init();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
        ChangeNotifierProvider(create: (_) => HabitProvider()),
      ],
      child: const MyApp(),
    ),
  );
}

class MyApp extends StatelessWidget {
  const MyApp({super.key});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          title: 'Routiner - Habit Tracker',
          debugShowCheckedModeBanner: false,
          theme: ThemeData(
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: AppColors.background,
            brightness: Brightness.light,
            fontFamily: 'Inter',
            appBarTheme: const AppBarTheme(
              backgroundColor: AppColors.background,
              elevation: 0,
              iconTheme: IconThemeData(color: AppColors.textPrimary),
              titleTextStyle: TextStyle(
                color: AppColors.textPrimary,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          darkTheme: ThemeData(
            primaryColor: AppColors.primary,
            scaffoldBackgroundColor: const Color(0xFF1C1C1E),
            brightness: Brightness.dark,
            fontFamily: 'Inter',
            appBarTheme: const AppBarTheme(
              backgroundColor: Color(0xFF1C1C1E),
              elevation: 0,
              iconTheme: IconThemeData(color: Colors.white),
              titleTextStyle: TextStyle(
                color: Colors.white,
                fontSize: 20,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          themeMode: themeProvider.themeMode,
          home: const LoginScreen(),
        );
      },
    );
  }
}

class ThemeProvider extends ChangeNotifier {
  ThemeMode _themeMode = ThemeMode.light;

  ThemeMode get themeMode => _themeMode;

  bool get isDarkMode => _themeMode == ThemeMode.dark;

  void toggleTheme() {
    _themeMode = _themeMode == ThemeMode.light ? ThemeMode.dark : ThemeMode.light;
    notifyListeners();
  }
}

class HabitProvider extends ChangeNotifier {
  List<dynamic> _habits = [];
  List<String> _favorites = [];

  List<dynamic> get habits => _habits;
  List<String> get favorites => _favorites;

  void loadHabits() {
    _habits = StorageService.getHabits();
    _favorites = StorageService.getFavorites();
    notifyListeners();
  }

  Future<void> addHabit(Map<String, dynamic> habit) async {
    _habits.add(habit);
    await StorageService.saveHabits(_habits);
    notifyListeners();
  }

  Future<void> updateHabit(int index, Map<String, dynamic> habit) async {
    _habits[index] = habit;
    await StorageService.saveHabits(_habits);
    notifyListeners();
  }

  Future<void> deleteHabit(int index) async {
    _habits.removeAt(index);
    await StorageService.saveHabits(_habits);
    notifyListeners();
  }

  Future<void> toggleFavorite(String habitId) async {
    if (_favorites.contains(habitId)) {
      _favorites.remove(habitId);
    } else {
      _favorites.add(habitId);
    }
    await StorageService.saveFavorites(_favorites);
    notifyListeners();
  }

  bool isFavorite(String habitId) {
    return _favorites.contains(habitId);
  }
}
