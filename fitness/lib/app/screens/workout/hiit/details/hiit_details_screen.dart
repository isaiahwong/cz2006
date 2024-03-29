import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/panel/sliding_panel.dart';
import 'package:fitness/app/routes/routes.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/workout/model/model.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter_keyboard_visibility/flutter_keyboard_visibility.dart';
import 'package:get/get.dart';

import 'hiit_details_controller.dart';

class HIITDetailsScreen extends GetView<HIITDetailsController> {
  HIITDetailsScreen({Key? key}) : super(key: key);

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      pinned: true,
      toolbarHeight: 100.0,
      backgroundColor: Colors.transparent,
      leading: SizedBox.shrink(),
      flexibleSpace: FlexibleSpaceBar(
        title: Container(
          width: double.infinity,
          padding: EdgeInsets.only(top: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Container(
                    height: 45,
                    child: IconButton(
                      padding: EdgeInsets.zero,
                      icon: Icon(
                        CupertinoIcons.chevron_back,
                        size: 30,
                      ),
                      color: primaryColor,
                      onPressed: () => Get.back(),
                    ),
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }

  Widget _title(BuildContext context) {
    return SliverToBoxAdapter(
      child: NakedTextField(
        controller: controller.hiitNameController,
        onChanged: controller.onEdit,
        hintText: controller.hiit.name,
        textAlign: TextAlign.center,
        style: Theme.of(context)
            .textTheme
            .headline2!
            .copyWith(fontWeight: FontWeight.w900),
        hintStyle: Theme.of(context).textTheme.headline2!.copyWith(
              fontWeight: FontWeight.w900,
              color: controller.editing ? accentColor : primaryColor,
            ),
      ),
    );
  }

  Widget _item(
    BuildContext context, {
    required String title,
    required Widget trailing,
    VoidCallback? onPressed,
  }) {
    return GestureDetector(
      onTap: onPressed,
      child: Container(
        height: 60,
        padding: EdgeInsets.only(left: 20, right: 20),
        decoration: BoxDecoration(
          color: grey,
          borderRadius: BorderRadius.circular(50),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            Text(
              title,
              style: Theme.of(context).textTheme.headline6,
            ),
            trailing
          ],
        ),
      ),
    );
  }

  Widget _newRoutine(BuildContext context) {
    return Column(
      children: [
        _item(
          context,
          onPressed: controller.onNewRoutine,
          title: "New",
          trailing: IconButton(
            onPressed: () {},
            color: primaryColor,
            alignment: Alignment.centerRight,
            icon: Icon(CupertinoIcons.add_circled_solid),
          ),
        ),
        SizedBox(height: 10),
        controller.hasNoRoutines
            ? Text(
                "Need to add at least one routine before starting!",
                textAlign: TextAlign.center,
                style: Theme.of(context).textTheme.headline3!.copyWith(
                      color: green,
                      fontWeight: FontWeight.bold,
                      fontSize: 14,
                    ),
              )
            : SizedBox.shrink()
      ],
    );
  }

  Widget _routineItem(BuildContext context, Routine routine) {
    return _item(
      context,
      title: routine.exercise.name,
      trailing: Row(
        children: [
          Text(
            "${routine.sets.toString()} Sets",
            style: Theme.of(context).textTheme.headline6,
          )
        ],
      ),
    );
  }

  Widget _body(BuildContext context) {
    return SliverToBoxAdapter(
      child: KeyboardDismissOnTap(
        child: Container(
          padding: screenPadding,
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: margin(
              children: [
                _newRoutine(context),
                ...controller.hiit.routines
                    .map<Widget>((routine) => _routineItem(context, routine))
                    .toList()
              ],
              margin: EdgeInsets.only(bottom: 15),
            ),
          ),
        ),
      ),
    );
  }

  Widget _start(BuildContext context) {
    final width = MediaQuery.of(context).size.width * 0.9 / 2;
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
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          CustomButton(
            "SOLO",
            radius: 20,
            width: width,
            textColor: Colors.white,
            backgroundColor: primaryColor,
            onPressed: controller.onSoloStart,
          ),
          CustomButton(
            "DUO",
            radius: 20,
            width: width,
            textColor: Colors.white,
            backgroundColor: green,
            onPressed: controller.onDuoStart,
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return SlidingPanel(
      tag: RoutePaths.HIIT_DETAILS,
      child: GetBuilder<HIITDetailsController>(
        builder: (_) => Scaffold(
          backgroundColor: lightGrey,
          body: SafeArea(
            child: Stack(
              children: [
                Padding(
                  padding: screenPadding,
                  child: CustomScrollView(
                    controller: ScrollController(),
                    slivers: [
                      _appBar(context),
                      _title(context),
                      SliverToBoxAdapter(child: SizedBox(height: 80)),
                      _body(context),
                    ],
                  ),
                ),
                Align(
                  alignment: Alignment.bottomCenter,
                  child: _start(context),
                )
              ],
            ),
          ),
        ),
      ),
    );
  }
}
