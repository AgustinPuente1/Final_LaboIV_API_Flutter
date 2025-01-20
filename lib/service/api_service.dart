import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:tp2_flutter_grupo12/models/usuarios_model.dart';

class ApiService {
  final String apiUrl = 'https://tp1-api-grupo12.onrender.com/api/v1/usuarios';

  Future<List<Usuario>> fetchUsers() async {
    final response = await http.get(Uri.parse(apiUrl));

    if (response.statusCode == 200) {
      final Map<String, dynamic> jsonResponse = jsonDecode(response.body);
      final List<dynamic> userData = jsonResponse['data']; // Accede a la clave 'data'
      return userData.map((json) => Usuario.fromJson(json)).toList();
    } else {
      throw Exception('Error al cargar los usuarios');
    }
  }

}
