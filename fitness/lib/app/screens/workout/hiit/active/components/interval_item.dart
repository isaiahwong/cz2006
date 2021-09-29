import 'package:fitness/common/format.dart';
import 'package:fitness/app/components/space/space.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class IntervalItem extends StatelessWidget {
  final bool active;
  final RoutineInterval interval;
  final RoutineInterval? nextInterval;

  const IntervalItem({
    Key? key,
    required this.interval,
    this.nextInterval,
    this.active = false,
  }) : super(key: key);

  void _onRoutineSelected(
    BuildContext context,
    RoutineInterval interval,
  ) {
    // BlocProvider.of<ActiveWorkoutBloc>(context).add(
    //   ActiveWorkoutCurrentRoutine(interval: interval),
    // );
  }

  // Widget _routineWeightsLoaded(BuildContext context) {
  //   if (!interval.hasWeightsLoaded) return SizedBox.shrink();

  //   return Container(
  //     padding: EdgeInsets.only(
  //       top: 12,
  //       right: 35,
  //     ),
  //     child: Row(
  //       mainAxisAlignment: MainAxisAlignment.end,
  //       children: [
  //         ...margin(
  //             children: interval.routinePlan!.equipment!.weights
  //                 .where((w) => w.quantity != 0)
  //                 .map(
  //                   (w) => Column(children: [
  //                     Container(
  //                       width: 30,
  //                       height: 30,
  //                       decoration: BoxDecoration(
  //                         border: Border.all(
  //                           color: active ? Colors.white : Colors.black,
  //                           width: 2,
  //                         ),
  //                         borderRadius: BorderRadius.circular(100),
  //                       ),
  //                       child: Center(
  //                         child: Text("${prettyDP(w.weight)}",
  //                             style: Theme.of(context)
  //                                 .textTheme
  //                                 .bodyText2!
  //                                 .copyWith(
  //                                     color: active
  //                                         ? Colors.white
  //                                         : Colors.black)),
  //                       ),
  //                     ),
  //                     SizedBox(height: 5),
  //                     Text("x ${w.quantity}",
  //                         style:
  //                             Theme.of(context).textTheme.bodyText2!.copyWith(
  //                                   color: active ? Colors.white : Colors.black,
  //                                 ))
  //                   ]),
  //                 )
  //                 .toList(),
  //             margin: EdgeInsets.only(left: 5)),
  //       ],
  //     ),
  //   );
  // }

  Widget _details(BuildContext context) {
    final color = active
        ? Colors.white
        : interval.type == RoutineIntervalType.WARMUP
            ? orange
            : black;

    final textStyle = Theme.of(context).textTheme.headline5!.copyWith(
          color: color,
          fontWeight: FontWeight.w900,
        );

    final subTextStyle = Theme.of(context).textTheme.headline5!.copyWith(
          color: color,
          fontWeight: FontWeight.normal,
        );

    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Expanded(
          flex: 4,
          child: Text(
            "${RoutineInterval.typeToString(interval.type)} ${interval.iteration}",
            style: Theme.of(context).textTheme.headline5!.copyWith(
                  color: color,
                ),
          ),
        ),
        Expanded(
          flex: 5,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            mainAxisAlignment: MainAxisAlignment.end,
            children: margin(
              children: [
                Row(
                  children: [
                    Text(
                      "t",
                      // prettyDP(interval.routinePlan!.weight),
                      style: textStyle,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "kg",
                      style: subTextStyle,
                    ),
                  ],
                ),
                SizedBox(width: 20),
                Row(
                  children: [
                    Text(
                      "${interval.currentLog.reps}",
                      style: textStyle,
                    ),
                    SizedBox(width: 5),
                    Text(
                      "Reps",
                      style: subTextStyle,
                    ),
                  ],
                ),
                // Container(
                //   width: 40,
                //   child: active
                //       ? interval.routinePlan!.equipment?.icon
                //       : interval.routinePlan!.equipment?.iconAlt,
                // ),
              ],
              margin: EdgeInsets.only(right: 5),
            ),
          ),
        ),
        SizedBox(width: 15),
        Icon(
          interval.currentLog.completed
              ? CupertinoIcons.checkmark_alt
              : CupertinoIcons.circle,
          color: active
              ? Colors.white
              : interval.type == 1
                  ? orange
                  : primaryColor,
        ),
      ],
    );
  }

  // Widget _groupItem(BuildContext context) {}

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () => _onRoutineSelected(context, interval),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 50,
        ),

        // height: 80,
        padding: EdgeInsets.all(8),
        margin: EdgeInsets.only(bottom: 10),
        decoration: BoxDecoration(
            color: active
                ? interval.type == RoutineIntervalType.WARMUP
                    ? orange
                    : primaryColor
                : Colors.white,
            borderRadius: BorderRadius.circular(5),
            boxShadow: [
              BoxShadow(
                blurRadius: 5,
                spreadRadius: 1,
                color: Color.fromRGBO(0, 0, 0, 0.1),
              )
            ]),
        child: Column(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            _details(context),
            // _routineWeightsLoaded(context),
            // _details(context),
            // _groupItem(context)
          ],
        ),
      ),
    );
  }
}
