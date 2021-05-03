import 'package:flutter/material.dart';
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
    return Stack(fit: StackFit.expand, children: [
      Column(
        children: [
          Expanded(
            child: PageView(
              onPageChanged: (value) => currentPage = value,
              children: [
                FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(
                      'https://i1.wp.com/bodybuildingarabs.com/wp-content/uploads/2019/10/ou_ouso_-ouo-oou_u-oououo-1.jpg?fit=1320%2C755&ssl=1'),
                ),
                Image.network(
                    'https://i1.wp.com/bodybuildingarabs.com/wp-content/uploads/2020/02/ouo-ooo-oou_u-1.jpg?resize=708%2C329&ssl=1'),
              ],
            ),
          ),
        ],
      ),
    ]);
  }

  @override
  bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
}

// Stack(
//   fit: StackFit.expand,
//   children: [

//     Container(
//       decoration: BoxDecoration(
//         gradient: LinearGradient(
//             colors: [Colors.transparent, Colors.black54],
//             stops: [0.5, 1.0],
//             begin: Alignment.topCenter,
//             end: Alignment.bottomCenter,
//             tileMode: TileMode.repeated),
//       ),
//     ),
//     Positioned(
//       left: 16.0,
//       right: 16.0,
//       bottom: 16.0,
//       child: Text(
//         'Param',
//         style: TextStyle(fontSize: 32, color: Colors.black),
//       ),
//     ),
//   ],
// ),
// class Header extends SliverPersistentHeaderDelegate {
//   late double toolBarHeight;
//   //toolBarHeight Included in both
//   late double closedHeight;
//   late double openHeight;

//   Header(
//     {required this.toolBarHeight,
//     required this.closedHeight,
//     required this.openHeight,}
//   );

//   @override
//   Widget build(
//       BuildContext context, double shrinkOffset, bool overlapsContent) {
//     return Container(
//       height: toolBarHeight + openHeight,
//       color: Theme.of(context).primaryColorDark,
//       child: SafeArea(
//         child: Container(
//           padding: EdgeInsets.symmetric(
//             horizontal: 64,
//           ),
//           child: FittedBox(
//             fit: BoxFit.contain,
//             child: Text("Workouts"),
//           ),
//         ),
//       ),
//     );
//   }

//   @override
//   double get maxExtent => toolBarHeight + openHeight;

//   @override
//   double get minExtent => toolBarHeight + closedHeight;

//   @override
//   bool shouldRebuild(SliverPersistentHeaderDelegate oldDelegate) => true;
// }
