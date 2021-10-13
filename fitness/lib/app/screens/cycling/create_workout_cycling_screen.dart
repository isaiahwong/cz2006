part of 'coordinates.dart';

class CreateWorkoutCyclingScreen extends GetView<CoordinatesController> {
  static Page page(
          {ScrollController? scrollController,
          CoordinatesController? coordinatesController}) =>
      CupertinoPage<void>(
        child: GetBuilder(
          init: coordinatesController,
          builder: (_) => CreateWorkoutCyclingScreen(
            scrollController: scrollController,
          ),
        ),
      );

  static Widget component(
      {ScrollController? scrollController,
      CoordinatesController? coordinatesController}) {
    Get.lazyPut(() => CoordinatesRepo());
    return GetBuilder(
      init: coordinatesController,
      builder: (_) => CreateWorkoutCyclingScreen(
        scrollController: scrollController,
      ),
    );
  }

  final ScrollController? scrollController;
  final wayPoints = new ValueNotifier(<WayPoint>[]);

  CreateWorkoutCyclingScreen({
    Key? key,
    this.scrollController,
  }) : super(key: key);

  void goBack(BuildContext context) {
    context
        .flow<CreateWorkoutRoute>()
        .update((_) => CreateWorkoutRoute.NEW_WORKOUT_MAIN);
  }

  Widget _appBar(BuildContext context) {
    return Container(
      child: Row(
        mainAxisAlignment: MainAxisAlignment.end,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          CustomButton(
            "Done",
            fontSize: 18,
            width: 66,
            height: 40,
            radius: 5.0,
            textColor: accentColor,
            onPressed: () =>
                controller.delegateController.onCoordinatesSelectionDone(),
          ),
        ],
      ),
    );
  }

  //bool start - Start = true End = false

  Widget _selectLocation(BuildContext context, bool start) => ExpansionTile(
        title: start
            ? Text(
                "Starting Location",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w400),
              )
            : Text(
                "Destination",
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(fontWeight: FontWeight.w400),
              ),
        children: [
          Container(
            constraints: BoxConstraints(maxHeight: double.infinity),
            color: Colors.white,
            child: CustomScrollView(
              shrinkWrap: true,
              controller: ScrollController(),
              slivers: <Widget>[
                ..._coordinatesItems(context, start),
              ],
            ),
          ),
        ],
      );

  List<Widget> _coordinatesItems(
    BuildContext context,
    bool start,
  ) {
    return controller.filteredCoordinates
        .map(
          (c) => SliverToBoxAdapter(
            child: CoordinatesTile(
              onPressed: start
                  ? controller.onStartSelected
                  : controller.onDestinationSelected,
              coordinates: c,
              start: start,
            ),
          ),
        )
        .toList();
  }

  Container _mapboxUI(
      BuildContext context, ValueNotifier<List<WayPoint>> wayPoints) {
    return Container(
      child: MapWidget(),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Container(
      constraints: BoxConstraints(),
      color: Colors.white,
      child: Column(
        children: [
          _appBar(context),
          Column(
            children: [
              _mapboxUI(context, wayPoints),
              _selectLocation(context, true),
              _selectLocation(context, false),
            ],
          ),
        ],
      ),
    );
  }
}
