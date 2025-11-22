import 'package:flutter/material.dart';

class HabitModel {
  final String id;
  final String name;
  final String description;
  final int colorValue;
  final String frequency;
  final List<String> completedDates;
  final bool isCompleted;

  HabitModel({
    required this.id,
    required this.name,
    required this.description,
    required this.colorValue,
    required this.frequency,
    required this.completedDates,
    this.isCompleted = false,
  });

  Color get color => Color(colorValue);

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'name': name,
      'description': description,
      'colorValue': colorValue,
      'frequency': frequency,
      'completedDates': completedDates,
      'isCompleted': isCompleted,
    };
  }

  factory HabitModel.fromJson(Map<String, dynamic> json) {
    return HabitModel(
      id: json['id'] ?? '',
      name: json['name'] ?? '',
      description: json['description'] ?? '',
      colorValue: json['colorValue'] ?? 0xFF6C63FF,
      frequency: json['frequency'] ?? 'Daily',
      completedDates: List<String>.from(json['completedDates'] ?? []),
      isCompleted: json['isCompleted'] ?? false,
    );
  }

  HabitModel copyWith({
    String? id,
    String? name,
    String? description,
    int? colorValue,
    String? frequency,
    List<String>? completedDates,
    bool? isCompleted,
  }) {
    return HabitModel(
      id: id ?? this.id,
      name: name ?? this.name,
      description: description ?? this.description,
      colorValue: colorValue ?? this.colorValue,
      frequency: frequency ?? this.frequency,
      completedDates: completedDates ?? this.completedDates,
      isCompleted: isCompleted ?? this.isCompleted,
    );
  }
}
