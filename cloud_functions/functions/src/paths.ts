
/**
 * Main Collection Paths
 */
export class Collection {
    static users = "users";
    // Workout > 1 person
    static workoutGroup = "workoutgroups";
}

/**
 * Sub collection of Users
 */
export class UserSubCollections {
    static friends = "friends";
    static workouts = "workouts";
    // List of workouts from inviation
    static workoutInvites = "workoutInvites";
    static invites = "invites"
}
