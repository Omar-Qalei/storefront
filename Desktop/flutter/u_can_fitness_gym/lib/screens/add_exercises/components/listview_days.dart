import 'package:flutter/material.dart';
import 'package:u_can_fitness_gym/shared/data/data.dart';
import 'package:u_can_fitness_gym/shared/settings/page_view.setting.dart';

class ListView_Days extends StatelessWidget {
  const ListView_Days({
    Key? key,
  }) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return ListView.separated(
      itemCount: Data.days.length,
      separatorBuilder: (BuildContext context, int index) {
        return Align(
          alignment: Alignment.centerRight,
          child: Container(
            height: 1,
            width: MediaQuery.of(context).size.width / 1.3,
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
    );
  }
}
