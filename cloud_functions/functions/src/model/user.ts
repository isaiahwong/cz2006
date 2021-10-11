import * as w from "./workout";

export interface User {
    id: string;
    email: string;
    name: string;
    height: number;
    profilePicture: string;
    workouts: w.Workout[];
    weights: Weight[];
    workoutEvents: w.Workout[];
    friends: User[];
}

export interface FriendWithId extends Friend{
    id: string;
}
export interface Friend{
    createdAt: number;
    initiator: UserSnippet;
    responder: UserSnippet;
    status: SocialStatus;
}

export interface UserSnippet{
    id: string;
    name: string;
    profilePicture: string;
}


export interface Weight {
    weight: number;
    metric: WeightMetric;
    user: User;
    createdAt: number;
    updatedAt: number;
}


export enum WeightMetric {
    KG = "kg",
    POUNDS = "pounds",
}

export enum SocialStatus {
    FRIEND = "FRIEND",
    UNFRIEND = "UNFRIEND",
    PENDING = "PENDING",
    DECLINE = "DECLINE"
}

