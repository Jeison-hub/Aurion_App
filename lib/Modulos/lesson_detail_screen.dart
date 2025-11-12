import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonDetailScreen extends StatefulWidget {
  final String title;
  final String description;
  final String videoUrl;
  final String currentUser; // usuario actual

  const LessonDetailScreen({
    super.key,
    required this.title,
    required this.description,
    required this.videoUrl,
    required this.currentUser,
  });

  @override
  State<LessonDetailScreen> createState() => _LessonDetailScreenState();
}

class _LessonDetailScreenState extends State<LessonDetailScreen> {
  late YoutubePlayerController _controller;
  late Box userBox;
  double progress = 0.0;

  @override
  void initState() {
    super.initState();
    userBox = Hive.box('userProgress');

    // Cargar progreso guardado
    progress = userBox.get('${widget.currentUser}_${widget.title}', defaultValue: 0.0);

    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
  }

  void completeLesson() {
    setState(() {
      progress = 1.0; // 100% completado
      userBox.put('${widget.currentUser}_${widget.title}', progress);
    });

    ScaffoldMessenger.of(context).showSnackBar(
      const SnackBar(content: Text("¡Lección completada!")),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFF1A082E),
      appBar: AppBar(
        title: Text(widget.title),
        backgroundColor: const Color(0xFF3E1E68),
      ),
      body: Padding(
        padding: const EdgeInsets.all(16.0),
        child: ListView(
          children: [
            Text(
              widget.title,
              style: const TextStyle(color: Colors.white, fontSize: 24, fontWeight: FontWeight.bold),
            ),
            const SizedBox(height: 12),
            Text(widget.description, style: const TextStyle(color: Colors.white70, fontSize: 16)),
            const SizedBox(height: 20),
            YoutubePlayer(controller: _controller, showVideoProgressIndicator: true),
            const SizedBox(height: 20),
            LinearProgressIndicator(
              value: progress,
              backgroundColor: Colors.white24,
              color: Colors.greenAccent,
            ),
            const SizedBox(height: 20),
            ElevatedButton.icon(
              style: ElevatedButton.styleFrom(
                backgroundColor: Colors.greenAccent,
                foregroundColor: Colors.black,
                padding: const EdgeInsets.symmetric(vertical: 12),
                shape: RoundedRectangleBorder(borderRadius: BorderRadius.circular(12)),
              ),
              icon: const Icon(Icons.check_circle_outline),
              label: Text(progress == 1.0 ? "Completado" : "Marcar como completado"),
              onPressed: progress == 1.0 ? null : completeLesson,
            ),
          ],
        ),
      ),
    );
  }
}
