import 'dart:convert';
import 'package:shared_preferences/shared_preferences.dart';

class StorageService {
  static late SharedPreferences _prefs;
  static const String _habitsKey = 'habits';
  static const String _favoritesKey = 'favorites';
  static const String _userKey = 'current_user';
  static const String _themeKey = 'theme_mode';
  static const String _notificationsKey = 'notifications_enabled';

  // Initialize SharedPreferences
  static Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
  }

  // ==================== HABITS ====================

  // Save habits list
  static Future<void> saveHabits(List<dynamic> habits) async {
    try {
      final habitsJson = jsonEncode(habits);
      await _prefs.setString(_habitsKey, habitsJson);
      print('✅ Habits saved successfully: ${habits.length} habits');
    } catch (e) {
      print('❌ Error saving habits: $e');
    }
  }

  // Get habits list
  static List<dynamic> getHabits() {
    try {
      final habitsJson = _prefs.getString(_habitsKey);
      if (habitsJson != null && habitsJson.isNotEmpty) {
        final decoded = jsonDecode(habitsJson);
        print('✅ Habits loaded: ${(decoded as List).length} habits');
        return decoded as List<dynamic>;
      }
      print('ℹ️ No habits found, returning empty list');
      return [];
    } catch (e) {
      print('❌ Error loading habits: $e');
      return [];
    }
  }

  // Add single habit
  static Future<void> addHabit(Map<String, dynamic> habit) async {
    try {
      final habits = getHabits();
      habits.add(habit);
      await saveHabits(habits);
      print('✅ Habit added: ${habit['name']}');
    } catch (e) {
      print('❌ Error adding habit: $e');
    }
  }

  // Update habit by ID
  static Future<void> updateHabit(String habitId, Map<String, dynamic> updatedHabit) async {
    try {
      final habits = getHabits();
      final index = habits.indexWhere((h) => h['id'] == habitId);
      if (index != -1) {
        habits[index] = updatedHabit;
        await saveHabits(habits);
        print('✅ Habit updated: ${updatedHabit['name']}');
      } else {
        print('⚠️ Habit not found with ID: $habitId');
      }
    } catch (e) {
      print('❌ Error updating habit: $e');
    }
  }

  // Delete habit by ID
  static Future<void> deleteHabit(String habitId) async {
    try {
      final habits = getHabits();
      habits.removeWhere((h) => h['id'] == habitId);
      await saveHabits(habits);
      print('✅ Habit deleted with ID: $habitId');
    } catch (e) {
      print('❌ Error deleting habit: $e');
    }
  }

  // Clear all habits
  static Future<void> clearHabits() async {
    try {
      await _prefs.remove(_habitsKey);
      print('✅ All habits cleared');
    } catch (e) {
      print('❌ Error clearing habits: $e');
    }
  }

  // ==================== FAVORITES ====================

  // Save favorites list
  static Future<void> saveFavorites(List<String> favoriteIds) async {
    try {
      await _prefs.setStringList(_favoritesKey, favoriteIds);
      print('✅ Favorites saved: ${favoriteIds.length} items');
    } catch (e) {
      print('❌ Error saving favorites: $e');
    }
  }

  // Get favorites list
  static List<String> getFavorites() {
    try {
      final favorites = _prefs.getStringList(_favoritesKey) ?? [];
      print('✅ Favorites loaded: ${favorites.length} items');
      return favorites;
    } catch (e) {
      print('❌ Error loading favorites: $e');
      return [];
    }
  }

  // Toggle favorite (add/remove)
  static Future<void> toggleFavorite(String habitId) async {
    try {
      final favorites = getFavorites();
      if (favorites.contains(habitId)) {
        favorites.remove(habitId);
        print('✅ Removed from favorites: $habitId');
      } else {
        favorites.add(habitId);
        print('✅ Added to favorites: $habitId');
      }
      await saveFavorites(favorites);
    } catch (e) {
      print('❌ Error toggling favorite: $e');
    }
  }

  // Check if habit is favorite
  static bool isFavorite(String habitId) {
    return getFavorites().contains(habitId);
  }

  // ==================== USER SETTINGS ====================

  // Save theme mode
  static Future<void> saveThemeMode(String mode) async {
    try {
      await _prefs.setString(_themeKey, mode);
      print('✅ Theme mode saved: $mode');
    } catch (e) {
      print('❌ Error saving theme: $e');
    }
  }

  // Get theme mode
  static String getThemeMode() {
    return _prefs.getString(_themeKey) ?? 'light';
  }

  // Save notifications enabled state
  static Future<void> saveNotificationsEnabled(bool enabled) async {
    try {
      await _prefs.setBool(_notificationsKey, enabled);
      print('✅ Notifications setting saved: $enabled');
    } catch (e) {
      print('❌ Error saving notifications setting: $e');
    }
  }

  // Get notifications enabled state
  static bool getNotificationsEnabled() {
    return _prefs.getBool(_notificationsKey) ?? true;
  }

  // ==================== UTILITY ====================

  // Get all stored keys (for debugging)
  static Set<String> getAllKeys() {
    return _prefs.getKeys();
  }

  // Print all stored data (for debugging/screenshots)
  static void printAllData() {
    print('\n📦 === STORAGE SERVICE DEBUG ===');
    print('🔑 All Keys: ${getAllKeys()}');
    print('📋 Habits: ${getHabits().length} items');
    print('⭐ Favorites: ${getFavorites().length} items');
    print('🎨 Theme: ${getThemeMode()}');
    print('🔔 Notifications: ${getNotificationsEnabled()}');

    // Print actual habit data
    final habits = getHabits();
    if (habits.isNotEmpty) {
      print('\n📝 Habit Details:');
      for (var i = 0; i < habits.length; i++) {
        final habit = habits[i];
        print('  ${i + 1}. ${habit['name']} - ${habit['description']}');
      }
    }

    // Print favorites
    final favorites = getFavorites();
    if (favorites.isNotEmpty) {
      print('\n⭐ Favorite IDs: $favorites');
    }

    print('=================================\n');
  }

  // Clear all data (for testing/reset)
  static Future<void> clearAllData() async {
    try {
      await _prefs.clear();
      print('✅ All storage data cleared');
    } catch (e) {
      print('❌ Error clearing all data: $e');
    }
  }

  // Export data as JSON string (for backup)
  static String exportData() {
    try {
      final data = {
        'habits': getHabits(),
        'favorites': getFavorites(),
        'theme': getThemeMode(),
        'notifications': getNotificationsEnabled(),
        'exportDate': DateTime.now().toIso8601String(),
      };
      return jsonEncode(data);
    } catch (e) {
      print('❌ Error exporting data: $e');
      return '{}';
    }
  }

  // Import data from JSON string (for restore)
  static Future<bool> importData(String jsonData) async {
    try {
      final data = jsonDecode(jsonData);

      if (data['habits'] != null) {
        await saveHabits(List<dynamic>.from(data['habits']));
      }

      if (data['favorites'] != null) {
        await saveFavorites(List<String>.from(data['favorites']));
      }

      if (data['theme'] != null) {
        await saveThemeMode(data['theme']);
      }

      if (data['notifications'] != null) {
        await saveNotificationsEnabled(data['notifications']);
      }

      print('✅ Data imported successfully');
      return true;
    } catch (e) {
      print('❌ Error importing data: $e');
      return false;
    }
  }
}
