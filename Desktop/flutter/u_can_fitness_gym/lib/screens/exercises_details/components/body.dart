import 'dart:io';

import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/screens/exercises_subcategories/exercises_subcategories_screen.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/enum/exercises.dart';
import 'package:u_can_fitness_gym/shared/enum/generals.dart';
import 'package:u_can_fitness_gym/shared/enum/screens.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/shared/settings/app.setting.dart';
import 'package:u_can_fitness_gym/size_config.dart';
// import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
// import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
// import 'package:flutter_youtube/flutter_youtube.dart';
import 'header.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  DateTime selectedDate = DateTime.now();
  @override
  void initState() {
    super.initState();
  }

  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _controller.value.playerState;
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }
  //
  _selectDate(BuildContext context) async {
    final DateTime? picked = await showDatePicker(
      context: context,
      initialDate: selectedDate, // Refer step 1
      firstDate: DateTime(2000),
      lastDate: DateTime(2025),
      confirmText: Generals.done,
      cancelText: Generals.cancel,
    );
    if (picked != null && picked != selectedDate)
      setState(() {
        selectedDate = picked;
      });
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppSetting>(context);
    final String exerciseTitle = (app.selectedExercise.title)!;

    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverAppBar(
            backgroundColor: kSecondaryColor,
            flexibleSpace: FlexibleSpaceBar(
              title: Text(
                exerciseTitle,
                style: TextStyle(fontFamily: kFontFamily),
              ),
              // centerTitle: true,
            ),
            expandedHeight: 120,
          ),
          SliverFillRemaining(
            fillOverscroll: true,
            hasScrollBody: true,
            child: SingleChildScrollView(
              scrollDirection: Axis.vertical,
              child: Row(
                children: [
                  Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Header(),
                      // TextButton(
                      //   child: Text(
                      //     'Youtube',
                      //     style: TextStyle(color: kDefaultColor),
                      //   ),
                      //   onPressed: () => showDialog(
                      //     context: context,
                      //     builder: (context) => AlertDialog(
                      //       content:
                      //     ),
                      //   ),
                      // ),
                      // SizedBox(
                      //   width: SizeConfig.screenWidth,
                      //   child: YoutubePlayerIFrame(
                      //     controller: _controller,
                      //     aspectRatio: 16 / 9,
                      //   ),
                      // ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${ExercisesEnum.groups}: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Text(
                            '3',
                            style: TextStyle(fontSize: 20),
                          ),
                        ],
                      ),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.start,
                        children: [
                          Text(
                            '${ExercisesEnum.duplicates}: ',
                            style: TextStyle(fontSize: 20),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '12',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '10',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                          Container(
                            margin: EdgeInsets.symmetric(horizontal: 5),
                            child: Text(
                              '8',
                              style: TextStyle(fontSize: 20),
                            ),
                          ),
                        ],
                      ),
                      Container(
                        width: SizeConfig.screenWidth,
                        margin: EdgeInsets.symmetric(vertical: 10),
                        padding: EdgeInsets.symmetric(vertical: 10),
                        decoration: BoxDecoration(
                          border: Border.symmetric(
                            horizontal:
                                BorderSide(color: kDefaultColor, width: 1),
                          ),
                        ),
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.start,
                          children: [
                            Center(
                              child: InkWell(
                                onTap: () => _selectDate(context),
                                child: Text(
                                  "${selectedDate.toLocal()}".split(' ')[0],
                                  style: TextStyle(
                                      fontSize: 20,
                                      fontWeight: FontWeight.bold),
                                ),
                              ),
                            ),
                            Row(
                              children: [
                                // Column(
                                //   crossAxisAlignment: CrossAxisAlignment.start,
                                //   children: [
                                //     Text(
                                //       '${ExercisesEnum.duplicates}: ',
                                //       style: TextStyle(fontSize: 20),
                                //     ),
                                //     Text(
                                //       '${ExercisesEnum.weight}: ',
                                //       style: TextStyle(fontSize: 20),
                                //     ),
                                //   ],
                                // ),
                                Column(
                                  crossAxisAlignment: CrossAxisAlignment.start,
                                  children: [
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {setState(() {})},
                                        maxLength: 2,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: ExercisesEnum.duplicates,
                                        ),
                                        onSaved: (String? value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                        },
                                        validator: (String? value) {
                                          return (value != null &&
                                                  value.contains('@'))
                                              ? 'Do not use the @ char.'
                                              : null;
                                        },
                                      ),
                                    ),
                                    SizedBox(
                                      width: 100,
                                      child: TextFormField(
                                        keyboardType: TextInputType.number,
                                        onChanged: (value) => {setState(() {})},
                                        maxLength: 2,
                                        decoration: InputDecoration(
                                          border: OutlineInputBorder(),
                                          labelText: ExercisesEnum.weight,
                                        ),
                                        onSaved: (String? value) {
                                          // This optional block of code can be used to run
                                          // code when the user saves the form.
                                        },
                                        validator: (String? value) {
                                          return (value != null &&
                                                  value.contains('@'))
                                              ? 'Do not use the @ char.'
                                              : null;
                                        },
                                      ),
                                    ),
                                  ],
                                ),
                              ],
                            ),
                          ],
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            ),
          ),
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
