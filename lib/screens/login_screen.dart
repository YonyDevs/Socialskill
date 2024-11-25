// lib/screens/login_screen.dart

import 'package:flutter/material.dart';
import 'register_screen.dart';
import 'test_screen.dart';
import '../services/api_service.dart';

class LoginScreen extends StatefulWidget {
  @override
  _LoginScreenState createState() => _LoginScreenState();
}

class _LoginScreenState extends State<LoginScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  bool _isLoading = false;

  void _login() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _apiService.login(_username, _password);

        setState(() {
          _isLoading = false;
        });

        if (response['statusCode'] == 200) {
          int userId = response['data']['user']['id'];
          Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => TestScreen(userId: userId),
            ),
          );
        } else {
          _showDialog('Error', response['data']['message']);
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showDialog('Error', 'No se pudo loguear correctamente');
      }
    }
  }

  void _showDialog(String title, String message) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: Text(title),
          content: Text(message),
          actions: [
            ElevatedButton(
              child: Text('OK'),
              onPressed: () {
                Navigator.of(context).pop();
              },
            ),
          ],
        );
      },
    );
  }

  void _navigateToRegister() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => RegisterScreen()),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    SizedBox(height: 60),
                    Image.asset(
                      'assets/logo.png', // Asegúrate de que la ruta sea correcta
                      height: 120,
                    ),
                    SizedBox(height: 20),
                    Text(
                      'Social Skills',
                      style: TextStyle(
                        fontSize: 28,
                        fontWeight: FontWeight.bold,
                        color: Colors.teal,
                      ),
                    ),
                    SizedBox(height: 20),
                    Text(
                      'INICIAR SESIÓN',
                      style: TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.bold,
                        color: Colors.blueAccent,
                      ),
                    ),
                    SizedBox(height: 30),
                    Form(
                      key: _formKey,
                      child: Column(
                        children: [
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Usuario',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            validator: (value) =>
                                value!.isEmpty ? 'Ingrese su usuario' : null,
                            onSaved: (value) => _username = value!,
                          ),
                          SizedBox(height: 20),
                          TextFormField(
                            decoration: InputDecoration(
                              labelText: 'Contraseña',
                              border: OutlineInputBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                              filled: true,
                              fillColor: Colors.grey.shade100,
                            ),
                            obscureText: true,
                            validator: (value) =>
                                value!.isEmpty ? 'Ingrese su contraseña' : null,
                            onSaved: (value) => _password = value!,
                          ),
                          SizedBox(height: 30),
                          ElevatedButton(
                            onPressed: _login,
                            style: ElevatedButton.styleFrom(
                              backgroundColor: Colors
                                  .teal, // Cambiado de 'primary' a 'backgroundColor'
                              padding: EdgeInsets.symmetric(
                                  horizontal: 50, vertical: 15),
                              shape: RoundedRectangleBorder(
                                borderRadius: BorderRadius.circular(10),
                              ),
                            ),
                            child: Text(
                              'Iniciar Sesión',
                              style: TextStyle(
                                fontSize: 18,
                                color: Colors.white,
                              ),
                            ),
                          ),
                          SizedBox(height: 20),
                          GestureDetector(
                            onTap: _navigateToRegister,
                            child: Text(
                              'No tengo cuenta - Registrarse',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 10),
                          GestureDetector(
                            onTap: () {
                              // Acción para recuperar contraseña
                            },
                            child: Text(
                              'Recuperar contraseña',
                              style: TextStyle(
                                fontSize: 16,
                                color: Colors.blue,
                                decoration: TextDecoration.underline,
                              ),
                            ),
                          ),
                          SizedBox(height: 30),

                          /*Row(
                            mainAxisAlignment: MainAxisAlignment.center,
                            children: [
                              IconButton(
                                icon: Image.asset('assets/google_icon.png'),
                                iconSize: 40,
                                onPressed: () {
                                  // Acción para login con Google
                                },
                              ),
                              SizedBox(width: 20),
                              IconButton(
                                icon: Image.asset('assets/facebook_icon.png'),
                                iconSize: 40,
                                onPressed: () {
                                  // Acción para login con Facebook
                                },
                              ),
                            ],
                          ),*/
                        ],
                      ),
                    ),
                  ],
                ),
        ),
      ),
    );
  }
}
