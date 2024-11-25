// lib/screens/welcome_screen.dart

import 'package:flutter/material.dart';
import 'login_screen.dart'; // Asegúrate de tener estas pantallas
import 'register_screen.dart';

class WelcomeScreen extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Stack(
        children: [
          // Fondo blanco
          Container(
            color: Colors.white,
          ),
          // Logo y texto centrado
          Center(
            child: Column(
              mainAxisSize: MainAxisSize.min,
              children: [
                Image.asset(
                  'assets/logo.png', // Ruta del logo
                  height: 150, // Tamaño del código
                ),
                SizedBox(height: 20),
                Text(
                  'Social Skills',
                  style: TextStyle(
                    fontSize: 28,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal, // Color similar al logo
                    shadows: [
                      Shadow(
                        blurRadius: 5.0,
                        color: Colors.black.withOpacity(0.25),
                        offset: Offset(2.0, 2.0),
                      ),
                    ],
                  ),
                ),
              ],
            ),
          ),
          // Botones en la parte inferior
          Align(
            alignment: Alignment.bottomCenter,
            child: Row(
              children: [
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => LoginScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueGrey.shade800,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topLeft: Radius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Iniciar sesión',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
                Expanded(
                  child: ElevatedButton(
                    onPressed: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => RegisterScreen(),
                        ),
                      );
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: Colors.blueAccent.shade700,
                      padding: EdgeInsets.symmetric(vertical: 20),
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.only(
                          topRight: Radius.circular(30.0),
                        ),
                      ),
                    ),
                    child: Text(
                      'Registrarse',
                      style: TextStyle(
                        fontSize: 20,
                        color: Colors.white,
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
