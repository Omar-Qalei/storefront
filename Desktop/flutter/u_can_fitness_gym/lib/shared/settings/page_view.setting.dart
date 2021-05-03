import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class PageViewSettings {
  static final PageController controller = new PageController();
  double pageScroller = 0.0;
  nextPage(BuildContext context) {
    print(SizeConfig.screenWidth);
    pageScroller = SizeConfig.screenWidth;
    FocusScope.of(context).unfocus();
    return controller.animateTo(pageScroller,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }

  backPage(BuildContext context) {
    pageScroller = SizeConfig.screenWidth;
    FocusScope.of(context).unfocus();
    return controller.animateTo(-pageScroller,
        duration: Duration(milliseconds: 500), curve: Curves.easeIn);
  }
}
