import 'package:flutter/material.dart';
import 'package:flutter_application_1/screens/inicio_screen.dart';
import '../services/api_service.dart';

class TestScreen extends StatefulWidget {
  final int userId; // ID del usuario (pasado desde la pantalla de login)

  TestScreen({required this.userId});

  @override
  _TestScreenState createState() => _TestScreenState();
}

class _TestScreenState extends State<TestScreen> {
  final ApiService _apiService = ApiService();
  final _formKey = GlobalKey<FormState>();

  final List<String> questions = [
    // Preguntas del test (no modificadas)
    'dim1_q1: Me siento cómodo iniciando una conversación con un desconocido.',
    'dim1_q2: Puedo saludar a mis compañeros de trabajo o estudio sin sentir ansiedad.',
    'dim1_q3: Cuando veo a alguien que conozco, me siento seguro al acercarme a hablar.',
    'dim1_q4: Me siento confiado iniciando una conversación en un grupo grande de personas.',
    'dim1_q5: Puedo hacer preguntas abiertas para continuar una conversación sin problemas.',
    'dim1_q6: Me resulta fácil presentarme a nuevas personas en eventos sociales.',
    'dim1_q7: No me incomoda iniciar conversaciones en situaciones formales o profesionales.',
    'dim1_q8: Puedo cambiar de tema en una conversación sin sentirme ansioso o inseguro.',
    'dim2_q1: Mantengo contacto visual cuando alguien me está hablando.',
    'dim2_q2: Me siento cómodo asintiendo o haciendo pequeños comentarios mientras escucho.',
    'dim2_q3: Puedo recordar detalles importantes de una conversación.',
    'dim2_q4: Escucho sin interrumpir cuando alguien me está hablando.',
    'dim2_q5: Hago preguntas relevantes para demostrar que estoy prestando atención.',
    'dim2_q6: Puedo notar cuando una persona se siente incómoda o emocionada por lo que dice.',
    'dim2_q7: Me esfuerzo por entender el punto de vista de los demás antes de responder.',
    'dim2_q8: Me resulta natural adaptar mi estilo de escucha según la situación.',
    'dim3_q1: Me siento cómodo expresando mis opiniones incluso cuando son contrarias a las de los demás.',
    'dim3_q2: Puedo decir "no" a una solicitud sin sentirme culpable.',
    'dim3_q3: Puedo expresar cómo me siento sin dudar o sentir miedo.',
    'dim3_q4: Me siento seguro estableciendo límites claros en mis relaciones.',
    'dim3_q5: Puedo pedir lo que necesito sin sentirme incómodo o agresivo.',
    'dim3_q6: Me siento capaz de manejar críticas sin perder la calma.',
    'dim3_q7: Puedo expresar desacuerdos sin sentir que estoy generando conflicto.',
    'dim3_q8: Defiendo mis derechos sin sentir que estoy afectando la relación.',
    'dim4_q1: Me siento ansioso cuando tengo que hablar en público.',
    'dim4_q2: Me siento incómodo cuando soy el centro de atención.',
    'dim4_q3: Me pongo nervioso al conocer a nuevas personas.',
    'dim4_q4: Evito situaciones sociales donde siento que seré evaluado o juzgado.',
    'dim4_q5: Me siento tenso en situaciones donde debo interactuar con figuras de autoridad.',
    'dim4_q6: Tengo dificultades para relajarme en ambientes donde no conozco a nadie.',
    'dim4_q7: Me siento intranquilo cuando tengo que expresar mis ideas ante un grupo.',
    'dim4_q8: En reuniones o fiestas, me cuesta integrarme o iniciar conversaciones.',
    'dim5_q1: Me siento cómodo expresando mis emociones en una conversación.',
    'dim5_q2: Me cuesta pedir ayuda cuando lo necesito.',
    'dim5_q3: Puedo compartir mis sentimientos con personas cercanas sin sentirme incómodo.',
    'dim5_q4: Me siento seguro mostrando mi vulnerabilidad en situaciones emocionales.',
    'dim5_q5: Puedo identificar y poner nombre a las emociones que estoy sintiendo.',
    'dim5_q6: No me resulta difícil hablar sobre mis emociones en una situación de conflicto.',
    'dim5_q7: Me siento cómodo brindando apoyo emocional a otros.',
    'dim5_q8: Expreso gratitud y aprecio hacia los demás sin sentir vergüenza.',
    'dim6_q1: Me siento cómodo usando gestos y expresiones faciales en mis interacciones.',
    'dim6_q2: Puedo ajustar mi postura y lenguaje corporal según la situación.',
    'dim6_q3: Me siento seguro utilizando contacto visual en conversaciones.',
    'dim6_q4: Soy consciente del espacio personal de los demás y lo respeto.',
    'dim6_q5: Me resulta fácil interpretar las señales no verbales de las personas a mi alrededor.',
    'dim6_q6: Puedo modificar mi tono de voz para adecuarse a diferentes contextos.',
    'dim6_q7: Soy consciente de la coherencia entre mis gestos y lo que estoy diciendo.',
    'dim6_q8: Utilizo mi lenguaje corporal para transmitir confianza y seguridad en diversas situaciones.',
  ];

