import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/settings/page_view.setting.dart';
import 'package:u_can_fitness_gym/size_config.dart';

class ListView_Days extends StatelessWidget {
  const ListView_Days({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container(
      width: SizeConfig.screenWidth,
      child: ListView.separated(
        itemCount: Data.days.length,
        separatorBuilder: (BuildContext context, int index) {
          return Align(
            alignment: Alignment.centerRight,
            child: Container(
              height: 10,
              child: Divider(),
            ),
          );
        },
        itemBuilder: (BuildContext context, index) {
          return InkWell(
            onTap: () => PageViewSettings().nextPage(context),
            child: new Container(
              height: 50,
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(Data.days[index].title ?? ""),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
