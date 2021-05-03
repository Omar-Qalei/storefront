import 'package:flutter/material.dart';

class ExercisesModel {
  final int? id;
  final String? title;
  ExercisesModel({
    @required this.id,
    @required this.title,
  });
}

class AddExercisesModel {
  final int? id;
  String? title;
  final DateTime? date;
  final List<Exercises>? exercises;
  AddExercisesModel(
      {@required this.id,
      @required this.title,
      @required this.date,
      @required this.exercises});
}

class Exercises {
  int? duplicates;
  int? groups;
  double? weight;
  Exercises({duplicates: 0, groups: 0, weight: 0.0});
}
