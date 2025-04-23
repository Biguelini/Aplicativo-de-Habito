import 'package:flutter/material.dart';
import 'package:flutter_aula_1/models/habito.dart';
import 'package:uuid/uuid.dart';

class HabitoProvider with ChangeNotifier {
  final List<Habito> _habitos = [];

  List<Habito> get habitos => [..._habitos]; // cópia de defesa

  void addHabito({
    //adiciona um habito na lista
    required String name,
    required String frequency,
    required String icon,
    TimeOfDay? reminderTime,
  }) {
    final newHabito = Habito(
      id: const Uuid().v4(),
      name: name,
      frequency: frequency,
      icon: icon,
      reminderTime: reminderTime,
    );
    _habitos.add(newHabito);
    notifyListeners();
  }

  // atualiza os dados do habito que ja existe
  void editHabito(
    String id, {
    required String name,
    required String frequency,
    required String icon,
    TimeOfDay? remindertime,
  }) {
    final index = _habitos.indexWhere((habito) => habito.id == id);
    if (index >= 0) {
      _habitos[index].name = name;
      _habitos[index].frequency = frequency;
      _habitos[index].icon = icon;
      _habitos[index].reminderTime = remindertime;
      notifyListeners();
    }
  }

  //deleta um habito da lista
  void deleteHabito(String id) {
    _habitos.removeWhere((habito) => habito.id == id);
    notifyListeners();
  }

  //marca o habito como feito hoje
  void completeHabito(String id) {
    final habito = _habitos.firstWhere((habito) => habito.id == id);
    habito.completeToday();
    notifyListeners();
  }

  //desmarca o habito feito hoje
  void undoHabito(String id) {
    final habito = _habitos.firstWhere((habito) => habito.id == id);
    habito.undoToday();
    notifyListeners();
  }

  //busca um habito especifico
  Habito getHabitoById(String id) {
    return _habitos.firstWhere((habito) => habito.id == id);
  }
}
