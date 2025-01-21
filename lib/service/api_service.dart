import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp2_flutter_grupo12/models/usuarios_model.dart';
import 'package:flutter_dotenv/flutter_dotenv.dart';

class ApiService {
  final String apiUrl = dotenv.env['API_URL'] ?? '';

  Future<List<Usuario>> fetchUsers() async {
    if (apiUrl.isEmpty) {
      throw Exception('La URL de la API no está configurada');
    }

    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> userData = jsonResponse['data']; 
      return userData.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }
}
