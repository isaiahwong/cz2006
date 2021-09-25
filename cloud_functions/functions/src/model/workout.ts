import * as u from "./user";

export interface Workout{
    id: string;
    user: u.User;
    name: string;
    workoutType: WorkoutType;
    public: boolean;
    participants: u.User[];
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
    workout: Workout[];
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
