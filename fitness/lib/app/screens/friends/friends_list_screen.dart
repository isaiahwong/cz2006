import 'package:fitness/app/components/components.dart';
import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:fitness/repo/repo.dart';
import 'package:flutter/material.dart';
import 'package:flutter/cupertino.dart';
import 'package:get/get.dart';

import 'friends_controller.dart';

class FriendsListScreen extends GetView<FriendsController> {
  static Page page(
          {ScrollController? scrollController,
          FriendsController? friendsController}) =>
      CupertinoPage<void>(
        child: GetBuilder(
          init: friendsController,
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
      automaticallyImplyLeading: false,
      pinned: true,
      toolbarHeight: 70.0,
      backgroundColor: Colors.white,
      flexibleSpace: FlexibleSpaceBar(
        title: Padding(
          padding: screenPadding.copyWith(top: 20.0),
          child: Container(
            width: double.infinity,
            color: Colors.white,
            child: Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Expanded(
                      child: Padding(
                        padding: EdgeInsets.only(right: 10, left: 10),
                        child: NakedTextField(
                          hintText: "Search",
                          onChanged: (q) => controller.onFilter(q),
                          fontSize:
                              Theme.of(context).textTheme.headline5!.fontSize,
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
                      onPressed: () => controller.delegateController
                          .onFriendsSelectionDone(),
                    ),
                  ],
                ),
                controller.showError
                    ? Text(
                        "Participants limit reached!",
                        style: Theme.of(context).textTheme.bodyText1!.copyWith(
                              color: red,
                            ),
                      )
                    : SizedBox.shrink(),
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
            CupertinoIcons.clear_circled,
            color: red,
          )
        : const Icon(
            CupertinoIcons.add_circled,
            color: primaryColor,
          );
  }

  List<Widget> _friends(BuildContext context) {
    return controller.filteredFriends
        .map(
          (ex) => SliverToBoxAdapter(
            child: CustomTile(
              crossAxisAlignment: CrossAxisAlignment.center,
              leading: Container(
                width: 35,
                height: 35,
                child: UserImage(
                  user: ex.friend,
                ),
              ),
              title: ex.friend.name,
              trailing: _trailing(ex),
              onTap: () => controller.isSelected(ex)
                  ? controller.onRemove(ex)
                  : controller.onSelected(ex),
            ),
          ),
        )
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
