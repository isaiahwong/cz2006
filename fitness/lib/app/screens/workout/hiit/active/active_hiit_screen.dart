import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/panel/panel.dart';
import 'package:fitness/app/screens/workout/hiit/active/active.dart';
import 'package:fitness/app/screens/workout/hiit/active/components/components.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/workout.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class ActiveHIITScreen extends GetView<ActiveHIITController> {
  // static Route route(Workout workout) {
  //   final appPanelBloc = AppPanelBloc(
  //     // panel: CurrentRoutinePanel(),
  //     panelHeader: CurrentRoutinePanelHeader(),
  //   );

  //   final timerBloc = TimerBloc(ticker: Ticker());

  //   return MaterialPageRoute(
  //     builder: (context) => MultiBlocProvider(
  //       providers: [
  //         BlocProvider(
  //           create: (_) => ActiveWorkoutBloc(
  //             workoutsBloc: BlocProvider.of<WorkoutsBloc>(context),
  //             appPanelBloc: appPanelBloc,
  //             timerBloc: timerBloc,
  //             workout: workout,
  //           ),
  //         ),
  //         BlocProvider(create: (_) => appPanelBloc),
  //         BlocProvider(create: (_) => SlidingPanelBloc()),
  //         BlocProvider(create: (_) => timerBloc),
  //       ],
  //       child: ActiveHIITScreen(),
  //     ),
  //   );
  // }

  const ActiveHIITScreen({Key? key}) : super(key: key);

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 45.0,
      backgroundColor: Colors.white,
      leading: SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        titlePadding: screenPadding.copyWith(top: 10.0),
        title: Container(
          color: Colors.white,
          width: double.infinity,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    width: 75,
                    height: 25,
                    decoration: BoxDecoration(
                      color: primaryColor,
                      borderRadius: BorderRadius.circular(100),
                    ),
                    child: IconButton(
                      onPressed: () => print("hi"),
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        CupertinoIcons.add,
                        size: 18,
                      ),
                      color: Colors.white,
                    ),
                  ),
                  CustomButton(
                    "END",
                    fontSize: 13,
                    fontWeight: FontWeight.w900,
                    width: 75,
                    height: 25,
                    radius: 100.0,
                    textColor: Colors.white,
                    backgroundColor: red,
                    onPressed: () => Navigator.of(context).pop(),
                  ),
                ],
              ),
              Padding(
                padding: EdgeInsets.only(top: 10),
                child: Text(
                  controller.hiit.name,
                  style: Theme.of(context)
                      .textTheme
                      .headline3!
                      .copyWith(fontWeight: FontWeight.w900),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _routineSection(
    BuildContext context, {
    required Routine routine,
    RoutineInterval? currentInterval,
  }) {
    return Container(
      padding: EdgeInsets.only(bottom: 40),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            routine.exercise.name,
            style: Theme.of(context).textTheme.headline4!.copyWith(
                  color: black,
                  fontWeight: FontWeight.w900,
                ),
          ),
          SizedBox(
            height: 10,
          ),
          ...routine.intervals
              .map<Widget>(
                (routine) => IntervalItem(
                  interval: routine,
                  active: routine.id == currentInterval?.id,
                ),
              )
              .toList()
        ],
      ),
    );
  }

  List<Widget> _routineList(
    BuildContext context, {
    required List<Routine> routines,
    RoutineInterval? currentInterval,
  }) {
    return routines
        .map<Widget>((r) => _routineSection(
              context,
              routine: r,
              currentInterval: currentInterval,
            ))
        .toList();
  }

  Widget _body(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            ..._routineList(
              context,
              routines: controller.hiit.routines,
              currentInterval: controller.currentInterval,
            ),
          ],
        ),
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return WillPopScope(
      onWillPop: () async => Navigator.of(context).userGestureInProgress,
      child: SlidingPanel(
        maxHeight: MediaQuery.of(context).size.height * 0.68,
        disableBody: true,
        backdropOpacity: 0.2,
        child: FullScreenPanel(
          body: GetBuilder<ActiveHIITController>(
            builder: (controller) => Container(
              padding: EdgeInsets.only(top: 46),
              width: double.infinity,
              color: Colors.white,
              child: CustomScrollView(
                controller: ScrollController(),
                slivers: [
                  _appBar(context),
                  _body(context),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
