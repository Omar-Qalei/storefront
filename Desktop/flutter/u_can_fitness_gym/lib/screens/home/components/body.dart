import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/screens/exercises/exercises_screen.dart';
import 'package:u_can_fitness_gym/shared/enum/screens.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  @override
  Widget build(BuildContext context) {
    return SingleChildScrollView(
      scrollDirection: Axis.vertical,
      child: Flex(
        direction: Axis.vertical,
        children: [
          InkWell(
            onTap: () =>
                Navigator.pushNamed(context, ExercisesScreen.routeName),
            child: Container(
              height: 100,
              width: SizeConfig.screenWidth,
              child: Center(
                child: Text(
                  Screens.exercises,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[800]?.withOpacity(0.8),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("Container clicked");
            },
            child: Container(
              height: 100,
              width: SizeConfig.screenWidth,
              child: Center(
                child: Text(
                  Screens.feed,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[800]?.withOpacity(0.8),
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
            ),
          ),
          InkWell(
            onTap: () {
              print("Container clicked");
            },
            child: Container(
              height: 100,
              width: SizeConfig.screenWidth,
              child: Center(
                child: Text(
                  Screens.supplements,
                  style: TextStyle(fontSize: 20),
                ),
              ),
              decoration: BoxDecoration(
                color: Colors.grey[800]?.withOpacity(0.8),
                border: Border(
                  top: BorderSide(width: 1, color: Colors.black12),
                ),
              ),
            ),
          ),
          SingleChildScrollView(
            scrollDirection: Axis.horizontal,
            child: Row(
              children: [
                InkWell(
                  onTap: () {
                    print("Container clicked");
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.blueGrey[600]?.withOpacity(0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("Container clicked");
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.blueGrey[600]?.withOpacity(0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[],
                      ),
                    ),
                  ),
                ),
                InkWell(
                  onTap: () {
                    print("Container clicked");
                  },
                  child: Container(
                    width: 180,
                    height: 180,
                    child: Card(
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(10.0),
                      ),
                      color: Colors.blueGrey[600]?.withOpacity(0.8),
                      elevation: 10,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: <Widget>[],
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          Row(
            children: [
              InkWell(
                onTap: () {
                  print("Container clicked");
                },
                child: Container(
                  width: SizeConfig.screenWidth / 3,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[800]?.withOpacity(0.8),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Center(
                      child: Text(
                    Screens.contactCoach,
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
              InkWell(
                onTap: () {
                  print("Container clicked");
                },
                child: Container(
                  width: SizeConfig.screenWidth / 3,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[800]?.withOpacity(0.8),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Center(
                      child: Text(
                    Screens.contactDietitian,
                    style: TextStyle(
                      fontSize: 15,
                    ),
                  )),
                ),
              ),
              InkWell(
                onTap: () {
                  print("Container clicked");
                },
                child: Container(
                  width: SizeConfig.screenWidth / 3,
                  height: 130,
                  decoration: BoxDecoration(
                    color: Colors.grey[800]?.withOpacity(0.8),
                    border: Border.all(width: 1, color: Colors.black12),
                  ),
                  child: Center(
                      child: Text(
                    Screens.suggestionsComplaints,
                    style: TextStyle(fontSize: 15),
                  )),
                ),
              ),
            ],
          ),
          Row(children: [
            InkWell(
              onTap: () {
                print("Container clicked");
              },
              child: Container(
                width: SizeConfig.screenWidth / 2,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[800]?.withOpacity(0.8),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Center(
                    child: Text(
                  Screens.faq,
                  style: TextStyle(fontSize: 15),
                )),
              ),
            ),
            InkWell(
              onTap: () {
                print("Container clicked");
              },
              child: Container(
                width: SizeConfig.screenWidth / 2,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[800]?.withOpacity(0.8),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Center(
                    child: Text(
                  Screens.myRecords,
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )),
              ),
            ),
          ]),
          Row(children: [
            InkWell(
              onTap: () {
                print("Container clicked");
              },
              child: Container(
                width: SizeConfig.screenWidth / 2,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[800]?.withOpacity(0.8),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Center(
                    child: Text(
                  Screens.exerciseClassDates,
                  style: TextStyle(fontSize: 15),
                )),
              ),
            ),
            InkWell(
              // splashColor: Theme.of(context).errorColor,
              onTap: () {
                // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
                //   content: Text('Tap'),
                // ));
              },
              child: Container(
                width: SizeConfig.screenWidth / 2,
                height: 70,
                decoration: BoxDecoration(
                  color: Colors.grey[800]?.withOpacity(0.8),
                  border: Border.all(width: 1, color: Colors.black12),
                ),
                child: Center(
                    child: Text(
                  'QR',
                  style: TextStyle(
                    fontSize: 15,
                  ),
                )),
              ),
            ),
          ]),
        ],
      ),
    );
  }
}
