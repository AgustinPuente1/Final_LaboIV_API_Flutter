import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:tp2_flutter_grupo12/models/usuarios_model.dart';
import 'package:tp2_flutter_grupo12/service/usuarios_favorites_manager.dart';

class UsuarioDetailScreen extends StatefulWidget {
  final Usuario usuario;
  final Function(bool) onFavoriteChanged;

  const UsuarioDetailScreen({
    Key? key,
    required this.usuario,
    required this.onFavoriteChanged,
  }) : super(key: key);

  @override
  State<UsuarioDetailScreen> createState() => _UsuarioDetailScreenState();
}

class _UsuarioDetailScreenState extends State<UsuarioDetailScreen> {
  late bool isFavorite;

  @override
  void initState() {
    super.initState();
    isFavorite = widget.usuario.isFavorite;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text('${widget.usuario.firstName} ${widget.usuario.lastName}'),
            Text(
              'ID: ${widget.usuario.id}',
              style: const TextStyle(color: Colors.grey, fontSize: 14),
            ),
          ],
        ),
      ),
      body: SingleChildScrollView(
        child: Column(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                const SizedBox(height: 20),
                GestureDetector(
                  onTap: () => showDialog(
                    context: context,
                    builder: (context) => Dialog(
                      child: Image.network(
                        widget.usuario.avatar,
                        fit: BoxFit.contain,
                        errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 100),
                      ),
                    ),
                  ),
                  child: ClipOval(
                    child: Image.network(
                      widget.usuario.avatar,
                      width: 180,
                      height: 180,
                      fit: BoxFit.cover,
                      errorBuilder: (context, error, stackTrace) => Icon(Icons.person, size: 100),
                    ),
                  ),
                ),
             
          

            const SizedBox(height: 20),
            IconButton(
              icon: Icon(
                isFavorite ? Icons.star : Icons.star_border,
                color: isFavorite ? Colors.amber : Colors.grey,
              ),
              onPressed: () async {
                setState(() {
                  isFavorite = !isFavorite;
                });
                widget.onFavoriteChanged(isFavorite); // Actualiza la lista en UsuariosListScreen
                await FavoritesManager.saveFavorite(widget.usuario.id.toString(), isFavorite);
              },
            ),
            const SizedBox(height: 20),
            // Información del usuario
            ListTile(
              title: const Text("Nombre"),
              subtitle: Text('${widget.usuario.firstName} ${widget.usuario.lastName}'),
            ),
            ListTile(
              title: const Text("Correo Electrónico"),
              subtitle: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Expanded(
                    child: Text(
                      widget.usuario.email,
                      overflow: TextOverflow.ellipsis, 
                    ),
                  ),
                  IconButton(
                    icon: const Icon(Icons.copy, size: 18, color: Colors.grey),
                    padding: EdgeInsets.zero, 
                    constraints: const BoxConstraints(), 
                    onPressed: () {
                      Clipboard.setData(ClipboardData(text: widget.usuario.email));
                      ScaffoldMessenger.of(context).showSnackBar(
                        const SnackBar(content: Text('Correo copiado al portapapeles')),
                      );
                    },
                  ),
                ],
              ),
            ),
            ListTile(
              title: const Text("Género"),
              subtitle: Row(
                children: [
                  Icon(
                    widget.usuario.gender == "Male" ? Icons.male : Icons.female,
                    color: widget.usuario.gender == "Male" ? Colors.blue : Colors.pink,
                    size: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(widget.usuario.gender),
                ],
              ),
            ),
            ListTile(
              title: const Text("País"),
              subtitle: Row(
                children: [
                  Image.asset(
                    'assets/flags/${widget.usuario.country}.png',
                    width: 20,
                    height: 20,
                  ),
                  const SizedBox(width: 5),
                  Text(widget.usuario.country),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}