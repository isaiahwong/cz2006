// import 'package:fitness/bloc/bloc.dart';
// import 'package:fitness/bloc/timer/timer.dart';
// import 'package:fitness/common/format.dart';
// import 'package:fitness/component/component.dart';
// import 'package:flutter/cupertino.dart';
// import 'package:flutter/material.dart';
// import 'package:flutter_bloc/flutter_bloc.dart';
// import 'package:sleek_circular_slider/sleek_circular_slider.dart';

// class CurrentRoutinePanelRest extends StatelessWidget {
//   const CurrentRoutinePanelRest({Key? key}) : super(key: key);

//   static Page page() => CupertinoPage<void>(
//         child: CurrentRoutinePanelRest(),
//       );

//   @override
//   Widget build(BuildContext context) {
//     final timerSize = MediaQuery.of(context).size.width * 0.8;
//     return Container(
//       child: BlocBuilder<TimerBloc, TimerState>(
//         builder: (context, state) => Align(
//           child: SizedBox(
//             child: SleekCircularSlider(
//               appearance: CircularSliderAppearance(
//                 customWidths: CustomSliderWidths(
//                   progressBarWidth: 25,
//                   trackWidth: 25,
//                 ),
//                 customColors: CustomSliderColors(
//                   progressBarColor: primaryColor,
//                   trackColor: accentColor,
//                   hideShadow: true,
//                 ),
//                 animationEnabled: false,
//                 startAngle: 270,
//                 angleRange: 360,
//                 size: timerSize,
//               ),
//               onChange: (d) {
//                 if (state is TimerRunPause)
//                   BlocProvider.of<TimerBloc>(context).add(
//                       TimerSet(duration: Duration(milliseconds: d.toInt())));
//               },
//               onChangeStart: (_) =>
//                   BlocProvider.of<TimerBloc>(context).add(TimerPaused()),
//               onChangeEnd: (d) {
//                 BlocProvider.of<TimerBloc>(context).add(
//                     TimerStarted(duration: Duration(milliseconds: d.toInt())));
//               },
//               min: -0.1,
//               max: Duration(
//                   seconds: context.select((ActiveWorkoutBloc bloc) =>
//                       (bloc.state.currentRoutine?.routinePlan?.restDuration ??
//                           0))).inMilliseconds.toDouble(),
//               initialValue: state.current.inMilliseconds.toDouble(),
//               innerWidget: (_) => Row(
//                 crossAxisAlignment: CrossAxisAlignment.center,
//                 mainAxisAlignment: MainAxisAlignment.center,
//                 children: [
//                   Text(
//                     "${zeroPrefix(state.current.inMinutes)}:",
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline2!
//                         .copyWith(fontSize: 50),
//                   ),
//                   Text(
//                     zeroPrefix(state.seconds),
//                     style: Theme.of(context)
//                         .textTheme
//                         .headline2!
//                         .copyWith(fontSize: 50),
//                   ),
//                 ],
//               ),
//             ),
//           ),
//         ),
//       ),
//       // child: SleekCircularSlider(
//       //     appearance: CircularSliderAppearance(), onChange: (double value) {}),
//     );
//   }
// }
