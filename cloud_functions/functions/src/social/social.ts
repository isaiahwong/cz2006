import admin = require("firebase-admin");
import helper = require("../helper");
import * as functions from "firebase-functions";
import p = require("../paths");
import m = require("../model/model");


/**
 * To send friend requests
 * @param {string} initiatorId
 * @param {string} responderId
 */
exports.sendRequest = functions
    .region(helper.FUNCTION_REGION)
    .https
    .onCall(async (data, context)=> {
      if (!context.auth) {
        throw new functions
            .https
            .HttpsError("unauthenticated", "User not authenticated");
      }

      if (data.initiatorId == null || data.responderId == null) {
        throw new functions
            .https
            .HttpsError("invalid-argument", "Arguments not found");
      }

      const initiatorId: string = data.initiatorId;
      const responderId: string = data.responderId;

      const initiator = await helper.getUser(initiatorId);
      const responder = await helper.getUser(responderId);

      // Construct a friend requests
      const request: m.user.FriendRequest = {
        createdAt: admin.firestore.Timestamp.now().toMillis(),
        initiator: helper.getSnippet(initiator),
        responder: helper.getSnippet(responder),
        status: m.user.SocialStatus.PENDING,
      };

      // Add to both user
      const collectionRef = admin.firestore().collection(p.Collection.users);
      // Initiator
      await collectionRef
          .doc(initiatorId)
          .collection(p.UserSubCollections.requests)
          .add(request);
      // Responder
      await collectionRef
          .doc(responderId)
          .collection(p.UserSubCollections.requests)
          .add(request);

      console.log("sendRequest()");
      return;
    });


/**
 * Accept or decline friend requests
 * @param {string} requestId
 * @param {boolean} response
 * @return {Promise}
 */
exports.respondRequest = functions
    .region(helper.FUNCTION_REGION)
    .https
    .onCall(async (data, context)=> {
      if (!context.auth) {
        throw new functions
            .https
            .HttpsError("unauthenticated", "User not authenticated");
      }
      if (data.requestId == null || data.response == null ) {
        throw new functions
            .https
            .HttpsError("invalid-argument", "arguments not found");
      }
      const requestId: string = data.requestId;
      const requestResponse: boolean = data.response;
      const usersCol = admin
          .firestore()
          .collection(p.Collection.users);
      // Friend Request path
      const requestColRef = usersCol
          .doc(context.auth.uid)
          .collection(p.UserSubCollections.requests)
          .doc(requestId);
      const snapshot = await requestColRef.get();
      if (!snapshot.exists) {
        throw new functions
            .https
            .HttpsError("not-found", "friend request document not found");
      }
      const friendRequest: m.user.FriendRequest =
        JSON.parse(JSON.stringify(snapshot.data()));
      // Add users to friend sub collection
      if (requestResponse) {
        // For initiator add responder
        await usersCol
            .doc(friendRequest.initiator.id)
            .collection(p.UserSubCollections.friends)
            .add(await helper.getUser(friendRequest.responder.id));

        // For responder add responder
        await usersCol
            .doc(friendRequest.responder.id)
            .collection(p.UserSubCollections.friends)
            .add(await helper.getUser(friendRequest.initiator.id));
      }

      // Remove friend request from collection for both user
      await requestColRef.delete();
      await usersCol
          .doc(friendRequest.initiator.id)
          .collection(p.UserSubCollections.requests)
          .doc(requestId)
          .delete();

      console.log("repondRequest()");
      return;
    });

