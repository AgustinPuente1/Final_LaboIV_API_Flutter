import 'package:flutter/material.dart';
import 'package:tp2_flutter_grupo12/models/usuarios_model.dart';
import 'package:tp2_flutter_grupo12/screens/usuarios_details_screen.dart';
import 'package:tp2_flutter_grupo12/service/usuarios_favorites_manager.dart';
import 'package:tp2_flutter_grupo12/widgets/widgets.dart'; 

class UsuariosListScreen extends StatefulWidget {
  final List<Usuario> initialUsuarios;

  const UsuariosListScreen({super.key, required this.initialUsuarios});

  @override
  State<UsuariosListScreen> createState() => _UsuariosListScreenState();
}

class _UsuariosListScreenState extends State<UsuariosListScreen> {
  List<Usuario> _originalElements = [];
  List<Usuario> _auxiliarElements = [];
  String _searchQuery = '';
  bool _searchActive = false;
  bool _showOnlyFavorites = false;

  final TextEditingController _searchController = TextEditingController();
  final FocusNode _focusNode = FocusNode();

  @override
  void initState() {
    super.initState();
    _originalElements = widget.initialUsuarios;
    _auxiliarElements = List.from(_originalElements);
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
