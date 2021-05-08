import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/screens/exercises/exercises_screen.dart';
import 'package:u_can_fitness_gym/screens/my_records/my_records_screen.dart';
import 'package:u_can_fitness_gym/shared/enum/screens.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> {
  int currentPage = 0;
  @override
  Widget build(BuildContext context) {
    return Container(
      child: SingleChildScrollView(
        scrollDirection: Axis.vertical,
        child: Flex(
          direction: Axis.vertical,
          children: [
            Container(
              padding: EdgeInsets.symmetric(horizontal: 10, vertical: 5),
              width: SizeConfig.screenWidth,
              height: SizeConfig.orientation == Orientation.landscape
                  ? getProportionateScreenHeight(600)
                  : getProportionateScreenHeight(250),
              child: Column(
                children: [
                  Expanded(
                    flex: 30,
                    child: PageView(
                      onPageChanged: (value) => {
                        setState(() {
                          currentPage = value;
                        })
                      },
                      children: [
                        InkWell(
                          onTap: () {
                            print("Container clicked");
                          },
                          child: Container(
                            width: SizeConfig.screenWidth,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(10),
                            ),
                            height: 230,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    'https://sharnyandjulius.com/wp-content/uploads/2015/10/21-good-questions-about-fitness-and-weight-loss-answered.jpg'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("Container clicked");
                          },
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: 230,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    'https://i.ytimg.com/vi/dUTozU_B8RU/maxresdefault.jpg'),
                              ),
                            ),
                          ),
                        ),
                        InkWell(
                          onTap: () {
                            print("Container clicked");
                          },
                          child: Container(
                            width: SizeConfig.screenWidth,
                            height: 230,
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(5),
                              child: FittedBox(
                                fit: BoxFit.fill,
                                child: Image.network(
                                    'https://www.fitfatherproject.com/wp-content/uploads/2019/01/PopWorkoutPlans.png'),
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                  Spacer(
                    flex: 2,
                  ),
                  Expanded(
                    flex: 1,
                    child: Column(
                      children: <Widget>[
                        Row(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: List.generate(
                            3,
                            (index) => buildDot(index: index),
                          ),
                        ),
                      ],
                    ),
                  )
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, ExercisesScreen.routeName),
                    child: Container(
                      height: 100,
                      width: SizeConfig.screenWidth / 3,
                      child: Center(
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.network(
                                'https://png.pngtree.com/png-vector/20190115/ourlarge/pngtree-vector-exercise-icon-png-image_319652.jpg',
                                width: 100,
                                height: 65,
                              ),
                            ),
                            Text(
                              Screens.exercises,
                              style: TextStyle(
                                  fontSize: 20, color: kPrimaryDarkColor),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("Container clicked");
                    },
                    child: Container(
                      height: 100,
                      width: SizeConfig.screenWidth / 3,
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://png.pngtree.com/png-clipart/20190603/original/pngtree-healthy-food-tray-icon-png-image_268676.jpg',
                              width: 100,
                              height: 65,
                            ),
                          ),
                          Text(
                            Screens.feed,
                            style: TextStyle(
                                fontSize: 20, color: kPrimaryDarkColor),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, ExercisesScreen.routeName),
                    child: Container(
                      height: 100,
                      width: SizeConfig.screenWidth / 3,
                      child: Center(
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.network(
                                'https://png.pngtree.com/png-clipart/20190630/original/pngtree-vector-supplements-icon-png-image_4155866.jpg',
                                width: 100,
                                height: 65,
                              ),
                            ),
                            Text(
                              Screens.supplements,
                              style: TextStyle(
                                  fontSize: 20, color: kPrimaryDarkColor),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("Container clicked");
                    },
                    child: Container(
                      height: 100,
                      width: SizeConfig.screenWidth / 3,
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://e7.pngegg.com/pngimages/938/194/png-clipart-time-clock-computer-icons-simple-english-wikipedia-clock-wikimedia-commons-time.png',
                              width: 100,
                              height: 65,
                            ),
                          ),
                          Text(
                            Screens.exerciseClassDates,
                            style: TextStyle(
                                fontSize: 20, color: kPrimaryDarkColor),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            Container(
              margin: EdgeInsets.symmetric(
                  vertical: getProportionateScreenHeight(10)),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceAround,
                children: [
                  InkWell(
                    onTap: () =>
                        Navigator.pushNamed(context, MyRecordsScreen.routeName),
                    child: Container(
                      height: 100,
                      width: SizeConfig.screenWidth / 3,
                      child: Center(
                        child: Column(
                          children: [
                            ClipOval(
                              child: Image.network(
                                'https://png.pngtree.com/png-clipart/20190614/original/pngtree-vector-calendar-icon-png-image_3764875.jpg',
                                width: 100,
                                height: 65,
                              ),
                            ),
                            Text(
                              Screens.myRecords,
                              style: TextStyle(
                                  fontSize: 20, color: kPrimaryDarkColor),
                            ),
                          ],
                        ),
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                    ),
                  ),
                  InkWell(
                    onTap: () {
                      print("Container clicked");
                    },
                    child: Container(
                      height: 100,
                      width: SizeConfig.screenWidth / 3,
                      child: Column(
                        children: [
                          ClipOval(
                            child: Image.network(
                              'https://png.pngtree.com/png-vector/20190411/ourmid/pngtree-vector-information-icon-png-image_924440.jpg',
                              width: 100,
                              height: 65,
                            ),
                          ),
                          Text(
                            Screens.more,
                            style: TextStyle(
                                fontSize: 20, color: kPrimaryDarkColor),
                          ),
                        ],
                      ),
                      decoration: BoxDecoration(
                        color: Colors.white,
                        borderRadius:
                            BorderRadius.circular(30), //border corner radius
                        boxShadow: [
                          BoxShadow(
                            color:
                                Colors.grey.withOpacity(0.5), //color of shadow
                            spreadRadius: 5, //spread radius
                            blurRadius: 7, // blur radius
                            offset: Offset(0, 2), // changes position of shadow
                            //first paramerter of offset is left-right
                            //second parameter is top to down
                          ),
                          //you can set more BoxShadow() here
                        ],
                      ),
                    ),
                  ),
                ],
              ),
            ),
            // InkWell(
            //   onTap: () {
            //     print("Container clicked");
            //   },
            //   child: Container(
            //     height: 100,
            //     width: SizeConfig.screenWidth,
            //     child: Center(
            //       child: Text(
            //         Screens.supplements,
            //         style: TextStyle(
            // fontSize: 20, color: kPrimaryDarkColor),
            //       ),
            //     ),
            //     decoration: BoxDecoration(
            //       color: Colors.grey[800]?.withOpacity(0.8),
            //       border: Border(
            //         top: BorderSide(width: 1, color: Colors.black12),
            //       ),
            //     ),
            //   ),
            // ),
            // Row(
            //   children: [
            //     InkWell(
            //       onTap: () {
            //         print("Container clicked");
            //       },
            //       child: Container(
            //         width: SizeConfig.screenWidth / 3,
            //         height: 130,
            //         decoration: BoxDecoration(
            //           color: Colors.grey[800]?.withOpacity(0.8),
            //           border: Border.all(width: 1, color: Colors.black12),
            //         ),
            //         child: Center(
            //             child: Text(
            //           Screens.contactCoach,
            //           style: TextStyle(fontSize: 15),
            //         )),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         print("Container clicked");
            //       },
            //       child: Container(
            //         width: SizeConfig.screenWidth / 3,
            //         height: 130,
            //         decoration: BoxDecoration(
            //           color: Colors.grey[800]?.withOpacity(0.8),
            //           border: Border.all(width: 1, color: Colors.black12),
            //         ),
            //         child: Center(
            //             child: Text(
            //           Screens.contactDietitian,
            //           style: TextStyle(
            //             fontSize: 15,
            //           ),
            //         )),
            //       ),
            //     ),
            //     InkWell(
            //       onTap: () {
            //         print("Container clicked");
            //       },
            //       child: Container(
            //         width: SizeConfig.screenWidth / 3,
            //         height: 130,
            //         decoration: BoxDecoration(
            //           color: Colors.grey[800]?.withOpacity(0.8),
            //           border: Border.all(width: 1, color: Colors.black12),
            //         ),
            //         child: Center(
            //             child: Text(
            //           Screens.suggestionsComplaints,
            //           style: TextStyle(fontSize: 15),
            //         )),
            //       ),
            //     ),
            //   ],
            // ),
            // Row(children: [
            //   InkWell(
            //     onTap: () {
            //       print("Container clicked");
            //     },
            //     child: Container(
            //       width: SizeConfig.screenWidth / 2,
            //       height: 70,
            //       decoration: BoxDecoration(
            //         color: Colors.grey[800]?.withOpacity(0.8),
            //         border: Border.all(width: 1, color: Colors.black12),
            //       ),
            //       child: Center(
            //           child: Text(
            //         Screens.faq,
            //         style: TextStyle(fontSize: 15),
            //       )),
            //     ),
            //   ),
            //   InkWell(
            //     onTap: () {
            //       print("Container clicked");
            //     },
            //     child: Container(
            //       width: SizeConfig.screenWidth / 2,
            //       height: 70,
            //       decoration: BoxDecoration(
            //         color: Colors.grey[800]?.withOpacity(0.8),
            //         border: Border.all(width: 1, color: Colors.black12),
            //       ),
            //       child: Center(
            //           child: Text(
            //         Screens.myRecords,
            //         style: TextStyle(
            //           fontSize: 15,
            //         ),
            //       )),
            //     ),
            //   ),
            // ]),
            // Row(children: [
            //   InkWell(
            //     onTap: () {
            //       print("Container clicked");
            //     },
            //     child: Container(
            //       width: SizeConfig.screenWidth / 2,
            //       height: 70,
            //       decoration: BoxDecoration(
            //         color: Colors.grey[800]?.withOpacity(0.8),
            //         border: Border.all(width: 1, color: Colors.black12),
            //       ),
            //       child: Center(
            //           child: Text(
            //         Screens.exerciseClassDates,
            //         style: TextStyle(fontSize: 15),
            //       )),
            //     ),
            //   ),
            //   InkWell(
            //     // splashColor: Theme.of(context).errorColor,
            //     onTap: () {
            //       // ScaffoldMessenger.of(context).showSnackBar(SnackBar(
            //       //   content: Text('Tap'),
            //       // ));
            //     },
            //     child: Container(
            //       width: SizeConfig.screenWidth / 2,
            //       height: 70,
            //       decoration: BoxDecoration(
            //         color: Colors.grey[800]?.withOpacity(0.8),
            //         border: Border.all(width: 1, color: Colors.black12),
            //       ),
            //       child: Center(
            //           child: Text(
            //         'QR',
            //         style: TextStyle(
            //           fontSize: 15,
            //         ),
            //       )),
            //     ),
            //   ),
            // ]),
          ],
        ),
      ),
    );
  }

  AnimatedContainer buildDot({required int index}) {
    return AnimatedContainer(
      duration: kAnimationDuration,
      margin: EdgeInsets.only(right: 5),
      height: 6,
      width: currentPage == index ? 20 : 6,
      decoration: BoxDecoration(
        color: currentPage == index ? kSecondaryColor : kDefaultColor,
        borderRadius: BorderRadius.circular(3),
      ),
    );
  }
}
