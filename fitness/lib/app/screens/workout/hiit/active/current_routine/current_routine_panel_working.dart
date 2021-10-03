import 'package:fitness/app/components/button/button.dart';
import 'package:fitness/app/screens/workout/hiit/active/active.dart';
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

  Widget _repsCard(BuildContext context) {
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
                "${controller.currentInterval!.currentLog.reps}",
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

  Widget _previousWeightRepRow(BuildContext context) {
    final textStyle = Theme.of(context).textTheme.headline6!.copyWith(
          color: Colors.grey[500],
          fontWeight: FontWeight.w900,
        );

    final subtextStyle = Theme.of(context).textTheme.headline6!.copyWith(
          color: Colors.grey[500],
        );
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Previous",
          style: Theme.of(context).textTheme.headline5!.copyWith(
                color: Colors.grey[500],
              ),
        ),
        Row(
          children: [
            SizedBox(width: 10),
            Row(
              children: [
                Text("20", style: textStyle),
                SizedBox(width: 5),
                Text("Reps", style: subtextStyle),
              ],
            ),
          ],
        )
      ],
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
        SizedBox(width: 15),
        _repsCard(context),
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
        padding: EdgeInsets.only(
          left: 20,
          right: 20,
          bottom: 5,
        ),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            _title(context),
            Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                _previousWeightRepRow(context),
                SizedBox(height: 20),
                _row(context),
                SizedBox(height: 20),
                _addSetBtn(context),
              ],
            ),
          ],
        ),
      ),
    );
  }
}
