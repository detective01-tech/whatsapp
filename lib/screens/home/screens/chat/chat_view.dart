import 'package:flutter/material.dart';
import 'dart:async';
import 'dart:io';
import 'package:image_picker/image_picker.dart';

import '../call/audio_call.dart';
import '../call/video_call.dart';

class ChatView extends StatefulWidget {
  const ChatView({super.key});

  @override
  State<ChatView> createState() => _ChatViewState();
}

class _ChatViewState extends State<ChatView> {
  final TextEditingController _messageController = TextEditingController();
  final ImagePicker _picker = ImagePicker();

  // Voice recording state
  bool _isRecording = false;
  bool _isRecordingLocked = false;
  Timer? _recordingTimer;
  String _recordingDuration = "0:00";
  int _recordingSeconds = 0;

  // Media state
  File? _selectedImage;

  @override
  void dispose() {
    _messageController.dispose();
    _recordingTimer?.cancel();
    super.dispose();
  }

  void _startRecording() {
    setState(() {
      _isRecording = true;
      _recordingSeconds = 0;
      _recordingDuration = "0:00";
    });

    _recordingTimer = Timer.periodic(const Duration(seconds: 1), (timer) {
      setState(() {
        _recordingSeconds++;
        _recordingDuration = '${_recordingSeconds ~/ 60}:${(_recordingSeconds % 60).toString().padLeft(2, '0')}';
      });
    });
  }

  void _stopRecording() {
    setState(() {
      _isRecording = false;
      _isRecordingLocked = false;
    });
    _recordingTimer?.cancel();

    // Here you would typically save the audio file
    // For demo purposes, we'll just show a message
    _showSnackBar('Voice message recorded');
  }

  void _showSnackBar(String message) {
    ScaffoldMessenger.of(context).showSnackBar(
      SnackBar(content: Text(message)),
    );
  }

  Future<void> _pickImage(ImageSource source) async {
    try {
      final XFile? image = await _picker.pickImage(
        source: source,
        imageQuality: 80,
      );

      if (image != null) {
        setState(() {
          _selectedImage = File(image.path);
        });
        _showSnackBar('Image selected: ${image.name}');
      }
    } catch (e) {
      _showSnackBar('Error picking image: $e');
    }
  }

  Future<void> _pickVideo() async {
    try {
      final XFile? video = await _picker.pickVideo(
        source: ImageSource.gallery,
        maxDuration: const Duration(minutes: 10),
      );

      if (video != null) {
        _showSnackBar('Video selected: ${video.name}');
      }
    } catch (e) {
      _showSnackBar('Error picking video: $e');
    }
  }

  Future<void> _pickDocument() async {
    try {
      final XFile? document = await _picker.pickMedia();

      if (document != null) {
        _showSnackBar('Document selected: ${document.name}');
      }
    } catch (e) {
      _showSnackBar('Error picking document: $e');
    }
  }

