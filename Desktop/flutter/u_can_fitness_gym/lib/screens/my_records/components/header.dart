import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/shared/enum/screens.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class Header extends SliverPersistentHeaderDelegate {
  Header({required this.minExtent, required this.maxExtent});
  final double minExtent;
  final double maxExtent;
  int currentPage = 0;
  @override
  @override
  Widget build(
      BuildContext context, double shrinkOffset, bool overlapsContent) {
    return Stack(
      fit: StackFit.expand,
      children: [
        FittedBox(
          fit: BoxFit.fill,
          child: Image.network(
              'https://t4.ftcdn.net/jpg/01/13/65/71/360_F_113657105_Bktota7BzQ5cEUcZb4l0D4qSD2Sw08P2.jpg'),
        ),
        Container(
          width: double.maxFinite,
          decoration: BoxDecoration(
            gradient: LinearGradient(
                colors: [Colors.black54, Colors.transparent],
                stops: [0.5, 1.0],
                begin: Alignment.topCenter,
                end: Alignment.bottomCenter,
                tileMode: TileMode.repeated),
          ),
        ),
        Positioned(
          left: 16.0,
          right: 16.0,
          bottom: 16.0,
          child: Text(
            Screens.myRecords,
            style: TextStyle(
                fontSize: 32, color: Colors.white, fontWeight: FontWeight.w500),
          ),
        ),
        Positioned(
          top: 16.0,
          right: 16.0,
          child: IconButton(
            icon: Icon(Icons.arrow_back),
            color: kPrimaryLightColor,
            onPressed: () => Navigator.pop(context),
          ),
        ),
      ],
    );
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}
