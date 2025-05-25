import 'package:flutter/material.dart';

class Habito {
  final String id;
  final String userId; // novo campo
  String name;
  TimeOfDay? reminderTime;
  String frequency;
  DateTime createdAt;
  List<DateTime> completedDates;

  Habito({
    required this.id,
    required this.userId, // obrigatório no construtor
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

  Map<String, dynamic> toMap() {
    return {
      'id': id,
      'name': name,
      'userId': userId,
      'frequency': frequency,
      'reminderTime':
          reminderTime != null
              ? {'hour': reminderTime!.hour, 'minute': reminderTime!.minute}
              : null,
      'createdAt': createdAt.toIso8601String(),
      'completedDates': completedDates.map((d) => d.toIso8601String()).toList(),
    };
  }

  factory Habito.fromMap(Map<String, dynamic> map) {
    return Habito(
      id: map['id'],
      name: map['name'],
      userId: map['userId'],
      frequency: map['frequency'],
      reminderTime:
          map['reminderTime'] != null
              ? TimeOfDay(
                hour: map['reminderTime']['hour'],
                minute: map['reminderTime']['minute'],
              )
              : null,
      createdAt: DateTime.parse(map['createdAt']),
      completedDates:
          (map['completedDates'] as List<dynamic>)
              .map((d) => DateTime.parse(d))
              .toList(),
    );
  }
}
