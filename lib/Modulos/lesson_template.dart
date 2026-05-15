import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

import '../progress_controller.dart';
import 'quiz_screen.dart';
import 'module_quizzes.dart';

class LessonTemplate extends StatefulWidget {

  final String title;
  final String description;
  final String videoUrl;
  final String moduleKey;

  const LessonTemplate({
    super.key,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.moduleKey,
  });

  @override
  State<LessonTemplate> createState() =>
      _LessonTemplateState();
}

class _LessonTemplateState
    extends State<LessonTemplate> {

  late YoutubePlayerController _controller;

  bool quizCompleted = false;

  @override
  void initState() {

    super.initState();

    final videoId =
    YoutubePlayer.convertUrlToId(
      widget.videoUrl,
    );

    _controller = YoutubePlayerController(

      initialVideoId: videoId ?? '',

      flags: const YoutubePlayerFlags(
        autoPlay: false,
        mute: false,
      ),
    );
  }

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      backgroundColor:
      const Color(0xFF1A082E),

      appBar: AppBar(

        title: Text(widget.title),

        backgroundColor:
        const Color(0xFF3E1E68),
      ),

      body: Padding(

        padding: const EdgeInsets.all(16.0),

        child: Column(

          crossAxisAlignment:
          CrossAxisAlignment.start,

          children: [

            // 🔥 VIDEO
            YoutubePlayer(
              controller: _controller,
            ),

            const SizedBox(height: 20),

            // 🔥 DESCRIPCIÓN
            Text(

              widget.description,

              style: const TextStyle(
                color: Colors.white70,
                fontSize: 16,
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // 🔥 BOTÓN QUIZ
            // =====================================================

            ElevatedButton(

              style: ElevatedButton.styleFrom(

                backgroundColor: Colors.blue,

                foregroundColor: Colors.white,
              ),

              onPressed: () async {

                final result =
                await Navigator.push(

                  context,

                  MaterialPageRoute(

                    builder: (_) => QuizScreen(

                      questions:
                      moduleQuizzes[
                      widget.moduleKey
                      ]!,
                    ),
                  ),
                );

                // 🔥 QUIZ APROBADO
                if (result == true) {

                  setState(() {

                    quizCompleted = true;
                  });

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(
                        "¡Quiz aprobado! Ahora puedes completar el módulo.",
                      ),

                      backgroundColor:
                      Colors.green,
                    ),
                  );
                }

                // 🔥 QUIZ NO APROBADO
                else {

                  ScaffoldMessenger.of(context)
                      .showSnackBar(

                    const SnackBar(

                      content: Text(
                        "Quiz no aprobado. Intenta nuevamente.",
                      ),

                      backgroundColor:
                      Colors.red,
                    ),
                  );
                }
              },

              child: const Text(
                "Realizar Quiz",
              ),
            ),

            const SizedBox(height: 20),

            // =====================================================
            // 🔥 COMPLETAR MÓDULO
            // =====================================================

            ElevatedButton(

              style: ElevatedButton.styleFrom(

                backgroundColor:
                quizCompleted
                    ? Colors.yellow
                    : Colors.grey,

                foregroundColor:
                Colors.black,
              ),

              onPressed: quizCompleted

                  ? () async {

                final progressController =

                Provider.of<
                    ProgressController>(
                  context,
                  listen: false,
                );

                // 🔥 GUARDAR EN FIRESTORE
                await progressController
                    .updateProgress(
                  widget.moduleKey,
                  1.0,
                );

                // 🔥 EVITAR ERROR CONTEXT
                if (!context.mounted) return;

                // 🔥 MENSAJE
                showDialog(

                  context: context,

                  builder: (_) => AlertDialog(

                    title: const Text(
                      "¡Módulo completado!",
                    ),

                    content: const Text(

                      "Excelente trabajo. Has aprendido conceptos clave de seguridad digital.",
                    ),

                    actions: [

                      TextButton(

                        onPressed: () {

                          Navigator.pop(context);

                          Navigator.pop(context);
                        },

                        child: const Text(
                          "Aceptar",
                        ),
                      ),
                    ],
                  ),
                );
              }

                  : null,

              child: const Text(
                "Completar módulo",
              ),
            ),
          ],
        ),
      ),
    );
  }

  @override
  void dispose() {

    _controller.dispose();

    super.dispose();
  }
}