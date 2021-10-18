import admin = require("firebase-admin");
import helper = require("../helper");
import * as functions from "firebase-functions";
import p = require("../paths");
import m = require("../model/model");

/**
 * Can be either private or public
 * * Set during creation
 * * Owner should also be include in participant[]
 * @param {m.workout.WorkoutGroup} workoutGroup
 */
exports.createWorkoutGroup = functions
    .region(helper.FUNCTION_REGION)
    .https
    .onCall(async (data, context) => {
      // if (!context.auth) {
      //   throw new functions
      //       .https
      //       .HttpsError("unauthenticated", "User not authenticated");
      // }
      if (data.workoutGroup == null) {
        throw new functions
            .https
            .HttpsError("invalid-argument", "arguments invalid");
      }
      const workoutGroup: m.workout.WorkoutGroup =
            JSON.parse(JSON.stringify(data.workoutGroup));

      const workoutGroupRef: admin.firestore.CollectionReference = admin
          .firestore()
          .collection(p.Collection.workoutGroup);

      await workoutGroupRef.add(workoutGroup);


      return Promise.resolve();
    });

/**
 * Join workout group (public/private)
 * workout group id will be add to subcollection
 * @param {string} workoutGroupId
 * @return {Map<string, any>} result
 */
exports.joinWorkoutGroup = functions
    .region(helper.FUNCTION_REGION)
    .https.onCall(async (d, c) => {
      if (!c.auth) {
        throw new functions
            .https
            .HttpsError("unauthenticated", "User not authenticated");
      }
      if (d.workoutGroupId == null) {
        throw new functions
            .https
            .HttpsError("invalid-argument", "Invalid argument");
      }
      const workoutGroupId: string = d.workoutGroupId;

      const workoutGroupRef = admin
          .firestore()
          .collection(p.Collection.workoutGroup);
        // Find workout group
      const doc = await workoutGroupRef.doc(workoutGroupId).get();
      const userId = c.auth.uid;
      if (!doc.exists) {
        throw new functions
            .https
            .HttpsError("not-found", "Workout not available");
      }
      const workoutGroup: m.workout.WorkoutGroupWithId =
            JSON.parse(JSON.stringify(doc.data()));

      // Check if user eligible to join
      if (
        workoutGroup.participants.length >= workoutGroup.maxParticipants ||
            !workoutGroup.isPublic
      ) {
        return {
          "result": false,
          "message": "Unable to join group",
        };
      }
      // Check if user already in group
      for (let i = 0; i < workoutGroup.participants.length; i++) {
        if (workoutGroup.participants[i].id == userId) {
          console.log("User already in group");
          return {
            "result": false,
            "message": "User already in group",
          };
        }
      }
      const currentUser: m.user.User = await helper.getUser(userId);
      // Add user into group by update document
      await doc.ref.update({
        "maxParticipants": admin.firestore.FieldValue.increment,
        "participants": admin.firestore.FieldValue.arrayUnion([currentUser]),
      });

      // If workout is private, remove from user's invite sub collection
      if (!workoutGroup.isPublic) {
        await admin
            .firestore()
            .collection(p.Collection.users)
            .doc(currentUser.id)
            .collection(p.UserSubCollections.invites)
            .doc(workoutGroup.id)
            .delete();
      }

      // Update to their personal workoutinvites collection
      await admin
          .firestore()
          .collection(p.UserSubCollections.workoutInvites)
          .add(<m.workout.GroupWorkout>{
            isActive: true,
            workoutGroupId: workoutGroupId,
            creator: workoutGroup.creator,
          });
      return {
        "result": true,
        "message": "Joined successful",
      };
    });

// TODO: Decline invitation can be done on client side?

/**
 * Invite user to workout
 * add to user (invite) subcollection
 * @param {string} workoutGroupId: document id to workoutgroup
 * @param {string} userId
 * @return {Map<string, any>} result
 */
exports.inviteWorkout = functions
    .region(helper.FUNCTION_REGION)
    .https
    .onCall(async (d, c) => {
      if (!c.auth) {
        throw new functions
            .https
            .HttpsError("unauthenticated", "User not authenticated");
      }
      // Check arguments
      if (d.workoutGroupId == null || d.userId == null) {
        throw new functions
            .https
            .HttpsError("invalid-argument", "Arguments invalid");
      }

      const workoutGroupId: string = d.workoutGroupId;
      const userId: string = d.userId;

      const userRef = admin.firestore().collection(p.Collection.users);

      const workoutGroupRef = admin
          .firestore()
          .collection(p.Collection.workoutGroup);
      const workoutGroupDoc = await workoutGroupRef.doc(workoutGroupId).get();
      const userDoc = await userRef.doc(userId).get();
      if (!workoutGroupDoc.exists) {
        throw new functions
            .https
            .HttpsError("not-found", "Workout group not found");
      }
      if (!userDoc.exists) {
        throw new functions
            .https
            .HttpsError("not-found", "User not found");
      }

      const workoutGroup: m.workout.WorkoutGroupWithId =
            JSON.parse(JSON.stringify(workoutGroupDoc.data()));

      if (workoutGroup.participants.length >= workoutGroup.maxParticipants) {
        return {
          "result": false,
          "message": "Group at max capacity",
        };
      }
      if (!workoutGroup.isActive) {
        return {
          "result": false,
          "message": "Workout ended",
        };
      }
      // Check if user already in workout group
      for (let i = 0; i < workoutGroup.participants.length; i++) {
        const user = workoutGroup.participants[i];
        if (user.id == userId) {
          return {
            "result": false,
            "message": "User already in group",
          };
        }
      }
      // Send invitation to user
      await userRef
          .doc(userId)
          .collection(p.UserSubCollections.invites)
          .doc(workoutGroupId)
          .set(<m.workout.GroupWorkout>{
            isActive: true,
            creator: workoutGroup.creator,
            workoutGroupId,
          });
      return {
        "result": true,
        "message": "Invitation sent",
      };
    });

/**
 * Update workout status to all users
 * @param {string} workoutGroupId
 * @param {boolean} isActive : for isActive field
 * @returns {Promise<void>}
 */
exports.setWorkoutStatus = functions
    .region(helper.FUNCTION_REGION)
    .https
    .onCall(async (d, c)=> {
      if (!c.auth) {
        throw new functions
            .https
            .HttpsError("unauthenticated", "User not authenticated");
      }
      // Check arguments
      if (d.workoutGroupId == null || d.isActive == null) {
        throw new functions
            .https
            .HttpsError("invalid-argument", "Argument invalid");
      }
      const workoutGroupId: string = d.workoutGroupId;
      const isActive:boolean = d.isActive;

      const usersRef = admin.firestore().collection(p.Collection.users);
      const workoutGroupRef = admin
          .firestore()
          .collection(p.Collection.workoutGroup);
      const result = await workoutGroupRef.doc(workoutGroupId).get();
      if (!result.exists) {
        throw new functions
            .https
            .HttpsError("not-found", "Workout group not found");
      }
      // Update on on main document
      await result.ref.update({"isActive": isActive});

      const workoutGroup: m.workout.WorkoutGroupWithId =
      JSON.parse(JSON.stringify(result.data()));
      for await (const user of workoutGroup.participants) {
        // Update sub collection for other participants
        if (user.id != workoutGroup.creator) {
          await usersRef
              .doc(user.id)
              .collection(p.UserSubCollections.workoutInvites)
              .doc(workoutGroup.id)
              .update({"isActive": isActive});
        }
      }
      return Promise.resolve();
    });


