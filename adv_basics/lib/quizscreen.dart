import 'package:adv_basics/answer_button.dart';
import 'package:google_fonts/google_fonts.dart';
import 'package:flutter/material.dart';

import 'data/questions.dart';

class QuizScreen extends StatefulWidget {
  const QuizScreen({super.key, required this.addAnswer});

  final void Function(String answer) addAnswer;

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int questionIndex = 0;

  final currentQuestion = questions[0];

  void answerQuestion(String answer) {
    //Esta propiedad es para el state, hace referencia al widget padre
    widget.addAnswer(answer);
    setState(() {
      questionIndex++;
    });
  }

  @override
  Widget build(BuildContext context) {
    final currentQuestion = questions[questionIndex];

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              'Pregunta ${questionIndex + 1} de 5',
              style: GoogleFonts.lato(color: Colors.white, fontSize: 30),
              textAlign: TextAlign.center,
            ),
            const SizedBox(
              height: 20,
            ),
            Text(
              currentQuestion.text,
              textAlign: TextAlign.center,
              style: const TextStyle(color: Colors.white, fontSize: 15),
            ),
            const SizedBox(
              height: 20,
            ),
            ...currentQuestion.getShuffledAnswers().map((item) {
              return AnswerButton(
                  answerText: item,
                  onTap: () {
                    answerQuestion(item);
                  });
            }),
          ],
        ),
      ),
    );
  }
}
