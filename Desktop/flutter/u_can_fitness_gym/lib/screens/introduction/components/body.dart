import 'dart:async';

import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/size_config.dart';
import 'package:video_player/video_player.dart';

class Body extends StatefulWidget {
  @override
  _BodyState createState() => _BodyState();
}

class _BodyState extends State<Body> with TickerProviderStateMixin {
  // late VideoPlayerController _controller;
  // Future<void>? _initializeVideoPlayerFuture;
  double opacityLevel = 0.0;
  late AnimationController animationController = AnimationController(
    duration: Duration(seconds: 2),
    vsync: this,
  );
  @override
  void initState() {
    super.initState();
    Timer(Duration(seconds: 2),
        () => Navigator.of(context).pushReplacementNamed('/home'));
  }

  @override
  Widget build(BuildContext context) {
    animationController.forward();
    // print(ModalRoute.of(context)!.settings.name);
    // Future.delayed(Duration(seconds: 2), () {
    //   if (ModalRoute.of(context)!.settings.name != '/home')
    //     Navigator.pushNamed(context, '/home');

    //   print('test');
    // });
    return Center(
      child: Container(
        width: SizeConfig.screenWidth / 2,
        height: SizeConfig.screenHeight / 2,
        child: FadeTransition(
          opacity: animationController.drive(CurveTween(curve: Curves.easeOut)),
          child: Image.asset(
            'assets/images/logo.png',
          ),
        ),
      ),
    );
  }

  @override
  void dispose() {
    // Ensure disposing of the VideoPlayerController to free up resources.
    // _controller.dispose();

    super.dispose();
  }
}
