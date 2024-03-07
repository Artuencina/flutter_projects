import 'package:flutter/material.dart';

class QuestionSummary extends StatelessWidget {
  const QuestionSummary(this.respuestas, {super.key});

  final List<Map<String, Object>> respuestas;

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      width: double.infinity,
      height: 300,
      child: SingleChildScrollView(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          mainAxisSize: MainAxisSize.max,
          children: respuestas.map((data) {
            final correct = data["answer"] == data["user_answer"];
            return Row(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ClipOval(
                  child: Container(
                    alignment: Alignment.center,
                    width: 30,
                    height: 30,
                    color: correct ? Colors.green : Colors.red,
                    child: Text(
                      ((data["question_index"] as int) + 1).toString(),
                      style: const TextStyle(color: Colors.white),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ),
                const SizedBox(
                  width: 15,
                ),
                Expanded(
                  child: Column(
                    children: [
                      Text(
                        data["question"] as String,
                        style:
                            const TextStyle(color: Colors.white, fontSize: 15),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      Text(data["user_answer"] as String,
                          style: TextStyle(
                              color: correct ? Colors.greenAccent : Colors.red,
                              fontSize: 15)),
                      Text(data["answer"] as String,
                          style: const TextStyle(
                              color: Colors.amber, fontSize: 15)),
                      const SizedBox(
                        height: 20,
                      ),
                    ],
                  ),
                )
              ],
            );
          }).toList(),
        ),
      ),
    );
  }
}
