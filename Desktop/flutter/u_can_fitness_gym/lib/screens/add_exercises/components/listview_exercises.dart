import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/enum/exercises.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/shared/settings/app.setting.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class ListView_Exercises extends StatefulWidget {
  const ListView_Exercises({Key? key}) : super(key: key);

  @override
  _ListView_ExercisesState createState() => _ListView_ExercisesState();
}

class _ListView_ExercisesState extends State<ListView_Exercises> {
  late ScrollController _controller;
  late int exerciseId = 0;
  @override
  initState() {
    _controller = new ScrollController();
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final app = Provider.of<AppSetting>(context);
    exerciseId = (app.selectedExercise.id)!;
    Data.exercise[exerciseId].title = (app.selectedExercise.title)!;
    print(Data.exercise[exerciseId].exercises!.length);
    return Padding(
      padding: const EdgeInsets.symmetric(horizontal: 1.0, vertical: 8.0),
      child: ListView.separated(
          controller: _controller,
          itemCount: Data.exercise[exerciseId].exercises!.length,
          separatorBuilder: (BuildContext context, int index) {
            return Align(
              alignment: Alignment.centerRight,
              child: Container(
                height: 1,
                width: MediaQuery.of(context).size.width / 1.3,
                child: Divider(),
              ),
            );
          },
          itemBuilder: (BuildContext context, index) {
            return Padding(
              padding: const EdgeInsets.all(8.0),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: [
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: getProportionateScreenWidth(110),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) => {
                            setState(() {
                              Data.exercise[exerciseId].exercises?[index]
                                  .duplicates = int.tryParse(value);
                            })
                          },
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
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                        ),
                      ),
                      Container(
                        margin: EdgeInsets.symmetric(horizontal: 5),
                        width: getProportionateScreenWidth(110),
                        child: TextFormField(
                          keyboardType: TextInputType.number,
                          onChanged: (value) => {
                            setState(() {
                              Data.exercise[exerciseId].exercises?[index]
                                  .duplicates = int.tryParse(value);
                            })
                          },
                          maxLength: 2,
                          decoration: InputDecoration(
                            border: OutlineInputBorder(),
                            labelText: ExercisesEnum.groups,
                          ),
                          onSaved: (String? value) {
                            // This optional block of code can be used to run
                            // code when the user saves the form.
                          },
                          validator: (String? value) {
                            return (value != null && value.contains('@'))
                                ? 'Do not use the @ char.'
                                : null;
                          },
                          onTap: () {
                            if (Data.exercise[exerciseId].exercises?.length ==
                                index + 1) {
                              addExercises();
                              Future.delayed(Duration(milliseconds: 100), () {
                                _controller.animateTo(_controller.offset + 200,
                                    curve: Curves.easeOut,
                                    duration: Duration(seconds: 1));
                              });
                            }
                          },
                        ),
                      ),
                    ],
                  ),
                ],
              ),
            );
          }),
    );
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void addExercises() {
    setState(() {
      Data.exercise[exerciseId].exercises!
          .add(new Exercises(duplicates: 0, groups: 0, weight: 0.0));
    });
  }
}
