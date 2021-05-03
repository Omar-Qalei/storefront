import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/constants.dart';
import 'package:u_can_fitness_gym/screens/exercises_subcategories/exercises_subcategories_screen.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/enum/screens.dart';
import 'package:u_can_fitness_gym/shared/models/exercises.dart';
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

  // void listener() {
  //   if (_isPlayerReady && mounted && !_controller.value.isFullScreen) {
  //     setState(() {
  //       _playerState = _controller.value.playerState;
  //       _videoMetaData = _controller.metadata;
  //     });
  //   }
  // }
  //

  @override
  Widget build(BuildContext context) {
    final ExercisesModel params =
        ModalRoute.of(context)?.settings.arguments as ExercisesModel;
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
            child: Row(
              children: [
                Column(
                  children: [
                    // Container(
                    //     width: SizeConfig.screenWidth,
                    //     height: 300,
                    //     child:),
                    //
                    // Container(
                    //   width: SizeConfig.screenWidth,
                    //   height: 300,
                    //   child: YoutubePlayerIFrame(
                    //     // controller: _controller,
                    //     aspectRatio: 16 / 9,
                    //   ),
                    // ),
                    //             FlutterYoutube.playYoutubeVideoByUrl(
                    // apiKey: "AIzaSyBxc3NhQUnjPb3wQEKOZRMz-0YLn-jHWnY",
                    // videoUrl: "https://www.youtube.com/watch?v=OBm2mz3IHoM&ab_channel=MrTojake",
                    // autoPlay: true, //default falase
                    // fullScreen: true //default false
                    // )
                    // Container(
                    //   child: YoutubePlayerBuilder(
                    //       player: YoutubePlayer(
                    //         controller: _controller,
                    //       ),
                    //       builder: (context, player) {
                    //         return Column(
                    //           children: [
                    //             // some widgets
                    //             player,
                    //             //some other widgets
                    //           ],
                    //         );
                    //       }),
                    // ),
                    // YoutubePlayer(
                    //   controller: _controller,
                    //   showVideoProgressIndicator: true,
                    //   progressIndicatorColor: Colors.amber,
                    //   progressColors: ProgressBarColors(
                    //     playedColor: Colors.amber,
                    //     handleColor: Colors.amberAccent,
                    //   ),
                    //   onReady: () {
                    //     _controller.addListener(listener);
                    //   },
                    // ),
                  ],
                ),
              ],
            ),
          ),
          //  Header(
          //   toolBarHeight: MediaQuery.of(context).padding.top,
          //   openHeight: 250,
          //   closedHeight: 40),
          // Sliver
        ],
      ),
    );
  }

  @override
  void dispose() async {
    super.dispose();
    // await _videoViewController.dispose();
  }
}
