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
  @override
  Widget build(BuildContext context) {
    final ExercisesModel params =
        ModalRoute.of(context)?.settings.arguments as ExercisesModel;
    return CustomScrollView(
      slivers: [
        SliverAppBar(
          backgroundColor: kSecondaryColor,
          flexibleSpace: FlexibleSpaceBar(
            title: Text(params.title ?? ""),
            // centerTitle: true,
          ),
          expandedHeight: 120,
        ),
        SliverList(
          delegate: SliverChildBuilderDelegate(
            (BuildContext context, int index) {
              return InkWell(
                onTap: () => Navigator.pushNamed(
                  context,
                  ExercisesSubcategoriesScreen.routeName,
                  arguments: ExercisesModel(
                      id: Data.exercisesCategorieslist[index].id,
                      title: Data.exercisesCategorieslist[index].title),
                ),
                child: Container(
                  color: Colors.grey[800]?.withOpacity(0.8),
                  height: SizeConfig.orientation == Orientation.portrait
                      ? getProportionateScreenHeight(80.0)
                      : getProportionateScreenHeight(80.0 * 2),
                  padding: EdgeInsets.all(getProportionateScreenWidth(10.0)),
                  width: SizeConfig.screenWidth,
                  child: Flex(
                    direction: Axis.vertical,
                    mainAxisAlignment: MainAxisAlignment.center,
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Text(
                        Data.exercisesCategorieslist[index].title ?? "",
                        style: TextStyle(fontSize: 20),
                      ),
                    ],
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
