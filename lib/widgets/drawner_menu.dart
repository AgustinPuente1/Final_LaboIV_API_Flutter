import 'package:flutter/material.dart';

class DrawerMenu extends StatelessWidget {
  final List<Map<String, String>> _menuItems = <Map<String, String>>[
    {'route': 'home', 'title': 'Home', 'subtitle': 'Ir a Screen Principal'},
    {'route': 'profile', 'title': 'Perfil usuario', 'subtitle': 'Ir a Perfil de Usuario'},
    {'route': 'usuarios_list', 'title': 'Usuarios list', 'subtitle': 'Ir a la lista de Usuarios'},
  ];

  DrawerMenu({super.key});

  @override
  Widget build(BuildContext context) {
    return Drawer(
      child: ListView(
        padding: EdgeInsets.zero,
        children: [
          const _DrawerHeader(),
          ...ListTile.divideTiles(
            context: context,
            tiles: _menuItems
                .map((item) => ListTile(
                      contentPadding: const EdgeInsets.symmetric(vertical: 10, horizontal: 20),
                      dense: true,
                      iconColor: Theme.of(context).brightness == Brightness.dark
                          ? Colors.white
                          : Colors.black, 
                      title: Text(
                        item['title']!,
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.bold,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white
                              : const Color.fromARGB(255, 94, 78, 99),
                        ),
                      ),
                      subtitle: Text(
                        item['subtitle']!.isEmpty
                            ? 'Tap to go to ${item['title']}'
                            : item['subtitle']!,
                        style: TextStyle(
                          fontSize: 12,
                          color: Theme.of(context).brightness == Brightness.dark
                              ? Colors.white70
                              : Colors.black54,
                        ),
                      ),
                      leading: Icon(
                        Icons.arrow_forward, 
                        color: Theme.of(context).brightness == Brightness.dark 
                            ? Colors.white 
                            : Colors.black, 
                      ),
                      onTap: () {
                        Navigator.pop(context);
                        Navigator.pushNamed(context, item['route']!);
                      },
                    ))
                .toList(),
          ),
        ],
      ),
    );
  }
}

class _DrawerHeader extends StatelessWidget {
  const _DrawerHeader({super.key});

  @override
  Widget build(BuildContext context) {
    return DrawerHeader(
      padding: EdgeInsets.zero,
      decoration: const BoxDecoration(
        color: Colors.blueGrey, 
      ),
      child: Container(
        alignment: Alignment.centerLeft,
        padding: const EdgeInsets.all(20),
        child: Row(
          children: [
            // Alineación del avatar e icono
            CircleAvatar(
              radius: 30,
              backgroundColor: Theme.of(context).brightness == Brightness.dark
                  ? Colors.white 
                  : Colors.white, 
              child: Icon(
                Icons.account_circle,
                size: 40,
                color: Theme.of(context).brightness == Brightness.dark
                    ? Colors.blueGrey
                    : Colors.blueGrey, 
              ),
            ),
            const SizedBox(width: 15),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              mainAxisAlignment: MainAxisAlignment.center, 
              children: [
                Text(
                  'Laboratorio 4',
                  style: TextStyle(
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white
                        : const Color.fromARGB(255, 45, 43, 43),
                  ),
                ),
                Text(
                  'Puente Agustín',
                  style: TextStyle(
                    fontSize: 16,
                    color: Theme.of(context).brightness == Brightness.dark
                        ? Colors.white70
                        : Colors.black54,
                  ),
                ),
              ],
            ),
          ],
        ),
      ),
    );
  }
}