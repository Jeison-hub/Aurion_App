import 'package:flutter/material.dart';
import 'package:hive_flutter/hive_flutter.dart';

class ProgressController extends ChangeNotifier {
  late Box _box;

  // Estructura: { "modulo1": 1.0, "modulo2": 0.5, ... }
  Map<String, double> _progress = {};

  // Lista de trofeos desbloqueados
  List<bool> _achievements = List.generate(7, (_) => false);

  ProgressController() {
    _initHive();
  }

  Future<void> _initHive() async {
    await Hive.initFlutter();
    _box = await Hive.openBox('progressBox');
    _loadData();
  }

  void _loadData() {
    final savedProgress = Map<String, double>.from(_box.get('progress', defaultValue: {}));
    final savedAchievements = List<bool>.from(_box.get('achievements', defaultValue: List.generate(7, (_) => false)));

    _progress = savedProgress;
    _achievements = savedAchievements;
    notifyListeners();
  }

  // Getter del progreso
  Map<String, double> get progress => _progress;

  // Getter de trofeos
  List<bool> get achievements => _achievements;

  // Calcular progreso total promedio
  double get totalProgress {
    if (_progress.isEmpty) return 0.0;
    return _progress.values.reduce((a, b) => a + b) / _progress.length;
  }

  // Actualizar progreso de un módulo
  void updateProgress(int index, double value) {
    final key = 'modulo${index + 1}';
    _progress[key] = value.clamp(0.0, 1.0);

    if (value == 1.0) {
      _achievements[index] = true; // Desbloquear trofeo
    }

    _saveData();
    notifyListeners();
  }

  // Guardar datos en Hive
  void _saveData() {
    _box.put('progress', _progress);
    _box.put('achievements', _achievements);
  }

  // 🔹 Limpiar progreso
  void resetProgress() {
    _progress.clear();
    _achievements = List.generate(7, (_) => false);
    _saveData();
    notifyListeners();
  }
}
