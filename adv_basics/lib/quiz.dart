import 'package:adv_basics/quizscreen.dart';
import 'package:adv_basics/resultscreen.dart';
import 'package:flutter/material.dart';
import 'package:adv_basics/startscreen.dart';

import 'data/questions.dart';

class Quiz extends StatefulWidget {
  const Quiz({Key? key}) : super(key: key);

  @override
  State<Quiz> createState() => _QuizState();
}

class _QuizState extends State<Quiz> {
  //Widget activeScreen = StartScreen(changeScreen);
  //Se utiliza initState porque asignar la funcion directamente en el constructor
  //da error ya que intenta asignar antes de que se cree la funcion
  Widget? activeScreen;

  List<String> answers = [];

  @override
  void initState() {
    activeScreen = StartScreen(changeQuizScreen);
    super.initState();
  }

  void changeQuizScreen() {
    setState(() {
      activeScreen = QuizScreen(addAnswer: addAnswer);
    });
  }

  void changeStartScreen() {
    setState(() {
      answers = [];
      activeScreen = StartScreen(changeQuizScreen);
    });
  }

  void addAnswer(String answer) {
    answers.add(answer);

    //Comparar si ya se respondieron todas las preguntas
    if (answers.length == questions.length) {
      //Cambiar a la pantalla de resultados
      setState(() {
        //answers = [];
        activeScreen = ResultScreen(
          respuestas: answers,
          resetQuiz: changeStartScreen,
        );
      });
    }
  }

  @override
  Widget build(context) {
    return MaterialApp(
      home: Scaffold(
        body: Container(
          decoration: const BoxDecoration(
            gradient: LinearGradient(
              begin: Alignment.topLeft,
              end: Alignment.bottomRight,
              colors: [
                Colors.blue,
                Colors.green,
              ],
            ),
          ),
          child: activeScreen,
        ),
      ),
    );
  }
}
