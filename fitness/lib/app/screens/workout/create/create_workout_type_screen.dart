part of 'create_workout_screen.dart';

class CreateWorkoutTypeScreen extends GetView<CreateWorkoutController> {
  static Page page() => CupertinoPage<void>(child: CreateWorkoutTypeScreen());

  const CreateWorkoutTypeScreen({Key? key}) : super(key: key);

  void resetPanel(BuildContext context) {
    context
        .flow<CreateWorkoutRoute>()
        .update((_) => CreateWorkoutRoute.NEW_WORKOUT_MAIN);
  }

  List<Widget> items(BuildContext context) {
    return Workout.workoutTypes()
        .entries
        .map<Widget>(
          (w) => Column(
            children: [
              CustomTile(
                title: w.value,
                trailing: w.key == controller.type.index
                    ? Icon(
                        CupertinoIcons.checkmark_alt,
                        color: green,
                      )
                    : null,
                onTap: () {
                  resetPanel(context);
                  controller.onTypeChanged(Workout.intToType(w.key));
                },
              ),
              Divider(color: lightGrey),
            ],
          ),
        )
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(15.0),
        color: Colors.white,
      ),
      child: Column(
        children: [
          Padding(
            padding: screenPadding.copyWith(top: 20.0),
            child: Row(
              children: [
                GestureDetector(
                  child: Icon(CupertinoIcons.chevron_back),
                  onTap: () => resetPanel(context),
                ),
                SizedBox(width: 20),
                Text(
                  "Workout Type",
                  style: Theme.of(context)
                      .textTheme
                      .headline5!
                      .copyWith(color: darkGrey),
                )
              ],
            ),
          ),
          SizedBox(
            height: 20.0,
          ),
          Divider(color: lightGrey),
          ...items(context),
        ],
      ),
    );
  }
}
