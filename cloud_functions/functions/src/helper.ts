import m = require("./model/model");
import admin = require("firebase-admin");
import p = require("./paths");
import functions = require("firebase-functions");
export const FUNCTION_REGION = "asia-east2";


/**
 * Get user from collection with given id
 * @param {string} userId
 * @return {m.user.User} User
 */
export async function getUser(userId: string): Promise<m.user.User> {
  const collectionRef = admin
      .firestore()
      .collection(p.Collection.users)
      .doc(userId);
  const snapshot = await collectionRef.get();
  if (!snapshot.exists) {
    throw new functions.https.HttpsError("not-found", "user not found");
  }
  const result: m.user.User = JSON.parse(JSON.stringify(snapshot.data()));
  console.log(`Fetch document for ${result.name}`);
  return result;
}


/**
 * Get usersnippet, basic information
 * @param {m.user.User} user
 * @return {m.user.UserSnippet} snippet
 */
export function getSnippet(user: m.user.User): m.user.UserSnippet {
  return {
    id: user.id,
    name: user.name,
    profilePicture: user.profilePicture,
  };
}
