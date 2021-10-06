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
    def __init__(self, id="", exercise="", interval=""):
        super(Squat, self).__init__(id, exercise, interval)
        self.state = None
        self.count = 0

    def process(self, landmarks):
        count = 0
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
