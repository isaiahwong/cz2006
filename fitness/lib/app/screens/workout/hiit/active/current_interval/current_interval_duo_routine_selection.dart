import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/controllers/user/user_controller.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentIntervalDuoRoutineSelection extends GetView<ActiveHIITController> {
  const CurrentIntervalDuoRoutineSelection({Key? key}) : super(key: key);

  Widget _title(BuildContext context) {
    return SliverToBoxAdapter(
      child: Padding(
        padding: screenPadding,
        child: Column(children: [
          Text(
            "Winner 🎉",
            style: Theme.of(context).textTheme.headline1!.copyWith(
                  color: black,
                  fontWeight: FontWeight.w900,
                  fontSize: 50,
                ),
          ),
          UserImage(user: controller.winner),
        ]),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required Widget trailing,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing
          ],
        ),
      ),
    );
  }

  Widget _routineItem(BuildContext context, Routine routine) {
    return _item(
      context,
      title: routine.exercise.name,
      trailing: Row(
        children: [
          Text(
            "${routine.sets.toString()} Sets",
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }

  Widget _message(BuildContext context) {
    if (UserController.get().user.value!.id == controller.winner?.id) {
      return Text(
        "Select next hiit exercise!",
        style: Theme.of(context).textTheme.headline4,
      );
    }
    return Text(
      "Waiting for ${controller.winner?.name} to select exercise!",
      style: Theme.of(context).textTheme.headline4,
    );
  }

  Widget body(BuildContext context) {
    print(controller.hiit.getIncompleteRoutines());
    return SliverToBoxAdapter(
      child: Padding(
        padding: screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: margin(
            children: [
              _message(context),
              SizedBox(height: 10),
              ...controller.hiit
                  .getIncompleteRoutines()
                  .map<Widget>((routine) => _routineItem(context, routine))
                  .toList()
            ],
            margin: EdgeInsets.only(bottom: 15),
          ),
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      child: CustomScrollView(
        controller: ScrollController(),
        slivers: [
          _title(context),
          SliverToBoxAdapter(
            child: SizedBox(height: 80),
          ),
          body(context),
        ],
      ),
    );
  }
}
