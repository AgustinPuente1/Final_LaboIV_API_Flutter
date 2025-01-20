import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:tp2_flutter_grupo12/models/usuarios_model.dart';
import 'package:tp2_flutter_grupo12/screens/screens.dart';
import 'package:tp2_flutter_grupo12/helpers/preferences.dart';
import 'package:tp2_flutter_grupo12/providers/theme_provider.dart';
import 'package:tp2_flutter_grupo12/service/api_service.dart';

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
            'usuarios_list': (context) => FutureBuilder<List<Usuario>>(
                  future: ApiService().fetchUsers(),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Scaffold(
                        body: Center(child: CircularProgressIndicator()),
                      );
                    } else if (snapshot.hasError) {
                      return Scaffold(
                        body: Center(
                          child: Text('Error: ${snapshot.error}'),
                        ),
                      );
                    } else if (snapshot.hasData) {
                      return UsuariosListScreen(initialUsuarios: snapshot.data!);
                    } else {
                      return const Scaffold(
                        body: Center(child: Text('No se pudieron cargar los usuarios')),
                      );
                    }
                  },
                ),
          },
        );
      },
    );
  }
}
