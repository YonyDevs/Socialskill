// lib/screens/dimensiones_screen.dart

import 'package:flutter/material.dart';
import 'progreso_screen.dart';

class DimensionesScreen extends StatelessWidget {
  // Actualizar la lista de dimensiones para que coincida con las claves en ejercicios_data.dart
  final List<String> dimensiones = [
    'Iniciación de conversaciones',
    'Escucha activa y atención',
    'Habilidades de asertividad',
    'Gestión de la ansiedad social',
    'Expresión emocional',
    'Comunicación no verbal',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text('Dimensiones'),
        backgroundColor: Colors.teal,
      ),
      body: Column(
        children: [
          SizedBox(height: 20),
          // Logo de la aplicación
          Center(
            child: Image.asset(
              'assets/logo.png', // Asegúrate de agregar esta imagen a tu carpeta de assets
              height: 80,
            ),
          ),
          SizedBox(height: 20),
          Text(
            'Selecciona una dimensión para comenzar',
            style: TextStyle(
                fontSize: 18, fontWeight: FontWeight.bold, color: Colors.teal),
            textAlign: TextAlign.center,
          ),
          SizedBox(height: 20),
          Expanded(
            child: ListView.builder(
              itemCount: dimensiones.length,
              itemBuilder: (context, index) {
                return Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 16, vertical: 8),
                  child: GestureDetector(
                    onTap: () {
                      Navigator.push(
                        context,
                        MaterialPageRoute(
                          builder: (context) => ProgresoScreen(
                            dimension: dimensiones[index],
                          ),
                        ),
                      );
                    },
                    child: Card(
                      elevation: 4,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.star,
                          color: Colors.teal[800],
                          size: 30,
                        ),
                        title: Text(
                          dimensiones[index],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.teal[900],
                          ),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.teal[800],
                        ),
                      ),
                    ),
                  ),
                );
              },
            ),
          ),
        ],
      ),
    );
  }
}
