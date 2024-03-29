import argparse
import asyncio

import cv2
from av import VideoFrame
import aiohttp_cors

import mediapipe as mp
import api.hiit_pb2
import api.hiit_pb2_grpc

from aiortc import MediaStreamTrack

mp_drawing = mp.solutions.drawing_utils
mp_pose = mp.solutions.pose


class VideoTransformTrack(MediaStreamTrack):
    """
    A video stream track that transforms frames from an another track.
    """

    kind = "video"

    def __init__(self, track, transform, hiit_stub: api.hiit_pb2_grpc.HIITServiceStub, exercise=None):
        super().__init__()  # don't forget this!
        self.track = track
        self.transform = transform
        self.hiit_stub = hiit_stub
        self.exercise = exercise

        # Initialises Media Pose
        self.pose = mp_pose.Pose(
            min_detection_confidence=0.5, min_tracking_confidence=0.5)

    async def recv(self):
        frame = await self.track.recv()

        img = frame.to_ndarray(format="bgr24")
        image = cv2.cvtColor(img, cv2.COLOR_BGR2RGB)
        image.flags.writeable = False

        results = self.pose.process(image)

        try:
            count = self.exercise.process(results.pose_landmarks.landmark)
            self.hiit_stub.Pub(api.hiit_pb2.DataSession(
                data=api.hiit_pb2.Data(
                    state=self.exercise.state,
                    count=count,
                    interval=self.exercise.interval,
                ),
                session=api.hiit_pb2.Session(
                    id=self.exercise.id,
                    exercise=self.exercise.exercise,
                )
            ))
        except Exception as e:
            pass
            # print(e)

        # Recolor back to BGR
        image.flags.writeable = True
        image = cv2.cvtColor(image, cv2.COLOR_RGB2BGR)

        mp_drawing.draw_landmarks(image, results.pose_landmarks, mp_pose.POSE_CONNECTIONS,
                                  mp_drawing.DrawingSpec(
                                      color=(245, 117, 66), thickness=2, circle_radius=2),
                                  mp_drawing.DrawingSpec(
                                      color=(245, 66, 230), thickness=2, circle_radius=2)
                                  )

        new_frame = VideoFrame.from_ndarray(image, format="bgr24")
        new_frame.pts = frame.pts
        new_frame.time_base = frame.time_base
        return new_frame

    def image_resize(self, image, width=None, height=None, inter=cv2.INTER_AREA):
        # initialize the dimensions of the image to be resized and
        # grab the image size
        dim = None
        (h, w) = image.shape[:2]

        # if both the width and height are None, then return the
        # original image
        if width is None and height is None:
            return image

        # check to see if the width is None
        if width is None:
            # calculate the ratio of the height and construct the
            # dimensions
            r = height / float(h)
            dim = (int(w * r), height)

        # otherwise, the height is None
        else:
            # calculate the ratio of the width and construct the
            # dimensions
            r = width / float(w)
            dim = (width, int(h * r))

        # resize the image
        resized = cv2.resize(image, dim, interpolation=inter)

        # return the resized image
        return resized
