import 'package:flutter/material.dart';

class Habito {
  final String id;
  String name;
  TimeOfDay? reminderTime;
  String frequency; // se vai ser diario ou semanal etc
  String icon;
  DateTime createdAt;
  List<DateTime> completedDates;

  Habito({
    required this.id,
    required this.name,
    this.reminderTime,
    required this.frequency,
    required this.icon,
    DateTime? createdAt,
    List<DateTime>? completedDates,
  }) : createdAt = createdAt ?? DateTime.now(),
       completedDates = completedDates ?? [];

  void completeToday() {
    // marca o habito como finalizado pro dia atual
    final today = DateTime.now();
    if (!isCompletedToday()) {
      completedDates.add(DateTime(today.day, today.month, today.year));
    }
  }

  bool isCompletedToday() {
    // ver se o habito ja foi feito hoje
    final today = DateTime.now();
    return completedDates.any(
      (date) =>
          date.day == today.day &&
          date.month == today.month &&
          date.year == today.year,
    );
  }

  void undoToday() { // remove o registro de hoje caso o user desmarque
    final today = DateTime.now();
    completedDates.removeWhere(
      (date) =>
          date.day == today.day &&
          date.month == today.month &&
          date.year == today.year,
    );
  }
}