  void _showMediaPicker() {
    showModalBottomSheet(
      context: context,
      shape: const RoundedRectangleBorder(
        borderRadius: BorderRadius.vertical(top: Radius.circular(20)),
      ),
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.all(20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              const Text(
                'Share content',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMediaOption(
                    icon: Icons.insert_drive_file,
                    label: 'Document',
                    color: Colors.blue,
                    onTap: () => _pickDocument(),
                  ),
                  _buildMediaOption(
                    icon: Icons.camera_alt,
                    label: 'Camera',
                    color: Colors.red,
                    onTap: () => _pickImage(ImageSource.camera),
                  ),
                  _buildMediaOption(
                    icon: Icons.photo,
                    label: 'Photos',
                    color: Colors.purple,
                    onTap: () => _pickImage(ImageSource.gallery),
                  ),
                  _buildMediaOption(
                    icon: Icons.videocam,
                    label: 'Video',
                    color: Colors.orange,
                    onTap: () => _pickVideo(),
                  ),
                ],
              ),
              const SizedBox(height: 10),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  _buildMediaOption(
                    icon: Icons.music_note,
                    label: 'Audio',
                    color: Colors.green,
                    onTap: () {
                      Navigator.pop(context);
                      // Audio picker would go here
                      _showSnackBar('Audio picker not implemented');
                    },
                  ),
                  _buildMediaOption(
                    icon: Icons.location_on,
                    label: 'Location',
                    color: Colors.teal,
                    onTap: () {
                      Navigator.pop(context);
                      _showSnackBar('Location sharing not implemented');
                    },
                  ),
                  _buildMediaOption(
                    icon: Icons.person,
                    label: 'Contact',
                    color: Colors.indigo,
                    onTap: () {
                      Navigator.pop(context);
                      _showSnackBar('Contact sharing not implemented');
                    },
                  ),
                  _buildMediaOption(
                    icon: Icons.poll,
                    label: 'Poll',
                    color: Colors.amber,
                    onTap: () {
                      Navigator.pop(context);
                      _showSnackBar('Poll creation not implemented');
                    },
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  Widget _buildMediaOption({
    required IconData icon,
    required String label,
    required Color color,
    required VoidCallback onTap,
  }) {
    return InkWell(
      onTap: () {
        Navigator.pop(context);
        onTap();
      },
      child: Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Container(
            width: 60,
            height: 60,
            decoration: BoxDecoration(
              color: color.withOpacity(0.1),
              shape: BoxShape.circle,
            ),
            child: Icon(icon, color: color, size: 30),
          ),
          const SizedBox(height: 8),
          Text(
            label,
            style: const TextStyle(fontSize: 12),
          ),
        ],
      ),
    );
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: const Color(0xFFECE5DD),
      appBar: AppBar(
        backgroundColor: const Color(0xFF075E54),
        elevation: 0,
        titleSpacing: 0,
        leadingWidth: 85,
        leading: Row(
          children: [
            IconButton(
              icon: const Icon(Icons.arrow_back, color: Colors.white),
              onPressed: () => Navigator.pop(context),
            ),
            const CircleAvatar(
              backgroundColor: Colors.white,
              radius: 18,
              child: Text(
                'MS',
                style: TextStyle(
                  color: Colors.black,
                  fontWeight: FontWeight.bold,
                ),
              ),
            ),
          ],
        ),
        title: const Padding(
          padding: EdgeInsets.symmetric(horizontal: 10),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Text(
                '+92 318 6529718',
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  fontSize: 16,
                  color: Colors.white,
                ),
              ),
              SizedBox(height: 2),
              Text(
                'online',
                style: TextStyle(color: Colors.white70, fontSize: 13),
              ),
            ],
          ),
        ),
        actions: [
          IconButton(
            icon: const Icon(Icons.videocam, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Close bottom sheet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => VideoCallScreen(
                    callerName: "Muhammad Sohail",
                    callerImage: "AH",
                    isIncoming: false,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 20),
          IconButton(
            icon: const Icon(Icons.call, color: Colors.white),
            onPressed: () {
              Navigator.pop(context); // Close bottom sheet
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => AudioCallScreen(
                    callerName: "Muhammad Sohail",
                    callerImage: "AH",
                    isIncoming: false,
                  ),
                ),
              );
            },
          ),
          const SizedBox(width: 10),
          IconButton(
            icon: const Icon(Icons.more_vert, color: Colors.white),
            onPressed: () {},
          ),
          const SizedBox(width: 10),
        ],
      ),

      body: Column(
        children: [
          // Messages area
          Expanded(
            child: ListView(
              padding: const EdgeInsets.all(10),
              children: [
                // Voice message indicator when recording
                if (_isRecording) ...[
                  Container(
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.all(15),
                    decoration: BoxDecoration(
                      color: Colors.red.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Row(
                      children: [
                        Icon(
                          _isRecordingLocked ? Icons.lock : Icons.mic,
                          color: Colors.red,
                        ),
                        const SizedBox(width: 10),
                        Text(
                          'Recording: $_recordingDuration',
                          style: const TextStyle(color: Colors.red),
                        ),
                        const Spacer(),
                        Text(
                          _isRecordingLocked ? 'Slide to cancel' : 'Tap to send',
                          style: const TextStyle(color: Colors.grey),
                        ),
                      ],
                    ),
                  ),
                ],

                // Existing messages
                const Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(
                    text: "Hey there!",
                    isSender: true,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerLeft,
                  child: ChatBubble(
                    text: "Hi! How are you?",
                    isSender: false,
                  ),
                ),
                const Align(
                  alignment: Alignment.centerRight,
                  child: ChatBubble(
                    text: "I'm good. Working on Flutter UI 😄",
                    isSender: true,
                  ),
                ),

                // Show selected media preview
                if (_selectedImage != null) ...[
                  const SizedBox(height: 10),
                  Align(
                    alignment: Alignment.centerRight,
                    child: Container(
                      padding: const EdgeInsets.all(8),
                      decoration: BoxDecoration(
                        color: const Color(0xFFDCF8C6),
                        borderRadius: BorderRadius.circular(12),
                      ),
                      child: Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          ClipRRect(
                            borderRadius: BorderRadius.circular(8),
                            child: Image.file(
                              _selectedImage!,
                              width: 200,
                              height: 150,
                              fit: BoxFit.cover,
                            ),
                          ),
                          const SizedBox(height: 5),
                          TextButton(
                            onPressed: () {
                              setState(() {
                                _selectedImage = null;
                              });
                            },
                            child: const Text('Remove'),
                          ),
                        ],
                      ),
                    ),
                  ),
                ],
              ],
            ),
          ),

          // Message input area
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 8, vertical: 6),
            color: Colors.white,
            child: Row(
              children: [
                IconButton(
                  icon: const Icon(Icons.emoji_emotions_outlined, color: Colors.grey),
                  onPressed: () {},
                ),
                Expanded(
                  child: Container(
                    padding: const EdgeInsets.symmetric(horizontal: 12),
                    decoration: BoxDecoration(
                      color: Colors.grey[200],
                      borderRadius: BorderRadius.circular(30),
                    ),
                    child: TextField(
                      controller: _messageController,
                      decoration: const InputDecoration(
                        hintText: "Message",
                        border: InputBorder.none,
                      ),
                    ),
                  ),
                ),

                // Attachment button with media picker
                IconButton(
                  icon: const Icon(Icons.attach_file, color: Colors.grey),
                  onPressed: _showMediaPicker,
                ),

                // Camera button
                IconButton(
                  icon: const Icon(Icons.camera_alt, color: Colors.grey),
                  onPressed: () => _pickImage(ImageSource.camera),
                ),

                // Voice recording button
                GestureDetector(
                  onLongPressStart: (_) {
                    if (!_isRecording) {
                      _startRecording();
                    }
                  },
                  onLongPressEnd: (_) {
                    if (_isRecording && !_isRecordingLocked) {
                      _stopRecording();
                    }
                  },
                  onLongPressMoveUpdate: (details) {
                    // Lock recording if moved up
                    if (details.localOffsetFromOrigin.dy < -50 && !_isRecordingLocked) {
                      setState(() {
                        _isRecordingLocked = true;
                      });
                    }
                  },
                  child: Container(
                    width: 44,
                    height: 44,
                    decoration: BoxDecoration(
                      shape: BoxShape.circle,
                      color: _isRecording ? Colors.red : const Color(0xFF075E54),
                    ),
                    child: Icon(
                      _isRecording ? Icons.stop : Icons.mic,
                      color: Colors.white,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }
}

// Chat bubble widget
class ChatBubble extends StatelessWidget {
  final String text;
  final bool isSender;

  const ChatBubble({super.key, required this.text, required this.isSender});

  @override
  Widget build(BuildContext context) {
    return Container(
      margin: const EdgeInsets.symmetric(vertical: 4, horizontal: 8),
      padding: const EdgeInsets.all(10),
      decoration: BoxDecoration(
        color: isSender ? const Color(0xFFDCF8C6) : Colors.white,
        borderRadius: BorderRadius.only(
          topLeft: const Radius.circular(12),
          topRight: const Radius.circular(12),
          bottomLeft: Radius.circular(isSender ? 12 : 0),
          bottomRight: Radius.circular(isSender ? 0 : 12),
        ),
      ),
      child: Text(text, style: const TextStyle(fontSize: 15)),
    );
  }
}
