import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/shared/configurations/app_localizations_config.dart';
import 'package:u_can_fitness_gym/size_config.dart';
import 'components/body.dart';

class ExercisesScreen extends StatelessWidget {
  static String routeName = '/exercises';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    AppLocalizationsConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      // appBar: AppBar(
      //   backgroundColor: kSecondaryColor,
      //   automaticallyImplyLeading: false,
      //   title: Text(AppLocalizations.of(context)!.exercises),
      //   actions: [IconButton(icon: Icon(Icons.settings), onPressed: () {})],
      // ),
      body: Body(),
    );
  }
}
