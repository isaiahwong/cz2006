// import 'package:fitness/bloc/ui/app_panel/app_panel.dart';
import 'package:fitness/common/format.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class CurrentRoutinePanelHeader extends StatelessWidget {
  const CurrentRoutinePanelHeader({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Container();
  }
}

// class CurrentRoutinePanelHeader extends StatelessWidget {
//   const CurrentRoutinePanelHeader({Key? key}) : super(key: key);

//   void _onRoutineCompleted(BuildContext context, Routine routine) {
//     // if (BlocProvider.of<ActiveWorkoutBloc>(context).state.workout.isLastRoutine(routine)) return;
//     // Skip to next if completed
//     if (routine.routinePlan?.completed ?? true) {
//       BlocProvider.of<ActiveWorkoutBloc>(context).add(ActiveWorkoutNext());
//       return;
//     }

//     BlocProvider.of<ActiveWorkoutBloc>(context).add(
//       ActiveWorkoutRoutineCompleted(routine: routine),
//     );
//   }

//   void _onRestSkip(BuildContext context) {
//     BlocProvider.of<ActiveWorkoutBloc>(context).add(
//       ActiveWorkoutNext(),
//     );
//   }

//   Widget restWorkoutBar(BuildContext context, ActiveWorkoutState state) {
//     if (state.currentRoutine == null) return SizedBox.shrink();
//     final next = state.currentRoutine?.next;
//     final nextExercise = state.currentExercise?.next;
//     final name = state.currentExercise?.name ?? nextExercise?.name ?? "";

//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.center,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               "Upcoming",
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     color: red,
//                     fontWeight: FontWeight.w900,
//                     fontSize: 14,
//                   ),
//             ),
//             Text(
//               name,
//               overflow: TextOverflow.ellipsis,
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     fontWeight: FontWeight.w900,
//                     fontSize: 20,
//                     color: black,
//                   ),
//             ),
//             SizedBox(width: 2),
//             Text(
//               "${Routine.typeIntToString(next?.type ?? 0)} ${next?.iteration ?? ""}",
//               style: Theme.of(context).textTheme.bodyText1!.copyWith(
//                     fontWeight: FontWeight.bold,
//                     fontSize: 16,
//                     color:
//                         state.currentRoutine!.type == 1 ? orange : primaryColor,
//                   ),
//             ),
//           ],
//         ),
//         Row(
//           children: [
//             Row(
//               crossAxisAlignment: CrossAxisAlignment.start,
//               mainAxisAlignment: MainAxisAlignment.start,
//               children: [
//                 Text(
//                   "${zeroPrefix(context.select((TimerBloc bloc) => bloc.state.current.inMinutes))}:",
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//                 Text(
//                   zeroPrefix(
//                       context.select((TimerBloc bloc) => bloc.state.seconds)),
//                   style: Theme.of(context).textTheme.headline5!.copyWith(
//                         fontWeight: FontWeight.w900,
//                       ),
//                 ),
//               ],
//             ),
//             SizedBox(width: 10),
//             CustomButton(
//               "SKIP",
//               fontSize: 12.0,
//               fontWeight: FontWeight.w900,
//               textColor: Colors.white,
//               backgroundColor: primaryColor,
//               radius: 100,
//               height: 30,
//               width: 80,
//               onTap: () => _onRestSkip(context),
//             ),
//           ],
//         ),
//       ],
//     );
//   }

//   Widget activeWorkoutBar(BuildContext context, ActiveWorkoutState state) {
//     return Row(
//       mainAxisAlignment: MainAxisAlignment.spaceBetween,
//       crossAxisAlignment: CrossAxisAlignment.start,
//       children: [
//         Column(
//           crossAxisAlignment: CrossAxisAlignment.start,
//           children: [
//             Text(
//               state.currentExercise?.name ?? "",
//               style: Theme.of(context).textTheme.headline6!.copyWith(
//                     color: black,
//                     fontWeight: FontWeight.w900,
//                     fontSize: 18,
//                   ),
//             ),
//             Text(
//               "${Routine.typeIntToString(state.currentRoutine!.type)} ${state.currentRoutine!.iteration}",
//               style: Theme.of(context).textTheme.bodyText2!.copyWith(
//                     color:
//                         state.currentRoutine!.type == 1 ? orange : primaryColor,
//                     fontWeight: FontWeight.bold,
//                   ),
//             ),
//           ],
//         ),
//         Container(
//           width: 36,
//           height: 36,
//           decoration: BoxDecoration(
//             color: primaryColor,
//             borderRadius: BorderRadius.circular(100),
//           ),
//           child: IconButton(
//             padding: EdgeInsets.zero,
//             onPressed: () =>
//                 _onRoutineCompleted(context, state.currentRoutine!),
//             icon: Icon(CupertinoIcons.forward, size: 20),
//             color: Colors.white,
//           ),
//         )
//       ],
//     );
//   }

//   Widget _mapStateBar(BuildContext context, ActiveWorkoutState state) {
//     if (state is ActiveWorkoutWorking)
//       return activeWorkoutBar(context, state);
//     else if (state is ActiveWorkoutRest)
//       return restWorkoutBar(context, state);
//     else
//       return SizedBox.shrink();
//   }

//   @override
//   Widget build(BuildContext context) {
//     return BlocBuilder<ActiveWorkoutBloc, ActiveWorkoutState>(
//       builder: (context, state) {
//         if (state.currentRoutine == null) return SizedBox.shrink();
//         return Stack(children: [
//           GestureDetector(
//             behavior: HitTestBehavior.translucent,
//             onTap: () =>
//                 BlocProvider.of<AppPanelBloc>(context).add(AppPanelOpened()),
//             onLongPressStart: (_) =>
//                 BlocProvider.of<AppPanelBloc>(context).add(AppPanelOpened()),
//             child: Container(
//               height: 80,
//               width: double.infinity,
//               padding:
//                   EdgeInsets.only(top: 10, bottom: 10, left: 15, right: 12),
//               child: _mapStateBar(context, state),
//             ),
//           ),
//           // SlideIndicator(),
//         ]);
//       },
//     );
//   }
// }
