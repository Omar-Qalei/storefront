import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/size_config.dart';

import 'components/body.dart';

class StartupScreen extends StatelessWidget {
  static String routeName = '/introducation';
  @override
  Widget build(BuildContext context) {
    SizeConfig().init(context);
    return Scaffold(
      backgroundColor: kPrimaryColor,
      body: Body(),
    );
  }
}
