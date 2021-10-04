part of 'create_workout_screen.dart';

class CreateWorkoutMainScreen extends GetView<CreateWorkoutController> {
  static Page page() => CupertinoPage<void>(
        child: CreateWorkoutMainScreen(),
      );

  const CreateWorkoutMainScreen({Key? key}) : super(key: key);

  void saveWorkout() {
    controller.onSubmit();
    // if (state.status.isSubmissionInProgress) return;
    // context.read<WorkoutBloc>().add(WorkoutSaved());
  }

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      pinned: true,
      toolbarHeight: 20.0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: screenPadding,
          child: Container(
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                GestureDetector(
                  onTap: () => controller.close(),
                  child: Text(
                    "Cancel",
                    style: Theme.of(context).textTheme.headline5!.copyWith(
                          color: red,
                        ),
                  ),
                ),
                CustomButton(
                  "Save",
                  fontSize: 17,
                  width: 66,
                  height: 50,
                  radius: 5.0,
                  textColor: Colors.white,
                  backgroundColor: primaryColor,
                  onPressed: () => saveWorkout(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _nameField(BuildContext context) {
    return Padding(
      padding: EdgeInsets.only(
        top: 20.0,
        left: 60.0,
        right: 30.0,
        bottom: 10.0,
      ),
      child: NakedTextField(
        hintText: "Workout Name 🏃🏼‍♂️",
        errorText:
            controller.name.invalid ? "Workout name is too long 🤯" : null,
        onChanged: (value) => controller.onNameChanged(value),
      ),
    );
  }

  Widget _typeTile(BuildContext context) {
    return CustomTile(
      title: Workout.typeToString(controller.type),
      leading: Icon(CupertinoIcons.grid, color: darkGrey),
      trailing: Icon(CupertinoIcons.chevron_forward, color: darkGrey),
      onTap: () {
        // context.read<SlidingPanelBloc>().add(SlidingPanelSticky());
        context
            .flow<CreateWorkoutRoute>()
            .update((_) => CreateWorkoutRoute.NEW_WORKOUT_TYPE);
      },
    );
  }

  Widget _exercisesGrid(BuildContext context) {
    return ReorderableWrap(
      onReorder: (oldIndex, newIndex) {},
      spacing: 10.0,
      runSpacing: 10.0,
      maxMainAxisCount: 2,
      children: controller.exercises
          .map((k, e) => MapEntry(k, Tag(title: e.name)))
          .values
          .toList(),
    );
  }

  Widget _exerciseTile(BuildContext context) {
    return CustomTile(
      title: "Add exercise",
      leading: Icon(CupertinoIcons.graph_circle, color: darkGrey),
      trailing: Icon(CupertinoIcons.chevron_forward, color: darkGrey),
      onTap: () {
        context
            .flow<CreateWorkoutRoute>()
            .update((_) => CreateWorkoutRoute.NEW_WORKOUT_EXERCISE);
      },
      child: controller.exercises.isNotEmpty ? _exercisesGrid(context) : null,
      // child: SizedBox.shrink(),
    );
  }

  Widget _cyclingTile(BuildContext context) {
    return CustomTile(
      title: "Add cycling paths",
      leading: Icon(CupertinoIcons.graph_circle, color: darkGrey),
      trailing: Icon(CupertinoIcons.chevron_forward, color: darkGrey),
      onTap: () {
        context
            .flow<CreateWorkoutRoute>()
            .update((_) => CreateWorkoutRoute.NEW_WORKOUT_CYCLING_PATHS);
      },
      // child: SizedBox.shrink(),
    );
  }

  Widget _activityTile(BuildContext context) {
    switch (controller.type) {
      case WorkoutType.CYCLING:
        return _cyclingTile(context);
      case WorkoutType.HIIT:
        return _exerciseTile(context);
      default:
        return SizedBox.shrink();
    }
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: boxShadowTop,
      child: CustomScrollView(
        controller: ScrollController(),
        slivers: <Widget>[
          _appBar(context),
          SliverToBoxAdapter(
            child: Column(
              children: [
                _nameField(context),
                Divider(color: lightGrey),
                _typeTile(context),
                Divider(color: lightGrey),
                _activityTile(context),
                Divider(color: lightGrey),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
