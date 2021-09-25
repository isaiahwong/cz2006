part of 'exercise.dart';

class ExerciseListScreen extends GetView<ExerciseController> {
  static Page page(
          {ScrollController? scrollController,
          ExerciseController? exerciseController}) =>
      CupertinoPage<void>(
        child: GetBuilder(
          init: exerciseController,
          builder: (_) => ExerciseListScreen(
            scrollController: scrollController,
          ),
        ),
      );

  static Widget component(
      {ScrollController? scrollController,
      ExerciseController? exerciseController}) {
    return GetBuilder(
      init: exerciseController,
      builder: (_) => ExerciseListScreen(
        scrollController: scrollController,
      ),
    );
  }

  final ScrollController? scrollController;

  const ExerciseListScreen({
    Key? key,
    this.scrollController,
  }) : super(key: key);

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      pinned: true,
      toolbarHeight: 20.0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: screenPadding.copyWith(top: 20.0),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Expanded(
                  child: Padding(
                    padding: EdgeInsets.only(right: 10, left: 10),
                    child: NakedTextField(
                      hintText: "Search",
                      onChanged: (q) => controller.onFilter(q),
                      fontSize: Theme.of(context).textTheme.headline5!.fontSize,
                    ),
                  ),
                ),
                CustomButton(
                  "Done",
                  fontSize: 18,
                  width: 66,
                  height: 40,
                  radius: 5.0,
                  textColor: accentColor,
                  onPressed: () =>
                      controller.delegateController.onExerciseSelectionDone(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List<Widget> _exerciseItems(
    BuildContext context,
  ) {
    return controller.filteredExercises
        .map((ex) => SliverToBoxAdapter(child: ExerciseTile(exercise: ex)))
        .toList();
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      // decoration: boxShadowTop,
      color: Colors.white,
      child: CustomScrollView(
        controller: ScrollController(),
        slivers: <Widget>[
          _appBar(context),
          ..._exerciseItems(context),
        ],
      ),
    );
  }
}
