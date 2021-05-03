import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:u_can_fitness_gym/screens/exercises_details/exercises_details_screen.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/enum/dialogs.dart';
import 'package:u_can_fitness_gym/shared/enum/generals.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/shared/settings/app.setting.dart';
import 'package:u_can_fitness_gym/size_config.dart';
// import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';
// import 'package:flutter_youtube/flutter_youtube.dart';
import 'header.dart';

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
    final app = Provider.of<AppSetting>(context);
    return SafeArea(
      child: CustomScrollView(
        slivers: [
          SliverPersistentHeader(
              // backgroundColor: kSecondaryColor,
              // flexibleSpace: FlexibleSpaceBar(
              //   title: Text(params.title ?? ""),
              //   // centerTitle: true,
              // ),
              // expandedHeight: 120,
              floating: true,
              pinned: false,
              delegate: Header(minExtent: 150, maxExtent: 250)),
          SliverFillRemaining(
            fillOverscroll: true,
            child: SingleChildScrollView(
              child: Column(
                children: [
                  ...List.generate(
                    Data.exercise.length,
                    (exerciseId) => Column(
                      children: [
                        Container(
                          margin: EdgeInsets.symmetric(vertical: 10),
                          child: Row(
                            children: [
                              Text(
                                app.formatDate(
                                    (Data.exercise[exerciseId].date)!),
                                style: TextStyle(fontSize: 17),
                              ),
                              Container(
                                margin: EdgeInsets.symmetric(horizontal: 10),
                                child: Text(
                                  Data.exercise[exerciseId].title ?? "",
                                  style: TextStyle(fontSize: 17),
                                ),
                              ),
                              Spacer(),
                              IconButton(
                                  icon: Icon(Icons.remove_red_eye),
                                  color: Colors.grey,
                                  onPressed: () => Navigator.pushNamed(
                                        context,
                                        ExercisesDetailsScreen.routeName,
                                        arguments: ExercisesModel(
                                            id: Data
                                                .exercisesSubcategorieslist[
                                                    exerciseId]
                                                .id,
                                            title: Data
                                                .exercisesSubcategorieslist[
                                                    exerciseId]
                                                .title),
                                      )),
                            ],
                          ),
                        ),
                        SingleChildScrollView(
                          scrollDirection: Axis.horizontal,
                          child: DataTable(columns: <DataColumn>[
                            DataColumn(
                              label: Text(
                                Dialogs.duplicates,
                                style: TextStyle(fontStyle: FontStyle.italic),
                              ),
                            ),
                            DataColumn(
                              label: Text(
                                Dialogs.weight,
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
                              Data.exercise[exerciseId].exercises!.length - 1,
                              (index) => DataRow(
                                cells: <DataCell>[
                                  DataCell(Text(Data.exercise[exerciseId]
                                          .exercises?[index].duplicates
                                          .toString() ??
                                      "0")),
                                  DataCell(Row(
                                    children: [
                                      Text('kg'),
                                      Text(Data.exercise[exerciseId]
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
                                                title: Text(Dialogs.weight),
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
                                                                .exercise[
                                                                    exerciseId]
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
                                                      labelText:
                                                          Dialogs.duplicates,
                                                    ),
                                                    onSaved: (String? value) {
                                                      // This optional block of code can be used to run
                                                      // code when the user saves the form.
                                                    },
                                                    validator: (String? value) {
                                                      return (value != null &&
                                                              value.contains(
                                                                  '@'))
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
                        ),
                      ],
                    ),
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
  }
}
