import 'package:flutter/material.dart';
import 'lesson_template.dart';

class Lesson7Screen extends StatelessWidget {
  const Lesson7Screen({super.key});

  @override
  Widget build(BuildContext context) {
    return LessonTemplate(
      title: 'Módulo 7: Proteccion de datos personales.',
      description:
      'Tus datos personales son una parte importante de tu vida. Conoce cómo protegerlos y cómo te ayuda a hacerlo la Agencia Española de Protección de Datos .',
      videoUrl: 'https://www.youtube.com/watch?v=lRozhQS6kN8',
      moduleKey: "modulo7",
    );
  }
}
