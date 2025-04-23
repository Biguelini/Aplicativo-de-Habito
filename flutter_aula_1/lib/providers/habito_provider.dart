import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/habito.dart';
import 'package:uuid/uuid.dart';

class HabitoProvider with ChangeNotifier {
  final List<Habito> _habitos = [];

  List<Habito> get habitos => [..._habitos];

  void addHabito({
    required String name,
    required String frequency,
    TimeOfDay? reminderTime,
  }) {
    final newHabito = Habito(
      id: const Uuid().v4(),
      name: name,
      frequency: frequency,
      reminderTime: reminderTime,
    );
    _habitos.add(newHabito);
    notifyListeners();
  }

  void editHabito(
    String id, {
    required String name,
    required String frequency,
    TimeOfDay? remindertime,
  }) {
    final index = _habitos.indexWhere((habito) => habito.id == id);
    if (index >= 0) {
      _habitos[index].name = name;
      _habitos[index].frequency = frequency;
      _habitos[index].reminderTime = remindertime;
      notifyListeners();
    }
  }

  void deleteHabito(String id) {
    _habitos.removeWhere((habito) => habito.id == id);
    notifyListeners();
  }

  void completeHabito(String id) {
    final habito = _habitos.firstWhere((habito) => habito.id == id);
    habito.completeToday();
    notifyListeners();
  }

  void undoHabito(String id) {
    final habito = _habitos.firstWhere((habito) => habito.id == id);
    habito.undoToday();
    notifyListeners();
  }

  Habito getHabitoById(String id) {
    return _habitos.firstWhere((habito) => habito.id == id);
  }
}