  Map<String, int?> _responses = {};
  bool _isLoading = false;
  int _currentPage = 0; // Página actual

  void _submitTest() async {
    if (_formKey.currentState!.validate()) {
      setState(() {
        _isLoading = true;
      });

      try {
        for (var question in questions) {
          int response = _responses[question] ?? 1;
          await _apiService.submitTestResponse(
              widget.userId, question.split(':')[0], response);
        }
        _showDialog('Éxito', 'Tus respuestas han sido enviadas exitosamente.');
      } catch (e) {
        _showDialog('Error', 'Ocurrió un error al enviar tus respuestas.');
      } finally {
        setState(() {
          _isLoading = false;
        });
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
              onPressed: _navigateToInicio,
            ),
          ],
        );
      },
    );
  }

  void _navigateToInicio() {
    Navigator.push(
      context,
      MaterialPageRoute(builder: (context) => InicioScreen()),
    );
  }

  void _nextPage() {
    if (_currentPage < (questions.length / 8).ceil() - 1) {
      setState(() {
        _currentPage++;
      });
    }
  }

  void _previousPage() {
    if (_currentPage > 0) {
      setState(() {
        _currentPage--;
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final questionsForCurrentPage = questions
        .skip(_currentPage * 8)
        .take(8)
        .toList(); // Obtén 8 preguntas por página

    return Scaffold(
      appBar: AppBar(
        title: Text('Test de Habilidades Sociales'),
      ),
      body: Padding(
        padding: EdgeInsets.all(16.0),
        child: _isLoading
            ? Center(child: CircularProgressIndicator())
            : Form(
                key: _formKey,
                child: Column(
                  children: [
                    Expanded(
                      child: ListView.builder(
                        itemCount: questionsForCurrentPage.length,
                        itemBuilder: (context, index) {
                          String questionText = questionsForCurrentPage[index]
                              .split(':')[1]; // Texto de la pregunta

                          return Card(
                            margin: EdgeInsets.symmetric(vertical: 8.0),
                            child: ListTile(
                              title: Text(questionText),
                              trailing: DropdownButton<int>(
                                value:
                                    _responses[questionsForCurrentPage[index]],
                                hint: Text('Selecciona una opción'),
                                items: [
                                  DropdownMenuItem(
                                      child: Text('1 - Muy incómodo'),
                                      value: 1),
                                  DropdownMenuItem(
                                      child: Text('2 - Incómodo'), value: 2),
                                  DropdownMenuItem(
                                      child: Text('3 - Neutral'), value: 3),
                                  DropdownMenuItem(
                                      child: Text('4 - Cómodo'), value: 4),
                                  DropdownMenuItem(
                                      child: Text('5 - Muy cómodo'), value: 5),
                                ],
                                onChanged: (value) {
                                  setState(() {
                                    _responses[questionsForCurrentPage[index]] =
                                        value; // Almacena la respuesta seleccionada
                                  });
                                },
                              ),
                            ),
                          );
                        },
                      ),
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        ElevatedButton(
                          onPressed: _previousPage,
                          child: Text('Anterior'),
                        ),
                        if (_currentPage == (questions.length / 8).ceil() - 1)
                          ElevatedButton(
                            onPressed: _submitTest,
                            child: Text('Enviar Test'),
                          )
                        else
                          ElevatedButton(
                            onPressed: _nextPage,
                            child: Text('Siguiente'),
                          ),
                      ],
                    ),
                    SizedBox(height: 24.0),
                  ],
                ),
              ),
      ),
    );
  }
}
