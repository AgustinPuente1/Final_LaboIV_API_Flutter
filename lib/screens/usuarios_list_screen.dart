import 'package:flutter/material.dart';
import 'package:tp2_flutter_grupo12/models/usuarios_model.dart';
import 'package:tp2_flutter_grupo12/screens/usuarios_details_screen.dart';
import 'package:tp2_flutter_grupo12/service/usuarios_favorites_manager.dart';
import 'package:tp2_flutter_grupo12/widgets/widgets.dart';
import 'package:tp2_flutter_grupo12/mocks/usuarios_mock.dart' show elements; // Importar el nuevo archivo

class UsuariosListScreen extends StatefulWidget {
  const UsuariosListScreen({super.key});

  @override
  State<UsuariosListScreen> createState() => _UsuariosListScreenState();
}

class _UsuariosListScreenState extends State<UsuariosListScreen> {
  List<Usuario> _originalElements = []; // Lista fija con todos los usuarios
  List<Usuario> _auxiliarElements = []; // Lista filtrada para la UI
  String _searchQuery = '';
  bool _searchActive = false;
  bool _showOnlyFavorites = false; // Estado para saber si mostrar solo favoritos

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _initializeUsuarios();
    _loadFavorites(); // Cargar favoritos desde SharedPreferences
  }

  void _initializeUsuarios() {
    _originalElements = elements.map((element) {
      return Usuario(
        id: element[0],
        avatar: element[1],
        firstName: element[2],
        lastName: element[3],
        email: element[4],
        gender: element[5],
        country: element[6],
        isFavorite: element[7], 
      );
    }).toList();
    _auxiliarElements = List.from(_originalElements); // Copia para la UI
  }

  // Cargar los favoritos desde SharedPreferences
  void _loadFavorites() async {
    for (var usuario in _originalElements) {
      usuario.isFavorite = await FavoritesManager.loadFavorite(usuario.id.toString());
    }
    setState(() {
      _auxiliarElements = List.from(_originalElements); // Actualizar UI
    });
  }

  // Actualizar la búsqueda de usuarios
  void _updateSearch(String? query) {
    setState(() {
      _searchQuery = query ?? '';
      if (_searchQuery.isEmpty) {
        _auxiliarElements = _showOnlyFavorites
            ? _originalElements.where((usuario) => usuario.isFavorite).toList()
            : List.from(_originalElements); // Restablecer lista filtrada
      } else {
        _auxiliarElements = _originalElements.where((usuario) {
          final fullName = '${usuario.firstName} ${usuario.lastName}'.toLowerCase();
          return fullName.contains(_searchQuery.toLowerCase());
        }).toList();
      }
    });
  }

  // Alternar entre mostrar todos los usuarios o solo los favoritos
  void _toggleFavorites() {
    setState(() {
      _showOnlyFavorites = !_showOnlyFavorites;
      if (_showOnlyFavorites) {
        _auxiliarElements = _originalElements.where((usuario) => usuario.isFavorite).toList();
      } else {
        _auxiliarElements = List.from(_originalElements); // Mostrar todos
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      top: true,
      child: Scaffold(
        body: Column(
          children: [
            UsuariosSearchBar(
              isActive: _searchActive,
              searchController: _searchController,
              focusNode: _focusNode,
              onClose: () {
                _searchController.clear();
                FocusManager.instance.primaryFocus?.unfocus();
                _updateSearch(''); // Restablecer búsqueda
              },
              onBack: () {
                setState(() {
                  _searchActive = !_searchActive;
                });
              },
              onSearch: (value) => _updateSearch(value),
            ),
            listItemsArea(),
          ],
        ),
        floatingActionButton: FloatingActionButton(
          onPressed: _toggleFavorites, // Alternar favoritos
          child: Icon(
            _showOnlyFavorites ? Icons.star : Icons.star_border, // Cambia el ícono
          ),
        ),
      ),
    );
  }

  // Lista de usuarios
  Expanded listItemsArea() {
    return Expanded(
      child: ListView.builder(
        physics: const BouncingScrollPhysics(),
        itemCount: _auxiliarElements.length,
        itemBuilder: (BuildContext context, int index) {
          final usuario = _auxiliarElements[index];

          return UsuariosCard(
            avatar: usuario.avatar,
            firstName: usuario.firstName,
            lastName: usuario.lastName,
            gender: usuario.gender,
            country: usuario.country,
            isFavorite: usuario.isFavorite,
            onFavoriteTap: () async {
              setState(() {
                usuario.isFavorite = !usuario.isFavorite;
              });
              await FavoritesManager.saveFavorite(usuario.id.toString(), usuario.isFavorite);
            },
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => UsuarioDetailScreen(
                    usuario: usuario,
                    onFavoriteChanged: (bool newFavorite) {
                      setState(() {
                        usuario.isFavorite = newFavorite; // Actualizar favorito
                      });
                    },
                  ),
                ),
              );
            },
          );
        },
      ),
    );
  }
}
