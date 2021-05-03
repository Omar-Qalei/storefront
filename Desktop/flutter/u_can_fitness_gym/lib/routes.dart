import 'package:flutter/material.dart';
import 'screens/add_exercises/add_exercises_screen.dart';
import 'screens/exercises/exercises_screen.dart';
import 'screens/exercises_categories/exercises_categories_screen.dart';
import 'screens/exercises_details/exercises_details_screen.dart';
import 'screens/exercises_subcategories/exercises_subcategories_screen.dart';
import 'screens/home/home_screen.dart';
import 'screens/introduction/startup_screen.dart';
import 'screens/my_records/my_records_screen.dart';

final Map<String, WidgetBuilder> routes = {
  StartupScreen.routeName: (context) => StartupScreen(),
  HomeScreen.routeName: (context) => HomeScreen(),
  ExercisesScreen.routeName: (context) => ExercisesScreen(),
  ExercisesCategoriesScreen.routeName: (context) => ExercisesCategoriesScreen(),
  ExercisesSubcategoriesScreen.routeName: (context) =>
      ExercisesSubcategoriesScreen(),
  ExercisesDetailsScreen.routeName: (context) => ExercisesDetailsScreen(),
  AddExercisesScreen.routeName: (context) => AddExercisesScreen(),
  MyRecordsScreen.routeName: (context) => MyRecordsScreen(),
};
