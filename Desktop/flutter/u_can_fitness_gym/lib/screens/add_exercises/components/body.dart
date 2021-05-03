import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/shared/settings/page_view.setting.dart';

import 'listview_days.dart';
import 'listview_exercises.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: PageView(
        controller: PageViewSettings.controller,
        children: [
          ListView_Days(),
          ListView_Exercises(),
        ],
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    // await _videoViewController.dispose();
  }
}
