import 'package:fitness/app/components/space/space.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

typedef ItemSelected = void Function(RoutineInterval interval);

class IntervalItem extends StatelessWidget {
  final bool active;
  final RoutineInterval interval;
  final RoutineInterval? nextInterval;
  final ItemSelected onSelected;

  const IntervalItem({
    Key? key,
    required this.interval,
    required this.onSelected,
    this.nextInterval,
    this.active = false,
  }) : super(key: key);

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
              : interval.type == RoutineIntervalType.WARMUP
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
      onTap: () => onSelected(interval),
      child: Container(
        constraints: BoxConstraints(
          minHeight: 50,
        ),

        // height: 80,
        padding: EdgeInsets.only(top: 8, bottom: 8, left: 15, right: 15),
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
            // _details(context),
            // _groupItem(context)
          ],
        ),
      ),
    );
  }
}
