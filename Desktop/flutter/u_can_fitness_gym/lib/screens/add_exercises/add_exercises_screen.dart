import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/screens/my_records/my_records_screen.dart';
import 'package:u_can_fitness_gym/shared/configurations/app_localizations_config.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/shared/settings/app.setting.dart';
import 'package:u_can_fitness_gym/size_config.dart';
import 'components/body.dart';

class AddExercisesScreen extends StatefulWidget {
  static String routeName = '/add-exercises';

  @override
  _AddExercisesScreenState createState() => _AddExercisesScreenState();
}

class _AddExercisesScreenState extends State<AddExercisesScreen> {
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppLocalizationsConfig().init(context);
    AppSetting().init(context);
    late final ExercisesModel params =
        ModalRoute.of(context)?.settings.arguments as ExercisesModel;
    final app = Provider.of<AppSetting>(context);
    app.selectedExercise = params;
    return Scaffold(
      backgroundColor: kPrimaryColor,
      appBar: AppBar(
        backgroundColor: kSecondaryColor,
        // automaticallyImplyLeading: false,
        // title: Text(AppLocalizations.of(context)!.exercises),
        actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
      ),
      body: Body(),
      floatingActionButton: FloatingActionButton(
        onPressed: () =>
            Navigator.pushNamed(context, MyRecordsScreen.routeName),
        child: const Icon(
          Icons.add,
          color: Colors.white,
        ),
        backgroundColor: Colors.purple,
      ),
    );
  }
}
