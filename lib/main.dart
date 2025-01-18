import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_flutter_grupo12/screens/screens.dart';
import 'package:tp2_flutter_grupo12/helpers/preferences.dart';
import 'package:tp2_flutter_grupo12/providers/theme_provider.dart';

void main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await Preferences.initShared();

  runApp(
    MultiProvider(
      providers: [
        ChangeNotifierProvider(create: (_) => ThemeProvider()),
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
            'usuarios_list': (context) => const UsuariosListScreen(),
          },
        );
      },
    );
  }
}