import 'package:fitness/app/screens/explore/components/invitation_component.dart';
import 'package:fitness/app/screens/screens.dart';
import 'package:flutter/material.dart';
import 'package:get/get.dart';

class InvitationScreen extends StatelessWidget {
  const InvitationScreen({Key? key}) : super(key: key);

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Container(
        width: Get.width,
        padding: EdgeInsets.symmetric(vertical: 8, horizontal: 8),
        child: GetBuilder<SocialController>(
            id: "InvitationScreen",
            builder: (_) {
              if (_.workoutInviteLength == 0) {
                return Center(child: Text("No invitations yet"));
              }
              return ListView.builder(
                  itemCount: _.workoutInviteLength,
                  itemBuilder: (context, index) {
                    return InvitationComponent(
                      _.getWorkoutInvitation[index].creator,
                      [],
                    );
                  });
            }),
      ),
    );
  }
}
