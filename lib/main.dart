import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_flutter_grupo12/models/usuarios_model.dart';
import 'package:tp2_flutter_grupo12/screens/screens.dart';
import 'package:tp2_flutter_grupo12/helpers/preferences.dart';
import 'package:tp2_flutter_grupo12/providers/theme_provider.dart';
import 'package:tp2_flutter_grupo12/service/api_service.dart';
import 'package:tp2_flutter_grupo12/service/usuarios_favorites_manager.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();
  await dotenv.load(fileName: ".env");

  // Limpiar favoritos al inicio
  await FavoritesManager.clearAllFavorites();

  // Cargar usuarios antes de iniciar la app
  final List<Usuario> usuarios = await ApiService().fetchUsers();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
      ],
      child: MyApp(initialUsuarios: usuarios),
    ),
  );
}

class MyApp extends StatelessWidget {
  final List<Usuario> initialUsuarios;

  const MyApp({super.key, required this.initialUsuarios});

  @override
  Widget build(BuildContext context) {
    return Consumer<ThemeProvider>(
      builder: (context, themeProvider, child) {
        return MaterialApp(
          debugShowCheckedModeBanner: false,
          initialRoute: 'home',
          theme: ThemeData.light(),
          darkTheme: ThemeData.dark(),
          themeMode: themeProvider.isDarkMode ? ThemeMode.dark : ThemeMode.light,
          routes: {
            'home': (context) => const HomeScreen(),
            'custom_list': (context) => const CustomListScreen(),
            'profile': (context) => const ProfileScreen(),
            'custom_list_item': (context) => const CustomListItem(),
            'usuarios_list': (context) => UsuariosListScreen(initialUsuarios: initialUsuarios),
          },
        );
      },
    );
  }
}