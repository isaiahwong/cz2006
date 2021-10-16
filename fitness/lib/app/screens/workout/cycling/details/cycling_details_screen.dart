import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/panel/sliding_panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:flutter_mapbox_navigation/library.dart';
import 'package:get/get.dart';

class CyclingDetailsScreen extends GetView<CyclingDetailsController> {
  CyclingDetailsScreen({Key? key}) : super(key: key);

  Widget _backButton(BuildContext context) {
    return FloatingActionButton(
      mini: true,
      heroTag: "back",
      child: const Icon(
        Icons.arrow_back,
        color: Colors.black,
      ),
      onPressed: () => Get.back(),
      backgroundColor: Colors.white,
    );
  }

  Container _mapboxUI(BuildContext context) {
    return Container(
      child: Column(
        children: [
          GetBuilder<CyclingDetailsController>(
            builder: (_) => Container(
              height: 200,
              child: MapBoxNavigationView(
                options: controller.mapboxOptions,
                onCreated: (MapBoxNavigationViewController mapboxController) =>
                    controller.setMapBoxController(mapboxController),
              ),
            ),
          ),
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SliverToBoxAdapter(
      child: Container(
        padding: screenPadding,
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            _cyclingDetails(context),
            SizedBox(
              height: 30,
            ),
            _friends(context)
          ],
        ),
      ),
    );
  }

  Widget _cyclingDetails(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          controller.cycling.name,
          style: TextStyle(fontWeight: FontWeight.w600, fontSize: 35),
        ),
        SizedBox(
          height: 10,
        ),
        Text(
          "Starting Location: " +
              controller.cycling.course[0].start.name +
              " \nDestination: " +
              controller.cycling.course[0].end.name,
          style: TextStyle(
              fontWeight: FontWeight.w300, fontSize: 17, color: Colors.black),
        ),
      ],
    );
  }

  Widget _friends(BuildContext context) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          "Friends",
          style: TextStyle(
            fontWeight: FontWeight.w400,
            fontSize: 25,
            color: Colors.black,
          ),
        ),
        SizedBox(
          height: 10,
        ),
        //TODO implement add friend
        Row(children: [
          OutlinedButton(
            onPressed: () => print("WIP"),
            child: Icon(
              Icons.add,
              color: Colors.black,
            ),
            style: TextButton.styleFrom(
              minimumSize: Size(50, 50),
              shape: CircleBorder(),
              backgroundColor: Colors.transparent,
            ),
          ),
        ]),
      ],
    );
  }

  Widget _start(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9;
    return Container(
      height: 80,
      width: double.infinity,
      decoration: BoxDecoration(
        color: lightGrey,
        boxShadow: [
          BoxShadow(
            blurRadius: 1.0,
            offset: Offset(0, -1),
            color: Color.fromRGBO(0, 0, 0, 0.1),
          )
        ],
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          CustomButton(
            "START",
            radius: 20,
            width: width,
            textColor: Colors.white,
            backgroundColor: primaryColor,
            onPressed: controller.onCyclingStart,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingPanel(
        tag: RoutePaths.CYCLING_DETAILS,
        child: GetBuilder<CyclingDetailsController>(
          builder: (_) => Scaffold(
            floatingActionButtonLocation:
                FloatingActionButtonLocation.miniStartTop,
            floatingActionButton: _backButton(context),
            backgroundColor: lightGrey,
            body: SafeArea(
              child: Column(
                children: [
                  Container(
                    child: _mapboxUI(context),
                  ),
                  Expanded(
                    child: SizedBox(
                      height: 300,
                      child: CustomScrollView(
                        controller: ScrollController(),
                        slivers: [
                          SliverToBoxAdapter(child: SizedBox(height: 20)),
                          _body(context),
                        ],
                      ),
                    ),
                  ),
                  Align(
                    alignment: Alignment.bottomCenter,
                    child: _start(context),
                  ),
                ],
              ),
            ),
          ),
        ));
  }
}
