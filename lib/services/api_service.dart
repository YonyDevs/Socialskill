import 'dart:convert';
import 'package:http/http.dart' as http;

class ApiService {
  static const String baseUrl =
      'http://10.0.2.2:3000'; // Cambia según la configuración de tu backend

  // Función para registrar un nuevo usuario con todos los campos requeridos
  Future<Map<String, dynamic>> register(String username, String password,
      String name, String email, int age, String preference) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/register'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
          'name': name,
          'email': email,
          'age': age,
          'preference': preference,
        }),
      );

      return _processResponse(response);
    } catch (e) {
      throw Exception('Error al registrar usuario: $e');
    }
  }

  // Función para iniciar sesión
  Future<Map<String, dynamic>> login(String username, String password) async {
    try {
      final response = await http.post(
        Uri.parse('$baseUrl/login'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'username': username,
          'password': password,
        }),
      );

      return _processResponse(response);
    } catch (e) {
      throw Exception('Error al iniciar sesión: $e');
    }
  }

  // Función para enviar las respuestas del test
  Future<void> submitTestResponse(
      int userId, String question, int response) async {
    try {
      final http.Response res = await http.post(
        Uri.parse('$baseUrl/test-responses'),
        headers: {'Content-Type': 'application/json'},
        body: jsonEncode({
          'user_id': userId,
          'question': question,
          'response': response,
        }),
      );

      if (res.statusCode != 201) {
        throw Exception('Error al enviar las respuestas del test: ${res.body}');
      }
    } catch (e) {
      throw Exception('Error al enviar las respuestas del test: $e');
    }
  }

  // Función interna para procesar la respuesta HTTP y devolver un mapa
  Map<String, dynamic> _processResponse(http.Response response) {
    if (response.statusCode < 200 || response.statusCode >= 300) {
      throw Exception(
          'Error en la respuesta del servidor: ${response.statusCode}');
    }

    final Map<String, dynamic> responseData = jsonDecode(response.body);
    return {
      'statusCode': response.statusCode,
      'data': responseData,
    };
  }
}
