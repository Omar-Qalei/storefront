import 'package:u_can_fitness_gym/shared/enum/generals.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';

class Data {
  static List<ExercisesModel> exerciseslist = [
    new ExercisesModel(id: 0, title: 'صدر'),
  ];
  static List<ExercisesModel> exercisesCategorieslist = [
    new ExercisesModel(id: 0, title: 'صدر علوي'),
  ];
  static List<ExercisesModel> exercisesSubcategorieslist = [
    new ExercisesModel(id: 0, title: 'صدر علوي دامبلز'),
  ];
  static List<ExercisesModel> days = [
    new ExercisesModel(id: 0, title: Generals.saturday),
    new ExercisesModel(id: 1, title: Generals.sunday),
    new ExercisesModel(id: 2, title: Generals.monday),
    new ExercisesModel(id: 3, title: Generals.tuesday),
    new ExercisesModel(id: 4, title: Generals.wednesday),
    new ExercisesModel(id: 5, title: Generals.thursday),
    new ExercisesModel(id: 6, title: Generals.friday),
  ];
  static List<AddExercisesModel> exercise = [
    new AddExercisesModel(
        id: 0,
        title: '',
        exercises: [new Exercises(duplicates: 0, groups: 0, weight: 0.0)],
        date: new DateTime.now()),
  ];
}
