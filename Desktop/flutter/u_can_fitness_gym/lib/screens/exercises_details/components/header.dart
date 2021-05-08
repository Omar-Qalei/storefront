import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/size_config.dart';
import 'package:youtube_player_flutter/youtube_player_flutter.dart';
// import 'package:youtube_plyr_iframe/youtube_plyr_iframe.dart';

class Header extends StatefulWidget {
  @override
  _HeaderState createState() => _HeaderState();
}

class _HeaderState extends State<Header> {
  int currentPage = 0;
  YoutubePlayerController _controller = YoutubePlayerController(
    initialVideoId: 'iLnmTe5Q2Qw',
    flags: YoutubePlayerFlags(
      autoPlay: true,
      mute: true,
    ),
  );
  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      height: SizeConfig.orientation == Orientation.landscape
          ? getProportionateScreenHeight(500)
          : getProportionateScreenHeight(300),
      margin: EdgeInsets.only(bottom: 10),
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
                FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(
                      'https://i1.wp.com/bodybuildingarabs.com/wp-content/uploads/2019/10/ou_ouso_-ouo-oou_u-oououo-1.jpg?fit=1320%2C755&ssl=1'),
                ),
                FittedBox(
                  fit: BoxFit.fill,
                  child: Image.network(
                      'https://i1.wp.com/bodybuildingarabs.com/wp-content/uploads/2020/02/ouo-ooo-oou_u-1.jpg?resize=708%2C329&ssl=1'),
                ),
                SizedBox(
                  width: SizeConfig.screenWidth,
                  child: YoutubePlayer(
                    controller: _controller,
                    showVideoProgressIndicator: true,
                    progressIndicatorColor: Colors.amber,
                    progressColors: ProgressBarColors(
                      playedColor: Colors.amber,
                      handleColor: Colors.amberAccent,
                    ),
                    onReady: () {
                      // _controller.addListener(listener);
                    },
                  ),
                  // YoutubePlayerIFrame(
                  //   controller: _controller,
                  //   aspectRatio: 16 / 9,
                  // ),
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
