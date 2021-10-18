import * as u from "./user";

export interface WorkoutGroupWithId extends WorkoutGroup{
    id: string;
}
/**
 * Collection for workout groups
 */
export interface WorkoutGroup{
    workoutId: string;
    creator: string;
    isPublic: boolean;
    isActive: boolean;
    participants: u.User[];
    maxParticipants: number;
}

/**
 * Sub collection for group workout
 * * Share the same id with workoutGroup document
 */
export interface GroupWorkout{
    creator: string;
    workoutGroupId: string;
    isActive: boolean;
}

export enum WorkoutType{
    CYCLING = "cycling",
    HIIT = "hiit",
}

export interface Exercise{
    id: string;
    name: string;
    defaultWarmups: number;
    defaultSets: number;
    defaultReps: number;
    defaultRestDuration: number;
    category: string;
}

/**
 * HIIT Workout
 */
export interface HIIT {
    id: string;
    routines: Routine[];
    completed: boolean;
    createdAt: number;
}

export interface Routine{
    id: string;
    workout: WorkoutGroup[];
    exercises: Exercise[];
}

export interface RoutineInterval{
    id: string;
    iteration: number;
    routine: Routine;
    logs: RoutineLog[];
    updatedAt: number;
    type: RoutineIntervalType;
}

export interface RoutineLog{
    id: string;
    reps: number;
    currentReps: number;
    intervals: RoutineInterval;
    completed: number;
    restDuration: number;
}

export enum RoutineIntervalType{
    WARM_UP = "warm up",
    SET = "set",
    DROP_SET = "dropset",
}


/**
 * Cycling Workout
 */
export interface CYCLING{
    id: string;
    routes: Route[];
    createdAt: number;
    start: Route;
    end: Route;
}

// Cycling Routine
export interface Route{
    id: string;
    coordinates: Coordinate[];
    landmarks: Landmark[];
}

export interface Landmark{
    id: string;
    name: string;
    coordinate: Coordinate;
}

export interface Coordinate{
    x: number;
    y: number;
}
