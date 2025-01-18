import 'package:flutter/material.dart';
import 'package:tp2_flutter_grupo12/widgets/drawner_menu.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Home Screen'),
        centerTitle: true,
        leadingWidth: 40,
        toolbarHeight: 80,
      ),
      drawer: DrawerMenu(),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center, 
            crossAxisAlignment: CrossAxisAlignment.center, 
            children: [
              const Text(
                'Laboratorio 4 Grupo 12',
                style: TextStyle(
                  fontSize: 28,
                  fontWeight: FontWeight.bold,
                  color: Colors.blueAccent, 
                ),
              ),
              const SizedBox(height: 10),
              const Text(
                'Universidad Tecnológica Nacional (UTN)',
                style: TextStyle(
                  fontSize: 20,
                  fontWeight: FontWeight.w400,
                  color: Colors.black54,
                ),
              ),
              const SizedBox(height: 30),
              _buildTeamMember(
                context,
                'Balot Luciano', 
                'Películas', 
                Colors.orangeAccent,  
                () {
                  // Ruta Lucho
                },
              ),
              const SizedBox(height: 20),
              _buildTeamMember(
                context,
                'Miqueleiz Tomas',
                'Jugadores de Fútbol', 
                Colors.greenAccent, 
                () {
                  // Ruta Mike
                },
              ),
              const SizedBox(height: 20),
              _buildTeamMember(
                context,
                'Puente Agustín', 
                'Usuarios', 
                Colors.blue, 
                () {
                  Navigator.pushNamed(context, 'usuarios_list');
                },
              ),
            ],
          ),
        ),
      ),
    );
  }

  // Método que construye la sección de cada integrante con color y estilo
  Widget _buildTeamMember(
    BuildContext context,
    String name,
    String theme,
    Color themeColor, // Color para el tema
    VoidCallback onTap,
  ) {
    return GestureDetector(
      onTap: onTap,
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          // Nombre del integrante centrado y con color decorativo
          Text(
            name,
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.bold,
              color: themeColor,
            ),
          ),
          const SizedBox(height: 5),
          // Tema con estilo decorativo
          Text(
            theme,
            style: TextStyle(
              fontSize: 18,
              color: themeColor,
              fontStyle: FontStyle.italic,
              decoration: TextDecoration.underline, // Para indicar que es tocable
            ),
          ),
        ],
      ),
    );
  }
}