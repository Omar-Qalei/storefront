import 'package:flutter/material.dart';
import 'package:flutter_speed_dial/flutter_speed_dial.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/screens/add_exercises/add_exercises_screen.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/enum/exercises.dart';
import 'package:u_can_fitness_gym/shared/enum/generals.dart';
import 'package:u_can_fitness_gym/shared/enum/screens.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class FloatButton extends StatefulWidget {
  const FloatButton({
    Key? key,
    required this.exerciseId,
    required this.exerciseTitle,
  }) : super(key: key);

  final int exerciseId;
  final String exerciseTitle;

  @override
  _FloatButtonState createState() => _FloatButtonState();
}

class _FloatButtonState extends State<FloatButton> {
  Future getProjectDetails() async {
    List<AddExercisesModel> projetcList = await Data.exercise;
    // projetcList.length = projetcList.length - 1;
    return projetcList.length;
  }

  @override
  Widget build(BuildContext context) {
    return SpeedDial(
      /// both default to 16
      marginEnd: 18,
      marginBottom: 20,
      // animatedIcon: AnimatedIcons.menu_close,
      // animatedIconTheme: IconThemeData(size: 22.0),
      /// This is ignored if animatedIcon is non null
      icon: Icons.add,
      activeIcon: Icons.remove,
      // iconTheme: IconThemeData(color: Colors.grey[50], size: 30),
      /// The label of the main button.
      // label: Text("Open Speed Dial"),
      /// The active label of the main button, Defaults to label if not specified.
      // activeLabel: Text("Close Speed Dial"),
      /// Transition Builder between label and activeLabel, defaults to FadeTransition.
      // labelTransitionBuilder: (widget, animation) => ScaleTransition(scale: animation,child: widget),
      /// The below button size defaults to 56 itself, its the FAB size + It also affects relative padding and other elements
      buttonSize: 56.0,
      visible: true,

      /// If true user is forced to close dial manually
      /// by tapping main button and overlay is not rendered.
      closeManually: false,

      /// If true overlay will render no matter what.
      renderOverlay: false,
      curve: Curves.bounceIn,
      overlayColor: Colors.black,
      overlayOpacity: 0.5,
      onOpen: () => print('OPENING DIAL'),
      onClose: () => print('DIAL CLOSED'),
      tooltip: 'Speed Dial',
      heroTag: 'speed-dial-hero-tag',
      backgroundColor: kSecondaryColor,
      foregroundColor: Colors.white,
      elevation: 8.0,
      shape: CircleBorder(),
      // orientation: SpeedDialOrientation.Up,
      // childMarginBottom: 2,
      // childMarginTop: 2,
      children: [
        SpeedDialChild(
          child: Icon(Icons.add),
          backgroundColor: Colors.blue,
          label: 'Add Exercises',
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
          onTap: () => Navigator.pushNamed(
            context,
            AddExercisesScreen.routeName,
            arguments: ExercisesModel(
                id: widget.exerciseId, title: widget.exerciseTitle),
          ),
          onLongPress: () => print('FIRST CHILD LONG PRESS'),
        ),
        SpeedDialChild(
          child: Icon(Icons.history),
          backgroundColor: Colors.orange[200],
          label: Screens.myRecords,
          labelStyle: TextStyle(fontSize: 18.0, color: Colors.black),
          onTap: () => showDialog(
            context: context,
            builder: (BuildContext context) => AlertDialog(
              title: Text(Screens.myRecords),
              content: FutureBuilder(
                  future: getProjectDetails(),
                  builder: (context, snapshot) {
                    // if (snapshot.connectionState ==
                    //     ConnectionState.done) {
                    if (Data.exercise[widget.exerciseId].exercises!.length - 1 >
                        0) {
                      return SingleChildScrollView(
                        scrollDirection: Axis.horizontal,
                        child: DataTable(columns: <DataColumn>[
                          DataColumn(
                            label: Text(
                              ExercisesEnum.duplicates,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              ExercisesEnum.weight,
                              style: TextStyle(fontStyle: FontStyle.italic),
                            ),
                          ),
                          DataColumn(
                            label: Text(
                              "",
                            ),
                          ),
                        ], rows: <DataRow>[
                          ...List.generate(
                            Data.exercise[widget.exerciseId].exercises!.length -
                                1,
                            (index) => DataRow(
                              cells: <DataCell>[
                                DataCell(Text(Data.exercise[widget.exerciseId]
                                        .exercises?[index].duplicates
                                        .toString() ??
                                    "0")),
                                DataCell(Row(
                                  children: [
                                    Text('kg'),
                                    Text(Data.exercise[widget.exerciseId]
                                            .exercises?[index].weight
                                            .toString() ??
                                        "0"),
                                  ],
                                )),
                                DataCell(
                                  IconButton(
                                    icon: Icon(Icons.edit),
                                    color: Colors.blue,
                                    onPressed: () => showDialog(
                                        context: context,
                                        builder: (context) => AlertDialog(
                                              title: Text(ExercisesEnum.weight),
                                              content: Container(
                                                margin: EdgeInsets.symmetric(
                                                    horizontal: 5),
                                                width:
                                                    getProportionateScreenWidth(
                                                        110),
                                                child: TextFormField(
                                                  keyboardType:
                                                      TextInputType.number,
                                                  onChanged: (value) => {
                                                    setState(() {
                                                      Data
                                                              .exercise[widget
                                                                  .exerciseId]
                                                              .exercises?[index]
                                                              .weight =
                                                          double.tryParse(
                                                              value);
                                                    })
                                                  },
                                                  maxLength: 2,
                                                  decoration: InputDecoration(
                                                    border:
                                                        OutlineInputBorder(),
                                                    labelText: ExercisesEnum
                                                        .duplicates,
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
                                              actions: [
                                                TextButton(
                                                  child: Text(
                                                    Generals.done,
                                                    style: TextStyle(
                                                        color: Colors.blue),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                                TextButton(
                                                  child: Text(
                                                    Generals.cancel,
                                                    style: TextStyle(
                                                        color: Colors.red),
                                                  ),
                                                  onPressed: () =>
                                                      Navigator.pop(context),
                                                ),
                                              ],
                                            )),
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ]),
                      );
                    } else {
                      return Container(
                        height: 100,
                        child: Center(
                          child: Text(
                            ExercisesEnum.noRecords,
                            style:
                                TextStyle(fontSize: 20, color: kDefaultColor),
                          ),
                        ),
                      );
                    }
                  }),
            ),
          ),
          onLongPress: () => print('SECOND CHILD LONG PRESS'),
        ),
      ],
    );
  }
}
