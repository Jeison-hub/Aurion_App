import 'package:flutter/material.dart';

class QuizQuestion extends StatefulWidget {
  final List<Map<String, dynamic>> questions;
  final String moduleName;

  const QuizQuestion({
    super.key,
    required this.questions,
    required this.moduleName,
  });

  @override
  State<QuizQuestion> createState() => _QuizQuestionState();
}

class _QuizQuestionState extends State<QuizQuestion> {
  int currentIndex = 0;
  int? selectedIndex;
  int score = 0;

  void next() {
    if (selectedIndex == null) return;

    // Verificar respuesta correcta
    if (selectedIndex == widget.questions[currentIndex]["correct"]) {
      score++;
    }

    // Pasar a la siguiente pregunta
    if (currentIndex + 1 < widget.questions.length) {
      setState(() {
        currentIndex++;
        selectedIndex = null;
      });
    } else {
      // Quiz finalizado → regresamos con los resultados
      Navigator.pop(context, {
        "score": score,
        "total": widget.questions.length,
      });
    }
  }

  @override
  Widget build(BuildContext context) {
    final question = widget.questions[currentIndex];

    return Scaffold(
      appBar: AppBar(
        title: Text(widget.moduleName),
        backgroundColor: const Color(0xFF3E1E68),
      ),
      backgroundColor: const Color(0xFF1A082E),
      body: Padding(
        padding: const EdgeInsets.all(20),
        child: Column(
          children: [
            Text(
              question["question"],
              textAlign: TextAlign.center,
              style: const TextStyle(
                color: Colors.white,
                fontSize: 22,
                fontWeight: FontWeight.bold,
              ),
            ),

            const SizedBox(height: 30),

            ...List.generate(
              question["options"].length,
                  (i) => GestureDetector(
                onTap: () => setState(() => selectedIndex = i),
                child: Container(
                  margin: const EdgeInsets.symmetric(vertical: 8),
                  padding: const EdgeInsets.all(15),
                  decoration: BoxDecoration(
                    color: selectedIndex == i
                        ? Colors.yellow
                        : Colors.white.withOpacity(0.2),
                    borderRadius: BorderRadius.circular(12),
                  ),
                  child: Text(
                    question["options"][i],
                    style: TextStyle(
                      color: selectedIndex == i ? Colors.black : Colors.white,
                      fontSize: 18,
                    ),
                  ),
                ),
              ),
            ),

            const Spacer(),

            ElevatedButton(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.yellow,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(horizontal: 40, vertical: 15),
              ),
              onPressed: selectedIndex == null ? null : next,
              child: Text(
                currentIndex + 1 == widget.questions.length
                    ? "Finalizar"
                    : "Siguiente",
                style: const TextStyle(fontSize: 18),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
