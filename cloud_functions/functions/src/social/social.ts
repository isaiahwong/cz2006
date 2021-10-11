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

      const initiator: m.user.UserSnippet =
      helper.getSnippet(await helper.getUser(initiatorId));


      const responder: m.user.UserSnippet =
      helper.getSnippet(await helper.getUser(responderId));

      // Construct a friend requests
      const request: m.user.Friend = {
        createdAt: admin.firestore.Timestamp.now().toMillis(),
        initiator: initiator,
        responder: responder,
        status: m.user.SocialStatus.PENDING,
      };

      // Add to both user
      const usersRef = admin.firestore().collection(p.Collection.users);

      // Check if requests already exists
      const initiatorfriendsRef = usersRef
          .doc(initiatorId)
          .collection(p.UserSubCollections.friends);

      let searchResult = await initiatorfriendsRef
          .where("responder.id", "==", responderId)
          .get();

      // Requests has already been sent
      if (!searchResult.empty) {
        console.log("Friend request already sent");
        return Promise.resolve();
      }

      // Check if relationship already exists
      searchResult = await initiatorfriendsRef
          .where("responder.id", "==", initiatorId)
          .where("status", "==", m.user.SocialStatus.PENDING)
          .get();

      if (!searchResult.empty) {
        console.log("User update status from pending to friend");
        // Update status from pending to friend
        for (let i=0; i< searchResult.docs.length; i++) {
          await searchResult
              .docs[i]
              .ref
              .update({"status": m.user.SocialStatus.FRIEND});
          // Update other user
          await usersRef
              .doc(responderId)
              .collection(p.UserSubCollections.friends)
              .doc(searchResult.docs[i].id)
              .update({"status": m.user.SocialStatus.FRIEND});
        }
        return Promise.resolve();
      }

      // Initiator

      const result = await initiatorfriendsRef.add(request);

      await result.update({"id": result.id});


      // Responder
      const friendRef = await usersRef
          .doc(responderId)
          .collection(p.UserSubCollections.friends)
          .doc(result.id);
      await friendRef.set(request);
      await friendRef.update({"id": result.id});


      console.log("sendRequest()");
      return Promise.resolve();
    });


/**
 * Accept or decline friend requests
 * @param {string} friendId
 * @param {boolean} response
 * @param {string} documentId
 * @return {Promise}
 */
exports.respondRequest = functions
    .region(helper.FUNCTION_REGION)
    .https
    .onCall(async (data, context)=> {
      /**
       * Access both user friend sub collection and update status
       */
      if (!context.auth) {
        throw new functions
            .https
            .HttpsError("unauthenticated", "User not authenticated");
      }
      if (data.response == null ||
         data.friendId == null ||
        data.documentId == null ) {
        throw new functions
            .https
            .HttpsError("invalid-argument", "arguments not found");
      }
      // Friend user id
      const friendId: string = data.friendId;
      // Response of the friend request
      const requestResponse: boolean = data.response;

      // Document id
      const documentId: string = data.documentId;

      const currentUserId: string = context.auth.uid;
      const usersCol = admin
          .firestore()
          .collection(p.Collection.users);

      let friendStatus: m.user.SocialStatus = m.user.SocialStatus.PENDING;
      if (requestResponse) {
        friendStatus = m.user.SocialStatus.FRIEND;
      } else {
        friendStatus = m.user.SocialStatus.DECLINE;
      }
      // Update on current user
      await usersCol
          .doc(currentUserId)
          .collection(p.UserSubCollections.friends)
          .doc(documentId)
          .update({
            "status": friendStatus,
          });
      // Update on other user as well
      await usersCol
          .doc(friendId)
          .collection(p.UserSubCollections.friends)
          .doc(documentId)
          .update({
            "status": friendStatus,
          });
      return Promise.resolve();
    });

