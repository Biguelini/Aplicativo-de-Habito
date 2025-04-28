import 'package:flutter/material.dart';

class Habito {
  final String id;
  String name;
  TimeOfDay? reminderTime;
  String frequency;
  DateTime createdAt;
  List<DateTime> completedDates;

  Habito({
    required this.id,
    required this.name,
    this.reminderTime,
    required this.frequency,
    DateTime? createdAt,
    List<DateTime>? completedDates,
  }) : createdAt = createdAt ?? DateTime.now(),
       completedDates = completedDates ?? [];

  void completeToday() {
    final today = DateTime.now();
    if (!isCompletedToday()) {
      completedDates.add(DateTime(today.year, today.month, today.day));
    }
  }

  bool isCompletedToday() {
    final today = DateTime.now();
    return completedDates.any(
      (date) =>
          date.day == today.day &&
          date.month == today.month &&
          date.year == today.year,
    );
  }

  void undoToday() {
    final today = DateTime.now();
    completedDates.removeWhere(
      (date) =>
          date.day == today.day &&
          date.month == today.month &&
          date.year == today.year,
    );
  }
}
