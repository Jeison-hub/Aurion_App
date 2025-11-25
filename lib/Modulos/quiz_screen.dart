import 'package:flutter/material.dart';

class QuizScreen extends StatefulWidget {
  final List<Map<String, dynamic>> questions;

  const QuizScreen({super.key, required this.questions});

  @override
  State<QuizScreen> createState() => _QuizScreenState();
}

class _QuizScreenState extends State<QuizScreen> {
  int currentQuestion = 0;
  int correctAnswers = 0;
  int? selectedOption;

  void nextQuestion() {
    if (selectedOption == null) return;

    if (widget.questions[currentQuestion]["answer"] == selectedOption) {
      correctAnswers++;
    }

    if (currentQuestion < widget.questions.length - 1) {
      setState(() {
        currentQuestion++;
        selectedOption = null;
      });
    } else {
      Navigator.pop(context, correctAnswers >= 3); // retorna true/false
    }
  }

  @override
  Widget build(BuildContext context) {
    final q = widget.questions[currentQuestion];

    return Scaffold(
      appBar: AppBar(title: const Text("Quiz del Módulo")),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: Column(
          children: [
            Text(
              q["question"],
              style: const TextStyle(fontSize: 20, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 20),

            ...List.generate(q["options"].length, (index) {
              return RadioListTile(
                title: Text(q["options"][index]),
                value: index,
                groupValue: selectedOption,
                onChanged: (value) {
                  setState(() => selectedOption = value);
                },
              );
            }),

            const Spacer(),
            ElevatedButton(
              onPressed: nextQuestion,
              child: Text(
                currentQuestion == widget.questions.length - 1
                    ? "Finalizar"
                    : "Siguiente",
              ),
            )
          ],
        ),
      ),
    );
  }
}
