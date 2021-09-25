import 'package:fitness/app/components/image/image.dart';
import 'package:fitness/app/theme/theme.dart';
import 'package:flutter/material.dart';
import 'card.dart';

class ColumnCard extends StatelessWidget {
  final double? width;
  final double height;
  final String title;
  final String subtitle;
  final String statusBarTitle;
  final String statusBarSubtitle;
  final Widget? statusBarSubtitleWidget;

  final CardType? type;
  final VoidCallback? onTap;

  const ColumnCard({
    Key? key,
    required this.height,
    this.width,
    this.title = "",
    this.subtitle = "",
    this.statusBarTitle = "",
    this.statusBarSubtitle = "",
    this.onTap,
    this.statusBarSubtitleWidget,
    this.type = CardType.CARD,
  }) : super(key: key);

  Widget _title(BuildContext context) {
    return Row(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        // CircleIcon(
        //   width: 40,
        //   height: 40,
        //   padding: 8,
        //   icon: dumbbellIcon,
        // ),
        // SizedBox(width: 6.0),
        Container(
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                title,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context)
                    .textTheme
                    .headline5!
                    .copyWith(color: black),
                maxLines: 2,
              ),
              Text(
                subtitle,
                overflow: TextOverflow.ellipsis,
                style: Theme.of(context).textTheme.headline6!.copyWith(
                      color: Colors.grey[600],
                      fontWeight: FontWeight.normal,
                      fontSize: 13.0,
                    ),
                maxLines: 1,
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _statusBar(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            Text(
              statusBarTitle,
              style: Theme.of(context)
                  .textTheme
                  .headline4!
                  .copyWith(fontWeight: FontWeight.w900),
            ),
            Text(
              statusBarSubtitle,
              style: Theme.of(context).textTheme.headline5!.copyWith(
                    color: accentColor,
                    fontWeight: FontWeight.w900,
                  ),
            ),
          ],
        ),
        // CustomButton(
        //   "EDIT",
        //   backgroundColor: grey,
        //   radius: 76.0,
        //   height: 20,
        //   width: 40.0,
        //   fontSize: 12.0,
        //   fontWeight: FontWeight.w900,
        //   // onTap: onTap,
        // ),
      ],
    );
  }

  Widget newCard(BuildContext context) {
    return Center(
      child: Container(
        width: 60,
        child: plusIcon,
      ),
    );
  }

  Widget card(BuildContext context) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        _title(context),
        _statusBar(context),
      ],
    );
  }

  Widget render(BuildContext context) {
    switch (type) {
      case CardType.NEW_CARD:
        return newCard(context);
      default:
        return card(context);
    }
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      child: Container(
        width: width,
        height: height,
        padding: EdgeInsets.only(top: 20, bottom: 20, left: 15, right: 16),
        child: render(context),
        decoration: boxShadow,
      ),
    );
  }
}
