import 'package:flutter/material.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';

class LessonTemplate extends StatefulWidget {
  final String title;
  final String description;
  final String videoUrl;

  const LessonTemplate({
    super.key,
    required this.title,
    required this.description,
    required this.videoUrl,
  });

  @override
  State<LessonTemplate> createState() => _LessonTemplateState();
}

class _LessonTemplateState extends State<LessonTemplate> {
  late YoutubePlayerController _controller;

  @override
  void initState() {
    super.initState();
    final videoId = YoutubePlayer.convertUrlToId(widget.videoUrl);
    _controller = YoutubePlayerController(
      initialVideoId: videoId ?? '',
      flags: const YoutubePlayerFlags(autoPlay: false, mute: false),
    );
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
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            YoutubePlayer(
              controller: _controller,
              showVideoProgressIndicator: true,
            ),
            const SizedBox(height: 20),
            Text(
              widget.description,
              style: const TextStyle(color: Colors.white70, fontSize: 16),
            ),
            const SizedBox(height: 20),
            ElevatedButton(
              onPressed: () {
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text('¡Módulo completado! 🎉'),
                    backgroundColor: Colors.green,
                  ),
                );
              },
              child: const Text("Completar módulo"),
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
