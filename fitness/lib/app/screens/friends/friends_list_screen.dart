import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'friends_controller.dart';

class FriendsListScreen extends GetView<FriendsController> {
  static Page page(
          {ScrollController? scrollController,
          FriendsController? exerciseController}) =>
      CupertinoPage<void>(
        child: GetBuilder(
          init: exerciseController,
          builder: (_) => FriendsListScreen(
            scrollController: scrollController,
          ),
        ),
      );

  static Widget component(
      {ScrollController? scrollController,
      FriendsController? exerciseController}) {
    return GetBuilder(
      init: exerciseController,
      builder: (_) => FriendsListScreen(
        scrollController: scrollController,
      ),
    );
  }

  final ScrollController? scrollController;

  const FriendsListScreen({
    Key? key,
    this.scrollController,
  }) : super(key: key);

  Widget _appBar(BuildContext context) {
    return SliverAppBar(
      shape:
          ContinuousRectangleBorder(borderRadius: BorderRadius.circular(15.0)),
      pinned: true,
      toolbarHeight: 22.0,
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
                      controller.delegateController.onFriendsSelectionDone(),
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  Widget _trailing(Friend friend) {
    return controller.isSelected(friend)
        ? const Icon(
            CupertinoIcons.paperplane,
            color: primaryColor,
          )
        : const Icon(
            CupertinoIcons.add_circled,
            color: primaryColor,
          );
  }

  List<Widget> _friends(BuildContext context) {
    return controller.filteredFriends
        .map((ex) => SliverToBoxAdapter(
                child: CustomTile(
              leading: Text(
                ex.friend.name,
                style: Theme.of(context).textTheme.headline4,
              ),
              trailing: _trailing(ex),
              onTap: () => controller.onSelected(ex),
            )))
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
          ..._friends(context),
        ],
      ),
    );
  }
}
