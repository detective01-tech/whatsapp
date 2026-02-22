import 'package:flutter/material.dart';
import 'dart:async';

class VideoCallScreen extends StatefulWidget {
  final String callerName;
  final String callerImage;
  final bool isIncoming;

  const VideoCallScreen({
    super.key,
    required this.callerName,
    required this.callerImage,
    this.isIncoming = false,
  });

  @override
  State<VideoCallScreen> createState() => _VideoCallScreenState();
}

class _VideoCallScreenState extends State<VideoCallScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;
  bool isVideoOn = true;
  bool isFrontCamera = true;
  bool isCallConnected = false;
  bool isCallEnded = false;
  String callStatus = 'Connecting...';
  int callDuration = 0;
  Timer? callTimer;

  @override
  void initState() {
    super.initState();
    // Simulate call connection after 2 seconds
    Future.delayed(const Duration(seconds: 2), () {
      if (mounted) {
        setState(() {
          isCallConnected = true;
          callStatus = 'Connected';
          startCallTimer();
        });
      }
    });
  }

  @override
  void dispose() {
    callTimer?.cancel();
    super.dispose();
  }

  void startCallTimer() {
    callTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      if (mounted) {
        setState(() {
          callDuration++;
        });
      }
    });
  }

  String formatDuration(int seconds) {
    int hours = seconds ~/ 3600;
    int minutes = (seconds % 3600) ~/ 60;
    int secs = seconds % 60;

    if (hours > 0) {
      return '${hours.toString().padLeft(2, '0')}:${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    } else {
      return '${minutes.toString().padLeft(2, '0')}:${secs.toString().padLeft(2, '0')}';
    }
  }

  void toggleMute() {
    setState(() {
      isMuted = !isMuted;
    });
  }

  void toggleSpeaker() {
    setState(() {
      isSpeakerOn = !isSpeakerOn;
    });
  }

  void toggleVideo() {
    setState(() {
      isVideoOn = !isVideoOn;
    });
  }

  void switchCamera() {
    setState(() {
      isFrontCamera = !isFrontCamera;
    });
  }

  void endCall() {
    setState(() {
      isCallEnded = true;
      callStatus = 'Call Ended';
      callTimer?.cancel();
    });

    // Navigate back after showing call ended status
    Future.delayed(const Duration(seconds: 1), () {
      if (mounted) {
        Navigator.of(context).pop();
      }
    });
  }

  @override
  Widget build(BuildContext context) {
    if (isCallEnded) {
      return Scaffold(
        backgroundColor: Colors.black,
        body: Center(
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              CircleAvatar(
                radius: 40,
                backgroundColor: Colors.grey[700],
                child: Text(
                  widget.callerName.substring(0, 2).toUpperCase(),
                  style: const TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
              ),
              const SizedBox(height: 20),
              Text(
                widget.callerName,
                style: const TextStyle(
                  color: Colors.white,
                  fontSize: 24,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 10),
              Text(
                callStatus,
                style: const TextStyle(
                  color: Colors.grey,
                  fontSize: 16,
                ),
              ),
            ],
          ),
        ),
      );
    }

    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Main video area (background)
            Container(
              decoration: BoxDecoration(
                color: Colors.grey[900],
                borderRadius: BorderRadius.circular(15),
              ),
              child: Stack(
                children: [
                  // Remote video (full screen background)
                  Container(
                    decoration: BoxDecoration(
                      color: Colors.grey[800],
                      borderRadius: BorderRadius.circular(15),
                    ),
                    child: Center(
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          CircleAvatar(
                            radius: 60,
                            backgroundColor: Colors.grey[700],
                            child: Text(
                              widget.callerName.substring(0, 2).toUpperCase(),
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 35,
                                fontWeight: FontWeight.bold,
                              ),
                            ),
                          ),
                          const SizedBox(height: 20),
                          Text(
                            widget.callerName,
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 28,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                          const SizedBox(height: 10),
                          Text(
                            isCallConnected ? formatDuration(callDuration) : callStatus,
                            style: const TextStyle(
                              color: Colors.white70,
                              fontSize: 18,
                            ),
                          ),
                        ],
                      ),
                    ),
                  ),

                  // Local video (picture-in-picture)
                  Positioned(
                    top: 20,
                    right: 20,
                    child: Container(
                      width: 120,
                      height: 160,
                      decoration: BoxDecoration(
                        color: isVideoOn ? Colors.grey[800] : Colors.grey[900],
                        borderRadius: BorderRadius.circular(10),
                        border: Border.all(color: Colors.white, width: 2),
                      ),
                      child: isVideoOn
                        ? Center(
                            child: Column(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                CircleAvatar(
                                  radius: 30,
                                  backgroundColor: Colors.grey[600],
                                  child: Text(
                                    'You',
                                    style: const TextStyle(
                                      color: Colors.white,
                                      fontSize: 12,
                                      fontWeight: FontWeight.bold,
                                    ),
                                  ),
                                ),
                                const SizedBox(height: 10),
                                Icon(
                                  isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                                  color: Colors.white70,
                                  size: 20,
                                ),
                              ],
                            ),
                          )
                        : Container(
                            decoration: BoxDecoration(
                              color: Colors.black.withOpacity(0.7),
                              borderRadius: BorderRadius.circular(8),
                            ),
                            child: const Center(
                              child: Icon(
                                Icons.videocam_off,
                                color: Colors.white,
                                size: 40,
                              ),
                            ),
                          ),
                    ),
                  ),
                ],
              ),
            ),

            // Call controls overlay
            Positioned(
              bottom: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.bottomCenter,
                    end: Alignment.topCenter,
                    colors: [
                      Colors.black.withOpacity(0.8),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Column(
                  children: [
                    // Top row controls
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                      children: [
                        Column(
                          children: [
                            FloatingActionButton(
                              heroTag: "video_mute",
                              backgroundColor: isMuted ? Colors.red : Colors.white,
                              onPressed: toggleMute,
                              child: Icon(
                                isMuted ? Icons.mic_off : Icons.mic,
                                color: isMuted ? Colors.white : Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isMuted ? 'Unmute' : 'Mute',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            FloatingActionButton(
                              heroTag: "video_toggle",
                              backgroundColor: isVideoOn ? Colors.white : Colors.red,
                              onPressed: toggleVideo,
                              child: Icon(
                                isVideoOn ? Icons.videocam : Icons.videocam_off,
                                color: isVideoOn ? Colors.grey[700] : Colors.white,
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isVideoOn ? 'Turn off' : 'Turn on',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                        Column(
                          children: [
                            FloatingActionButton(
                              heroTag: "switch_camera",
                              backgroundColor: Colors.white,
                              onPressed: switchCamera,
                              child: Icon(
                                isFrontCamera ? Icons.camera_front : Icons.camera_rear,
                                color: Colors.grey[700],
                              ),
                            ),
                            const SizedBox(height: 8),
                            Text(
                              isFrontCamera ? 'Front' : 'Back',
                              style: const TextStyle(
                                color: Colors.white,
                                fontSize: 12,
                              ),
                            ),
                          ],
                        ),
                      ],
                    ),

                    const SizedBox(height: 20),

                    // End call button (prominent red button)
                    FloatingActionButton(
                      heroTag: "video_end_call",
                      backgroundColor: Colors.red,
                      onPressed: endCall,
                      child: const Icon(Icons.call_end, color: Colors.white, size: 30),
                    ),
                  ],
                ),
              ),
            ),

            // Incoming call overlay
            if (widget.isIncoming && !isCallConnected) ...[
              Positioned(
                bottom: 200,
                left: 0,
                right: 0,
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    FloatingActionButton(
                      heroTag: "accept_video_call",
                      backgroundColor: Colors.green,
                      onPressed: () {
                        setState(() {
                          isCallConnected = true;
                          callStatus = 'Connected';
                          startCallTimer();
                        });
                      },
                      child: const Icon(Icons.call, color: Colors.white),
                    ),
                    const SizedBox(width: 30),
                    FloatingActionButton(
                      heroTag: "decline_video_call",
                      backgroundColor: Colors.red,
                      onPressed: () {
                        Navigator.of(context).pop();
                      },
                      child: const Icon(Icons.call_end, color: Colors.white),
                    ),
                  ],
                ),
              ),
            ],

            // Top bar with call info
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                decoration: BoxDecoration(
                  gradient: LinearGradient(
                    begin: Alignment.topCenter,
                    end: Alignment.bottomCenter,
                    colors: [
                      Colors.black.withOpacity(0.6),
                      Colors.transparent,
                    ],
                  ),
                ),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    Row(
                      children: [
                        CircleAvatar(
                          radius: 20,
                          backgroundColor: Colors.grey[300],
                          child: Text(
                            widget.callerName.substring(0, 2).toUpperCase(),
                            style: const TextStyle(
                              color: Colors.white,
                              fontSize: 14,
                              fontWeight: FontWeight.bold,
                            ),
                          ),
                        ),
                        const SizedBox(width: 10),
                        Text(
                          widget.callerName,
                          style: const TextStyle(
                            color: Colors.white,
                            fontSize: 16,
                            fontWeight: FontWeight.bold,
                          ),
                        ),
                      ],
                    ),
                    Container(
                      padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 6),
                      decoration: BoxDecoration(
                        color: isCallConnected ? Colors.green : Colors.orange,
                        borderRadius: BorderRadius.circular(15),
                      ),
                      child: Text(
                        isCallConnected ? formatDuration(callDuration) : callStatus,
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 12,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}