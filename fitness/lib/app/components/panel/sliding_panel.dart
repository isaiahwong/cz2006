import 'package:fitness/app/components/panel/sliding_panel_controller.dart';
import 'package:fitness/app/components/panel/sliding_panel_status.dart';
import 'package:flutter/material.dart';
import 'package:sliding_up_panel/sliding_up_panel.dart';
import 'package:get/get.dart';
import 'package:fitness/app/components/panel/sliding_indicator.dart';

class SlideUpNavObserver extends NavigatorObserver {
  final BuildContext context;

  SlideUpNavObserver(this.context);

  /// Listener for when panel is being dismissed
  @override
  void didPop(Route<dynamic> route, Route<dynamic>? previousRoute) {
    super.didPop(route, previousRoute);
    // Resets Panel State
    // context.read<SlidingPanelBloc>().add(SlidingPanelOpened());
  }
}

/// SlidingPanel incorporates bloc to SlidingUpPanel.
/// StatefulWidget is used as hot reload causes _pc isAttached error
class SlidingPanel extends StatefulWidget {
  final Widget child;
  final double? maxHeight;
  final bool backdrop;
  final Color backdropColor;
  final double backdropOpacity;

  /// Disables touch event behind panel
  final bool disableBody;

  SlidingPanel({
    Key? key,
    required this.child,
    this.maxHeight,
    this.backdrop = true,
    this.backdropColor = Colors.black,
    this.backdropOpacity = 0.6,
    this.disableBody = false,
  }) : super(key: key);

  @override
  _SlidingPanelState createState() => _SlidingPanelState();
}

class _SlidingPanelState extends State<SlidingPanel> {
  double calPanelMinHeight(double height, SlidingPanelStatus event) {
    if (event is SlidingPanelOpened)
      return height * 0.2;
    else if (event is SlidingPanelSticky)
      return height * 0.89;
    else
      return 0;
  }

  @override
  Widget build(BuildContext context) {
    final maxPanelHeight = MediaQuery.of(context).size.height * 0.82;

    return GetBuilder<SlidingPanelController>(
      builder: (slidingPanelController) {
        double minPanelHeight = calPanelMinHeight(
            MediaQuery.of(context).size.height, slidingPanelController.status);

        return SlidingUpPanel(
          controller: slidingPanelController.controller,
          onPanelClosed: () => slidingPanelController.closed(),

          /// Dismisses keyboard when slider is below 60% panel width
          onPanelSlide: (s) =>
              s < 0.6 ? FocusScope.of(context).unfocus() : null,
          backdropTapClosesPanel: false,
          backdropEnabled: widget.backdrop,
          backdropColor: widget.backdropColor,
          backdropOpacity: widget.backdropOpacity,
          isDraggable: !(slidingPanelController.status is SlidingPanelFixed),
          renderPanelSheet: true,
          borderRadius: BorderRadius.only(
              topLeft: Radius.circular(18.0), topRight: Radius.circular(18.0)),
          panel: Scaffold(
            backgroundColor: Colors.white,
            // Padding is added  as gesture behind 20px is not detected
            body: Container(
              child: Stack(children: [
                Padding(
                    padding: EdgeInsets.only(top: 22),
                    child: slidingPanelController
                        .panel(SlideUpNavObserver(context))),
                Positioned(
                  top: 10,
                  right: 0,
                  left: 0,
                  child: SlideIndicator(),
                ),
              ]),
            ),
          ),
          // panelBuilder: (ScrollController sc) => state.panel!(sc),
          minHeight: minPanelHeight, // Closes panel when state is closed
          maxHeight: widget.maxHeight ?? maxPanelHeight,
          body: IgnorePointer(
            ignoring: widget.disableBody &&
                (slidingPanelController.status is SlidingPanelOpened ||
                    slidingPanelController.status is SlidingPanelSticky),
            child: widget.child,
          ),
        );
      },
    );
  }
}
