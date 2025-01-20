import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  static const String favoritesKeyPrefix = 'favorite_';

  static Future<bool> loadFavorite(String id) async {
    final prefs = await SharedPreferences.getInstance();
    return prefs.getBool('$favoritesKeyPrefix$id') ?? false;
  }

  static Future<void> saveFavorite(String id, bool isFavorite) async {
    final prefs = await SharedPreferences.getInstance();
    prefs.setBool('$favoritesKeyPrefix$id', isFavorite);
  }

  static Future<void> clearAllFavorites() async {
    final prefs = await SharedPreferences.getInstance();
    final keys = prefs.getKeys().where((key) => key.startsWith(favoritesKeyPrefix));
    for (final key in keys) {
      await prefs.remove(key);
    }
  }
}