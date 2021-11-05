import mediapipe as mp
import numpy as np

mp_pose = mp.solutions.pose


class Movement:
    def __init__(self, id="", exercise="", interval=""):
        self.id = id
        self.exercise = exercise
        self.interval = interval

    def calculate_angle(self, a, b, c):
        a = np.array(a)  # First
        b = np.array(b)  # Mid
        c = np.array(c)  # End

        radians = np.arctan2(c[1]-b[1], c[0]-b[0]) - \
            np.arctan2(a[1]-b[1], a[0]-b[0])
        angle = np.abs(radians*180.0/np.pi)

        if angle > 180.0:
            angle = 360-angle

        return angle

    def process(self, landmarks):
        pass


class Squat(Movement):
    def __init__(self, id="", exercise="", interval="", reps=0):
        super(Squat, self).__init__(id, exercise, interval)
        self.state = None
        self.count = 0
        self.reps = reps

    def process(self, landmarks):
       # Get coordinates
        right_hip = [landmarks[mp_pose.PoseLandmark.RIGHT_HIP.value].x,
                     landmarks[mp_pose.PoseLandmark.RIGHT_HIP.value].y]
        right_knee = [landmarks[mp_pose.PoseLandmark.RIGHT_KNEE.value].x,
                      landmarks[mp_pose.PoseLandmark.RIGHT_KNEE.value].y]
        right_ankle = [landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE.value].x,
                       landmarks[mp_pose.PoseLandmark.RIGHT_ANKLE.value].y]

        left_hip = [landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].x,
                    landmarks[mp_pose.PoseLandmark.LEFT_HIP.value].y]
        left_knee = [landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].x,
                     landmarks[mp_pose.PoseLandmark.LEFT_KNEE.value].y]
        left_ankle = [landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].x,
                      landmarks[mp_pose.PoseLandmark.LEFT_ANKLE.value].y]

        # Calculate angle
        right_angle = self.calculate_angle(right_hip, right_knee, right_ankle)
        left_angle = self.calculate_angle(left_hip, left_knee, left_ankle)

        if right_angle < 110 and left_angle < 110 and self.state == 'up':
            self.state = "down"
        if right_angle > 120 and left_angle > 120 and self.state == 'down':
            self.count += 1
            self.state = "up"
        if right_angle > 120 and left_angle > 120:
            self.state = "up"

        count = self.count
        # reset rep counter
        if self.count == self.reps:
            self.count = 0

        return count


class JumpingJack(Movement):
    def __init__(self, id="", exercise="", interval="", reps=0):
        super(JumpingJack, self).__init__(id, exercise, interval)
        self.state = None
        self.count = 0
        self.reps = reps

    def getXY(self, landmarks, part):
        return [landmarks[part.value].x, landmarks[part.value].y]

    def process(self, landmarks):
        pose_landmarks = mp_pose.PoseLandmark

        right_shoulder = self.getXY(landmarks, pose_landmarks.RIGHT_SHOULDER)
        right_hip = self.getXY(landmarks, pose_landmarks.RIGHT_HIP)
        right_elbow = self.getXY(landmarks, pose_landmarks.RIGHT_ELBOW)
        right_wrist = self.getXY(landmarks, pose_landmarks.RIGHT_WRIST)
        right_knee = self.getXY(landmarks, pose_landmarks.RIGHT_KNEE)

        left_shoulder = self.getXY(landmarks, pose_landmarks.LEFT_SHOULDER)
        left_hip = self.getXY(landmarks, pose_landmarks.LEFT_HIP)
        left_elbow = self.getXY(landmarks, pose_landmarks.LEFT_ELBOW)
        left_wrist = self.getXY(landmarks, pose_landmarks.LEFT_WRIST)
        left_knee = self.getXY(landmarks, pose_landmarks.LEFT_KNEE)

        # angle at the arm pit
        right_arm_outer_angle = self.calculate_angle(
            right_elbow, right_shoulder, right_hip)
        left_arm_outer_angle = self.calculate_angle(
            left_elbow, left_shoulder, left_hip)

        # angle opposite head
        right_arm_inner_angle = self.calculate_angle(
            right_wrist, right_elbow, right_shoulder)
        left_arm_inner_angle = self.calculate_angle(
            left_wrist, left_elbow, left_shoulder)

        # leg angle
        right_hip_angle = self.calculate_angle(
            right_shoulder, right_hip, right_knee)
        left_hip_angle = self.calculate_angle(
            left_shoulder, left_hip, left_knee)

        # inner leg
        right_inner_hip_angle = self.calculate_angle(
            left_hip, right_hip, right_knee)
        left_inner_hip_angle = self.calculate_angle(
            right_hip, left_hip, left_knee)

        # up
        if (
            right_arm_outer_angle > 130 and left_arm_outer_angle > 130 and
            right_arm_inner_angle < 150 and left_arm_inner_angle < 150 and
            right_hip_angle < 150 and left_hip_angle < 150 and
            right_inner_hip_angle > 110 and left_inner_hip_angle > 110 and
            self.state == 'down'
        ):
            self.state = 'up'

        if (
            right_arm_outer_angle < 30 and left_arm_outer_angle < 30 and
            right_arm_inner_angle > 150 and left_arm_inner_angle > 150 and
            right_hip_angle > 150 and left_hip_angle > 150 and
            right_inner_hip_angle < 100 and left_inner_hip_angle < 100 and self.state == 'up'
        ):
            self.count += 1
        # down
        if (
            right_arm_outer_angle < 30 and left_arm_outer_angle < 30 and
            right_arm_inner_angle > 150 and left_arm_inner_angle > 150 and
            right_hip_angle > 150 and left_hip_angle > 150 and
            right_inner_hip_angle < 100 and left_inner_hip_angle < 100
        ):
            self.state = 'down'

        count = self.count
        # reset rep counter
        if self.count == self.reps:
            self.count = 0

        return count
