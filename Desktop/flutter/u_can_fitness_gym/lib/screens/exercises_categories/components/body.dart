import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/screens/exercises_subcategories/exercises_subcategories_screen.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/enum/screens.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  List<ExercisesModel> list = [
    new ExercisesModel(id: 0, title: 'صدر علوي'),
  ];
  @override
  Widget build(BuildContext context) {
    final ExercisesModel params =
        ModalRoute.of(context)?.settings.arguments as ExercisesModel;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          flexibleSpace: FlexibleSpaceBar(
            title: Container(
              height: 40,
              margin: EdgeInsets.symmetric(horizontal: 10),
              child: TextField(
                decoration: InputDecoration(
                  border: OutlineInputBorder(),
                  fillColor: Colors.white24,
                  labelText: Screens.categories,
                  labelStyle: TextStyle(color: kPrimaryLightColor),
                  suffixIcon: Icon(Icons.search),
                ),
                style: TextStyle(color: kPrimaryLightColor),
                onChanged: (value) {
                  if (value.length > 0) {
                    Data.exercisesCategorieslist = list
                        .where((element) => element.title!
                            .startsWith(value.trim().toLowerCase()))
                        .toList();
                  }
                },
              ),
            ),
          ),
          expandedHeight: 150,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return Padding(
                padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                child: InkWell(
                  onTap: () => Navigator.pushNamed(
                    context,
                    ExercisesSubcategoriesScreen.routeName,
                    arguments: ExercisesModel(
                        id: Data.exercisesCategorieslist[index].id,
                        title: Data.exercisesCategorieslist[index].title),
                  ),
                  child: Container(
                    height: SizeConfig.orientation == Orientation.portrait
                        ? getProportionateScreenHeight(120.0)
                        : getProportionateScreenHeight(130.0 * 2),
                    padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                    decoration: BoxDecoration(
                      border: Border(
                        bottom: BorderSide(width: 1.0, color: kDefaultColor),
                      ),
                    ),
                    width: SizeConfig.screenWidth,
                    child: Flex(
                      direction: Axis.vertical,
                      mainAxisAlignment: MainAxisAlignment.center,
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Row(
                          children: [
                            Container(
                              child: ClipRRect(
                                borderRadius: BorderRadius.circular(30),
                                child: FittedBox(
                                  fit: BoxFit.fill,
                                  child: Image.asset(
                                    'assets/images/chest.png',
                                    width: 80,
                                    height: 80,
                                  ),
                                ),
                              ),
                            ),
                            Container(
                              margin: EdgeInsets.symmetric(
                                  horizontal: getProportionateScreenHeight(10)),
                              child: Text(
                                Data.exercisesCategorieslist[index].title ?? "",
                                style: TextStyle(
                                    fontSize: 25, fontWeight: FontWeight.bold),
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),
                  ),
                ),
              );
            },
            childCount: Data.exercisesCategorieslist.length, // 1000 list items
          ),
        ),
      ],
    );
  }
}
