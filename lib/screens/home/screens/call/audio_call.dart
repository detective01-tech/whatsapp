import 'package:flutter/material.dart';
import 'dart:async';

class AudioCallScreen extends StatefulWidget {
  final String callerName;
  final String callerImage;
  final bool isIncoming;

  const AudioCallScreen({
    super.key,
    required this.callerName,
    required this.callerImage,
    this.isIncoming = false,
  });

  @override
  State<AudioCallScreen> createState() => _AudioCallScreenState();
}

class _AudioCallScreenState extends State<AudioCallScreen> {
  bool isMuted = false;
  bool isSpeakerOn = false;
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
      backgroundColor: const Color(0xFF075E54),
      body: SafeArea(
        child: Column(
          children: [
            // Top section with caller info
            Expanded(
              flex: 3,
              child: Container(
                padding: const EdgeInsets.symmetric(horizontal: 20),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    CircleAvatar(
                      radius: 50,
                      backgroundColor: Colors.grey[300],
                      child: Text(
                        widget.callerName.substring(0, 2).toUpperCase(),
                        style: const TextStyle(
                          color: Colors.white,
                          fontSize: 30,
                          fontWeight: FontWeight.bold,
                        ),
                      ),
                    ),
                    const SizedBox(height: 20),
                    Text(
                      widget.callerName,
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 26,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                    const SizedBox(height: 10),
                    Text(
                      isCallConnected ? formatDuration(callDuration) : callStatus,
                      style: const TextStyle(
                        color: Colors.white70,
                        fontSize: 16,
                      ),
                    ),
                    if (widget.isIncoming && !isCallConnected) ...[
                      const SizedBox(height: 30),
                      Row(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          FloatingActionButton(
                            heroTag: "accept_call",
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
                            heroTag: "decline_call",
                            backgroundColor: Colors.red,
                            onPressed: () {
                              Navigator.of(context).pop();
                            },
                            child: const Icon(Icons.call_end, color: Colors.white),
                          ),
                        ],
                      ),
                    ],
                  ],
                ),
              ),
            ),

            // Bottom section with call controls
            Container(
              padding: const EdgeInsets.symmetric(vertical: 30, horizontal: 20),
              child: Column(
                children: [
                  // Call control buttons
                  Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      Column(
                        children: [
                          FloatingActionButton(
                            heroTag: "mute",
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
                            heroTag: "speaker",
                            backgroundColor: isSpeakerOn ? Colors.green : Colors.white,
                            onPressed: toggleSpeaker,
                            child: Icon(
                              isSpeakerOn ? Icons.volume_up : Icons.volume_off,
                              color: isSpeakerOn ? Colors.white : Colors.grey[700],
                            ),
                          ),
                          const SizedBox(height: 8),
                          Text(
                            isSpeakerOn ? 'Speaker On' : 'Speaker Off',
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
                            heroTag: "add_call",
                            backgroundColor: Colors.white,
                            onPressed: () {},
                            child: const Icon(Icons.person_add, color: Colors.grey),
                          ),
                          const SizedBox(height: 8),
                          const Text(
                            'Add',
                            style: TextStyle(
                              color: Colors.white,
                              fontSize: 12,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),

                  const SizedBox(height: 30),

                  // End call button (prominent red button)
                  FloatingActionButton(
                    heroTag: "end_call",
                    backgroundColor: Colors.red,
                    onPressed: endCall,
                    child: const Icon(Icons.call_end, color: Colors.white, size: 30),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}