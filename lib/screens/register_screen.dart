import 'package:flutter/material.dart';
import 'login_screen.dart'; // Importar la pantalla de login
import '../services/api_service.dart';

class RegisterScreen extends StatefulWidget {
  @override
  _RegisterScreenState createState() => _RegisterScreenState();
}

class _RegisterScreenState extends State<RegisterScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  String _username = '';
  String _password = '';
  String _name = '';
  String _email = '';
  int _age = 0;
  String _preference = '';

  bool _isLoading = false;

  void _register() async {
    if (_formKey.currentState!.validate()) {
      _formKey.currentState!.save();
      setState(() {
        _isLoading = true;
      });

      try {
        final response = await _apiService.register(
          _username,
          _password,
          _name,
          _email,
          _age,
          _preference,
        );

        setState(() {
          _isLoading = false;
        });

        if (response['statusCode'] == 201) {
          _showDialog('Éxito', response['data']['message'], redirect: true);
        } else if (response['statusCode'] == 409) {
          // Manejo específico para el error de correo ya registrado
          _showDialog('Error', 'Ese correo ya está registrado');
        } else {
          _showDialog('Error', response['data']['message']);
        }
      } catch (e) {
        setState(() {
          _isLoading = false;
        });
        _showDialog('Error', 'No se pudo conectar con el servidor.');
      }
    }
  }

  void _showDialog(String title, String message, {bool redirect = false}) {
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
                if (redirect) {
                  // Redirigir a la pantalla de login
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(builder: (context) => LoginScreen()),
                  );
                }
              },
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Registrar'),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: EdgeInsets.all(16.0),
          child: _isLoading
              ? Center(child: CircularProgressIndicator())
              : Form(
                  key: _formKey,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.stretch,
                    children: [
                      SizedBox(height: 40.0),
                      Center(
                        child: Column(
                          children: [
                            Image.asset(
                              'assets/logo.png', // Asegúrate de tener el logo en esta ruta
                              height: 100,
                            ),
                            SizedBox(height: 10.0),
                            Text(
                              'Social Skills',
                              style: TextStyle(
                                fontSize: 24.0,
                                fontWeight: FontWeight.bold,
                                color: Colors.teal,
                              ),
                            ),
                            SizedBox(height: 16.0),
                            Text(
                              'REGÍSTRATE',
                              style: TextStyle(
                                fontSize: 18.0,
                                color: Colors.teal,
                              ),
                            ),
                          ],
                        ),
                      ),
                      SizedBox(height: 24.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Nombre',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Ingrese su nombre' : null,
                        onSaved: (value) => _name = value!,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Edad',
                          border: OutlineInputBorder(),
                        ),
                        keyboardType: TextInputType.number,
                        validator: (value) =>
                            value!.isEmpty ? 'Ingrese su edad' : null,
                        onSaved: (value) => _age = int.parse(value!),
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Correo electrónico',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Ingrese su correo' : null,
                        onSaved: (value) => _email = value!,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Usuario',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Ingrese un usuario' : null,
                        onSaved: (value) => _username = value!,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Contraseña',
                          border: OutlineInputBorder(),
                        ),
                        obscureText: true,
                        validator: (value) =>
                            value!.isEmpty ? 'Ingrese una contraseña' : null,
                        onSaved: (value) => _password = value!,
                      ),
                      SizedBox(height: 16.0),
                      TextFormField(
                        decoration: InputDecoration(
                          labelText: 'Preferencia',
                          border: OutlineInputBorder(),
                        ),
                        validator: (value) =>
                            value!.isEmpty ? 'Ingrese su preferencia' : null,
                        onSaved: (value) => _preference = value!,
                      ),
                      SizedBox(height: 24.0),
                      ElevatedButton(
                        onPressed: _register,
                        style: ElevatedButton.styleFrom(
                          backgroundColor: Colors.teal,
                          padding: EdgeInsets.symmetric(vertical: 16.0),
                          shape: RoundedRectangleBorder(
                            borderRadius: BorderRadius.circular(8.0),
                          ),
                        ),
                        child: Text(
                          'Registrar',
                          style: TextStyle(fontSize: 18.0),
                        ),
                      ),
                    ],
                  ),
                ),
        ),
      ),
    );
  }
}
