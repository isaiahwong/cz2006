import * as functions from "firebase-functions";
import * as lx from "luxon";
import * as helper from "./helper";

// The Firebase Admin SDK to access Firestore.
import admin = require("firebase-admin");

admin.initializeApp();

/**
 * Exports from sub directories
 */
exports.social = require("./social/social");

/**
 * Get current time called from server
 * @return {number} current Datetime
 */
exports.getCurrentTime = functions
    .region(helper.FUNCTION_REGION)
    .https
    .onCall((data, context) => {
      // Sanity check
      if (!context.auth) {
        throw new functions
            .https
            .HttpsError("unauthenticated", "User is unauthenicated");
      }
      const dateTime = lx.DateTime.now().setZone("Asia/Singapore");
      return dateTime.toMillis();
    });
