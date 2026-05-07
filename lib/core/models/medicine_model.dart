import 'package:flutter/material.dart';

class Medicine {
  final String name;
  final String dose;
  final int dailyCount;
  final List<TimeOfDay> times;
  final DateTime startDate;
  final DateTime? endDate;

  Medicine({
    required this.name,
    required this.dose,
    required this.dailyCount,
    required this.times,
    required this.startDate,
    this.endDate,
  });

  // Static list to persist data during the app session
  static List<Medicine> savedMedicines = [];
}
