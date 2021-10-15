import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/screens/workout/hiit/active/active_hiit_controller.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentIntervalDuoWaiting extends GetView<ActiveHIITController> {
  const CurrentIntervalDuoWaiting({Key? key}) : super(key: key);

  static Page page() => CupertinoPage<void>(
        child: CurrentIntervalDuoWaiting(),
      );

  Widget _title(BuildContext context) {
    return Padding(
      padding: screenPadding,
      child: Text(
        "Waiting for 😛",
        style: Theme.of(context).textTheme.headline1!.copyWith(
              color: black,
              fontWeight: FontWeight.w900,
              fontSize: 50,
            ),
      ),
    );
  }

  Widget _peopleRow(BuildContext context) {
    return Padding(
      padding: screenPadding.copyWith(top: 10),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          SizedBox(height: 10),
          Container(
            height: MediaQuery.of(context).size.height * 0.4,
            child: GridView.count(
              scrollDirection: Axis.vertical,
              shrinkWrap: true,
              crossAxisCount: 6,
              children: controller.hiit.participants
                  .where((e) =>
                      // not in usersCompleted
                      controller.usersCompleted
                          .indexWhere((u) => u.id == e.id) ==
                      -1)
                  .map<Widget>((e) => UserImage(user: e))
                  .toList(),
            ),
          )
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: Column(
        children: [
          _title(context),
          _peopleRow(context),
        ],
      ),
    );
  }
}
