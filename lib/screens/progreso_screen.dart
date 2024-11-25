// lib/screens/progreso_screen.dart

import 'package:flutter/material.dart';
import '../data/ejercicios_data.dart';
import 'ejercicio_screen.dart';

class ProgresoScreen extends StatelessWidget {
  final String dimension;

  ProgresoScreen({required this.dimension});

  @override
  Widget build(BuildContext context) {
    final exercises = ejercicios[dimension];

    return Scaffold(
      appBar: AppBar(
        title: Text('Progreso: $dimension'),
        backgroundColor: Colors.teal,
      ),
      body: exercises == null || exercises.isEmpty
          ? Center(
              child: Text(
                'No hay ejercicios disponibles para esta dimensión.',
                style: TextStyle(fontSize: 18, color: Colors.grey),
              ),
            )
          : Padding(
              padding: const EdgeInsets.all(16.0),
              child: ListView.builder(
                itemCount: exercises.length,
                itemBuilder: (context, index) {
                  final exercise = exercises[index];
                  return Padding(
                    padding: const EdgeInsets.symmetric(vertical: 8.0),
                    child: Card(
                      elevation: 3,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10),
                      ),
                      child: ListTile(
                        leading: Icon(
                          Icons.fitness_center,
                          color: Colors.teal[800],
                          size: 30,
                        ),
                        title: Text(
                          exercise['nombre'],
                          style: TextStyle(
                            fontSize: 16,
                            fontWeight: FontWeight.w500,
                            color: Colors.teal[900],
                          ),
                        ),
                        subtitle: Text(
                          exercise['descripcion'],
                          style:
                              TextStyle(fontSize: 14, color: Colors.grey[700]),
                        ),
                        trailing: Icon(
                          Icons.arrow_forward_ios,
                          color: Colors.teal[800],
                        ),
                        onTap: () {
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => EjercicioScreen(
                                dimension: dimension,
                                initialExerciseIndex: index,
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                  );
                },
              ),
            ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            label: 'Inicio',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.bar_chart),
            label: 'Progreso',
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.person),
            label: 'Perfil',
          ),
        ],
        selectedItemColor: Colors.teal,
        currentIndex: 1, // 'Progreso' está seleccionado
        onTap: (index) {
          switch (index) {
            case 0:
              Navigator.popUntil(context, (route) => route.isFirst);
              break;
            case 1:
              // Ya estamos en Progreso
              break;
            case 2:
              // Navegar a la pantalla de Perfil si está implementada
              ScaffoldMessenger.of(context).showSnackBar(
                SnackBar(content: Text('Perfil no implementado aún.')),
              );
              break;
          }
        },
      ),
    );
  }
}
