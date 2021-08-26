import * as functions from "firebase-functions";
import * as lx from "luxon";

// // Start writing Firebase Functions
// // https://firebase.google.com/docs/functions/typescript
//
// export const helloWorld = functions.https.onRequest((request, response) => {
//   functions.logger.info("Hello logs!", {structuredData: true});
//   response.send("Hello from Firebase!");
// });

/**
 * Get current time called from server
 * @return {number} current Datetime
 */
exports.getCurrentTime = functions
    .region(FUNCTION_REGION)
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
