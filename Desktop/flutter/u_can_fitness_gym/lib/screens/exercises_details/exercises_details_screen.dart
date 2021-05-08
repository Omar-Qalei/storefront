import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/shared/configurations/app_localizations_config.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/shared/settings/app.setting.dart';
import 'package:u_can_fitness_gym/size_config.dart';
import 'components/body.dart';
import 'components/float_button.dart';

class ExercisesDetailsScreen extends StatefulWidget {
  static String routeName = '/exercises-details';

  @override
  _ExercisesDetailsScreenState createState() => _ExercisesDetailsScreenState();
}

class _ExercisesDetailsScreenState extends State<ExercisesDetailsScreen> {
  static const TextStyle optionStyle =
      TextStyle(fontSize: 30, fontWeight: FontWeight.bold);

  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppLocalizationsConfig().init(context);
    final app = Provider.of<AppSetting>(context);
    final ExercisesModel params =
        ModalRoute.of(context)?.settings.arguments as ExercisesModel;
    app.selectedExercise =
        new ExercisesModel(id: params.id, title: params.title);
    final int exerciseId = (app.selectedExercise.id)!;
    final String exerciseTitle = (app.selectedExercise.title)!;

    return Scaffold(
      resizeToAvoidBottomInset: true,
      body: Body(),
      floatingActionButton:
          FloatButton(exerciseId: exerciseId, exerciseTitle: exerciseTitle),
    );
  }
}
