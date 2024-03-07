import 'package:adv_basics/question_summary.dart';
import 'package:flutter/material.dart';
import 'package:google_fonts/google_fonts.dart';

import 'data/questions.dart';

class ResultScreen extends StatelessWidget {
  const ResultScreen(
      {super.key, required this.respuestas, required this.resetQuiz});

  final void Function() resetQuiz;

  final List<String> respuestas;

  List<Map<String, Object>> getRespuestas() {
    List<Map<String, Object>> summary = [];

    for (var i = 0; i < respuestas.length; i++) {
      summary.add({
        "question_index": i,
        "question": questions[i].text,
        "answer": questions[i].answers.first,
        "user_answer": respuestas[i]
      });
    }
    return summary;
  }

  @override
  Widget build(BuildContext context) {
    final summary = getRespuestas();
    final numTotalQuestions = respuestas.length;
    final numCorrectAnswers = summary.where((item) {
      return item["answer"] == item["user_answer"];
    }).length;

    return SizedBox(
      width: double.infinity,
      child: Container(
        margin: const EdgeInsets.all(40),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          crossAxisAlignment: CrossAxisAlignment.stretch,
          children: [
            Text(
              "Ha respondido $numCorrectAnswers de $numTotalQuestions preguntas correctamente",
              textAlign: TextAlign.center,
              style: GoogleFonts.lato(color: Colors.white, fontSize: 20),
            ),
            const SizedBox(
              height: 20,
            ),
            QuestionSummary(summary),
            const SizedBox(
              height: 20,
            ),
            TextButton.icon(
              icon: const Icon(Icons.restart_alt_outlined, color: Colors.white),
              onPressed: resetQuiz,
              label: const Text(
                "Volver a jugar",
                style: TextStyle(fontSize: 20, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
