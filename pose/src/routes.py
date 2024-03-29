import json
import logging
import uuid
import asyncio
import grpc
import api.hiit_pb2
import api.hiit_pb2_grpc
from seed.seed import exercises

from aiohttp import web
from aiortc import MediaStreamTrack, RTCPeerConnection, RTCSessionDescription
from aiortc.contrib.media import MediaBlackhole, MediaPlayer, MediaRecorder, MediaRelay
from webrtc import VideoTransformTrack

pcs = set()
relay = MediaRelay()
logger = logging.getLogger("pc")


async def offer(request):
    params = await request.json()
    offer = RTCSessionDescription(sdp=params["sdp"], type=params["type"])
    exercise = params["exercise"]
    interval = params["interval"]
    reps = params["reps"]

    id = params["id"]

    # End function if exercise not in
    if not exercise in exercises:
        return web.Response(
            status=404,
            content_type="application/json",
        )

    # Create GRPC
    grpc_channel = grpc.insecure_channel('localhost:50051')
    stub = api.hiit_pb2_grpc.HIITServiceStub(grpc_channel)

    pc = RTCPeerConnection()
    pc_id = "PeerConnection(%s)" % uuid.uuid4()
    pcs.add(pc)

    def log_info(msg, *args):
        logger.info(pc_id + " " + msg, *args)

    log_info("Created for %s", request.remote)

    @pc.on("datachannel")
    async def on_datachannel(channel):
        @channel.on("message")
        def on_message(message):
            if isinstance(message, str) and message.startswith("ping"):
                channel.send("pong" + message[4:])

        await channel._RTCDataChannel__transport._data_channel_flush()

    @pc.on("connectionstatechange")
    async def on_connectionstatechange():
        log_info("Connection state is %s", pc.connectionState)
        if pc.connectionState == "failed":
            await pc.close()
            pcs.discard(pc)

    @pc.on("track")
    def on_track(track):
        log_info("Track %s received", track.kind)
        if track.kind == "video":
            vtrack = VideoTransformTrack(
                track=relay.subscribe(track),
                transform=params["video_transform"],
                hiit_stub=stub,
                exercise=exercises[exercise](
                    id=id,
                    exercise=exercise,
                    interval=interval,
                    reps=reps,
                )
            )
            pc.addTrack(vtrack)

        @track.on("ended")
        async def on_ended():
            log_info("Track %s ended", track.kind)

    # handle offer
    await pc.setRemoteDescription(offer)
    # await recorder.start()

    # send answer
    answer = await pc.createAnswer()
    await pc.setLocalDescription(answer)

    return web.Response(
        content_type="application/json",
        text=json.dumps(
            {"sdp": pc.localDescription.sdp, "type": pc.localDescription.type}
        ),
    )


async def on_shutdown(app):
    # close peer connections
    coros = [pc.close() for pc in pcs]
    await asyncio.gather(*coros)
    pcs.clear()
