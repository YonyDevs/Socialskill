// lib/screens/ejercicio_screen.dart

import 'package:flutter/material.dart';
import '../data/ejercicios_data.dart';

class EjercicioScreen extends StatefulWidget {
  final String dimension;
  final int initialExerciseIndex;

  EjercicioScreen({required this.dimension, this.initialExerciseIndex = 0});

  @override
  _EjercicioScreenState createState() => _EjercicioScreenState();
}

class _EjercicioScreenState extends State<EjercicioScreen> {
  String? _selectedOption;
  String _status = 'En progreso';
  final TextEditingController _commentController = TextEditingController();
  late int _currentExerciseIndex;

  @override
  void initState() {
    super.initState();
    _currentExerciseIndex = widget.initialExerciseIndex;
  }

  @override
  Widget build(BuildContext context) {
    final exercisesForDimension = ejercicios[widget.dimension];
    if (exercisesForDimension == null ||
        _currentExerciseIndex >= exercisesForDimension.length) {
      return Scaffold(
        appBar: AppBar(
          title: Text('Ejercicio no disponible'),
          backgroundColor: Colors.teal,
        ),
        body: Center(
            child: Text('No hay ejercicios disponibles para esta dimensión.')),
      );
    }

    final currentExercise = exercisesForDimension[_currentExerciseIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(currentExercise['nombre']),
        backgroundColor: Colors.teal,
      ),
      body: SingleChildScrollView(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            // Imagen de Ejercicio
            Image.asset(
              currentExercise['imagen'] ?? 'assets/logo.png',
              height: 80,
              fit: BoxFit.cover,
            ),
            SizedBox(height: 20),
            Center(
              child: Text(
                currentExercise['nombre'],
                style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.bold,
                    color: Colors.teal),
                textAlign: TextAlign.center,
              ),
            ),
            SizedBox(height: 10),
            Text(
              currentExercise['descripcion'],
              style: TextStyle(fontSize: 16, color: Colors.grey[700]),
              textAlign: TextAlign.center,
            ),
            SizedBox(height: 20),
            Row(
              children: [
                Icon(Icons.question_answer, color: Colors.grey),
                SizedBox(width: 8),
                Expanded(
                  child: Text(
                    currentExercise['pregunta'],
                    style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                  ),
                ),
              ],
            ),
            SizedBox(height: 10),
            Column(
              children: currentExercise['opciones'].map<Widget>((option) {
                return RadioListTile<String>(
                  title: Text(option),
                  value: option,
                  groupValue: _selectedOption,
                  onChanged: (value) {
                    setState(() {
                      _selectedOption = value;
                    });
                  },
                );
              }).toList(),
            ),
            SizedBox(height: 20),
            TextField(
              controller: _commentController,
              decoration: InputDecoration(
                labelText: 'Escribe un comentario sobre el ejercicio',
                border: OutlineInputBorder(),
              ),
              maxLines: 3,
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                if (_selectedOption != null) {
                  // Aquí puedes guardar el comentario en un backend o almacenamiento local
                  print('Comentario: ${_commentController.text}');
                  showDialog(
                    context: context,
                    builder: (BuildContext context) {
                      return AlertDialog(
                        content: Text("¡Bien hecho!\nSigue conversando..."),
                        actions: <Widget>[
                          TextButton(
                            onPressed: () {
                              Navigator.of(context).pop();
                              setState(() {
                                if (_currentExerciseIndex <
                                    exercisesForDimension.length - 1) {
                                  _currentExerciseIndex++;
                                  _selectedOption = null;
                                  _commentController.clear();
                                  _status = 'En progreso';
                                } else {
                                  ScaffoldMessenger.of(context).showSnackBar(
                                    SnackBar(
                                      content: Text(
                                          'Has completado todos los ejercicios de esta dimensión.'),
                                    ),
                                  );
                                }
                              });
                            },
                            child: Text("Continuar"),
                          ),
                        ],
                      );
                    },
                  );
                } else {
                  ScaffoldMessenger.of(context).showSnackBar(
                    SnackBar(
                      content:
                          Text("Selecciona una respuesta antes de continuar."),
                    ),
                  );
                }
              },
              child: Text('Guardar comentario'),
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.teal,
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(10),
                ),
                padding: EdgeInsets.symmetric(vertical: 15, horizontal: 20),
              ),
            ),
            SizedBox(height: 20),
            Text(
              'Estado del ejercicio:',
              style: TextStyle(fontSize: 18),
            ),
            SizedBox(height: 10),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                ElevatedButton(
                  onPressed: () => setState(() {
                    _status = 'En progreso';
                  }),
                  child: Text('En progreso'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _status == 'En progreso' ? Colors.orange : Colors.grey,
                  ),
                ),
                SizedBox(width: 10),
                ElevatedButton(
                  onPressed: () => setState(() {
                    _status = 'Realizado';
                  }),
                  child: Text('Realizado'),
                  style: ElevatedButton.styleFrom(
                    backgroundColor:
                        _status == 'Realizado' ? Colors.green : Colors.grey,
                  ),
                ),
              ],
            ),
            SizedBox(height: 20),
            Text(
              'Estado actual: $_status',
              style: TextStyle(fontSize: 16),
            ),
            SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                setState(() {
                  if (_currentExerciseIndex <
                      exercisesForDimension.length - 1) {
                    _currentExerciseIndex++;
                    _selectedOption = null;
                    _commentController.clear();
                    _status = 'En progreso';
                  } else {
                    ScaffoldMessenger.of(context).showSnackBar(
                      SnackBar(
                        content: Text(
                            'Has completado todos los ejercicios de esta dimensión.'),
                      ),
                    );
                  }
                });
              },
              child: Text('Siguiente Ejercicio'),
              style: ElevatedButton.styleFrom(backgroundColor: Colors.teal),
            ),
          ],
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
