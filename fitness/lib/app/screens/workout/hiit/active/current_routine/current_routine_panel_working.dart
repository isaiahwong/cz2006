import 'package:fitness/app/components/button/button.dart';
import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/screens/workout/hiit/active/active.dart';
import 'package:fitness/app/screens/workout/hiit/active/pose/pose_screen.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class CurrentRoutinePanelWorking extends GetView<ActiveHIITController> {
  const CurrentRoutinePanelWorking({Key? key}) : super(key: key);

  static Page page() => CupertinoPage<void>(
        child: CurrentRoutinePanelWorking(),
      );

  void _onRepsTap(BuildContext context) {
    // BlocProvider.of<SlidingPanelBloc>(context).add(SlidingPanelOpened(
    //   panel: (_) => CurrentRoutineRepsPanel(),
    //   fixed: true,
    // ));
  }

  void _onWeightsTap(BuildContext context) {
    // BlocProvider.of<SlidingPanelBloc>(context).add(SlidingPanelOpened(
    //   panel: (_) => CurrentRoutineWeightsPanel(),
    //   fixed: true,
    // ));
  }

  Widget _title(BuildContext context) {
    return Container(
      padding: EdgeInsets.only(
        top: 10,
      ),
      child: Row(
        children: [
          Expanded(
            flex: 4,
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(controller.currentRoutine!.exercise.name,
                    overflow: TextOverflow.clip,
                    style: Theme.of(context).textTheme.headline3!.copyWith(
                          color: Colors.black,
                          fontSize: 65,
                          fontWeight: FontWeight.w900,
                        )),
                SizedBox(height: 10),
                Text(
                  "${RoutineInterval.typeToString(controller.currentInterval!.type)} ${controller.currentInterval!.iteration}",
                  style: Theme.of(context).textTheme.headline4!.copyWith(
                        fontSize: 45,
                        color: controller.currentInterval!.type ==
                                RoutineIntervalType.WARMUP
                            ? orange
                            : primaryColor,
                      ),
                ),
              ],
            ),
          ),
          Expanded(
            child: Column(
              children: [],
            ),
          ),
        ],
      ),
    );
  }

  Widget _repsTitle(BuildContext context) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onRepsTap(context),
        child: Container(
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "${controller.currentInterval!.currentLog.reps}",
                style: Theme.of(context).textTheme.headline5,
              ),
              SizedBox(width: 5),
              Text(
                "Reps",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w400),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _repsCard(BuildContext context, int reps) {
    return Expanded(
      child: GestureDetector(
        onTap: () => _onRepsTap(context),
        child: Container(
          height: 50,
          decoration: BoxDecoration(
            color: black,
            borderRadius: BorderRadius.circular(8),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Text(
                "$reps",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      color: Colors.white,
                    ),
              ),
              SizedBox(width: 5),
              Text(
                "Reps",
                style: Theme.of(context).textTheme.headline5!.copyWith(
                      fontWeight: FontWeight.w400,
                      color: Colors.white,
                    ),
              )
            ],
          ),
        ),
      ),
    );
  }

  Widget _current(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline6!.copyWith(
          color: Colors.grey[500],
          fontWeight: FontWeight.w900,
        );

    final subtextStyle = Theme.of(context).textTheme.headline6!.copyWith(
          color: Colors.grey[500],
        );
    return Padding(
      padding: EdgeInsets.only(top: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                "${controller.currentRoutine!.exercise.name} ${controller.currentInterval!.iteration}",
                style: Theme.of(context).textTheme.headline4!.copyWith(
                      fontWeight: FontWeight.w900,
                    ),
              ),
            ],
          ),
          controller.poseStarted
              ? GestureDetector(
                  onTap: controller.stopPose,
                  child: Icon(
                    CupertinoIcons.circle_fill,
                    size: 30,
                    color: red,
                  ),
                )
              : GestureDetector(
                  onTap: controller.startPose,
                  child: Icon(
                    CupertinoIcons.circle,
                    size: 30,
                    color: green,
                  ),
                )
        ],
      ),
    );
  }

  Widget _addSetBtn(BuildContext context) {
    if (controller.currentRoutine?.nextInterval(controller.currentInterval) !=
        null) return SizedBox.shrink();

    return CustomButton(
      "ADD  SET",
      backgroundColor: primaryColor,
      textColor: Colors.white,
      width: double.infinity,
      // onTap: () => BlocProvider.of<ActiveWorkoutBloc>(context)
      //     .add(ActiveWorkoutAddSetFromPrevious()),
    );
  }

  Widget _row(
    BuildContext context,
  ) {
    return Row(
      children: [
        _repsCard(context, controller.count),
        SizedBox(width: 15),
        _repsCard(context, controller.currentInterval!.defaultReps),
      ],
    );
  }

  Widget _col(BuildContext context) {
    return Column(
      children: [
        SizedBox(width: 15),
        _repsTitle(context),
      ],
    );
  }

  @override
  Widget build(BuildContext context) {
    return GetBuilder<ActiveHIITController>(
      builder: (controller) => Container(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            PoseScreen(),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                ...margin(
                  margin: EdgeInsets.only(left: 10, right: 10),
                  children: [
                    _current(context),
                    SizedBox(height: 20),
                    _row(context),
                    SizedBox(height: 20),
                    _addSetBtn(context),
                  ],
                )
              ],
            ),
          ],
        ),
      ),
    );
  }
}
