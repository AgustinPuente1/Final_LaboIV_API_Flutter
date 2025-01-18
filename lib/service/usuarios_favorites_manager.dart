import 'package:shared_preferences/shared_preferences.dart';

class FavoritesManager {
  // Cargar el estado de favoritos desde SharedPreferences
  static Future<bool> loadFavorite(String userId) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    return prefs.getBool('favorite_$userId') ?? false; // Devuelve false si no se encuentra
  }

  // Guardar el estado de favoritos en SharedPreferences
  static Future<void> saveFavorite(String userId, bool isFavorite) async {
    SharedPreferences prefs = await SharedPreferences.getInstance();
    await prefs.setBool('favorite_$userId', isFavorite);
  }
}
