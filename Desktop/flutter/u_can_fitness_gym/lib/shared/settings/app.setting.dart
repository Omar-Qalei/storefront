import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';

class AppSetting with ChangeNotifier {
  static late var provider;
  late ExercisesModel selectedExercise;
  void init(BuildContext context) {
    provider = Provider.of<AppSetting>(context);
  }

  String formatDate(DateTime date) {
    var str = date.toString().split(' ')[0];
    var arr = str.split('-');
    // arr = arr.split('-');
    var year = arr[0];
    var month = arr[1];
    var day = arr[2];
    return "$year-$month-$day";
  }
}
