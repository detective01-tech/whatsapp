import 'package:flutter/material.dart';
import 'dart:async';

class StatusView extends StatefulWidget {
  const StatusView({super.key});

  @override
  State<StatusView> createState() => _StatusViewState();
}

class _StatusViewState extends State<StatusView> {
  final List<Map<String, dynamic>> recentStatuses = [
    {
      'name': 'Muhammad Sohail',
      'avatar': 'AH',
      'isRecent': true,
      'time': '2 minutes ago',
      'hasStatus': true,
      'statusType': 'image',
      'statusContent': 'Had a great day at the park! 🌳',
    },
    {
      'name': 'Sarah Ahmed',
      'avatar': 'SA',
      'isRecent': true,
      'time': '15 minutes ago',
      'hasStatus': true,
      'statusType': 'text',
      'statusContent': 'Working on something exciting! 🚀',
    },
    {
      'name': 'Ahmed Hassan',
      'avatar': 'AH',
      'isRecent': true,
      'time': '1 hour ago',
      'hasStatus': true,
      'statusType': 'image',
      'statusContent': 'Beautiful sunset view',
    },
  ];

  final List<Map<String, dynamic>> viewedStatuses = [
    {
      'name': 'Fatima Ali',
      'avatar': 'FA',
      'isRecent': false,
      'time': '2 hours ago',
      'hasStatus': true,
      'statusType': 'text',
      'statusContent': 'Coffee time ☕',
    },
    {
      'name': 'Omar Khan',
      'avatar': 'OK',
      'isRecent': false,
      'time': '5 hours ago',
      'hasStatus': true,
      'statusType': 'image',
      'statusContent': 'Team meeting vibes',
    },
    {
      'name': 'Aisha Rehman',
      'avatar': 'AR',
      'isRecent': false,
      'time': '1 day ago',
      'hasStatus': true,
      'statusType': 'text',
      'statusContent': 'Good morning everyone! 🌅',
    },
    {
      'name': 'Hassan Ali',
      'avatar': 'HA',
      'isRecent': false,
      'time': '2 days ago',
      'hasStatus': false,
      'statusType': 'none',
      'statusContent': '',
    },
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: Column(
        children: [
          // Header with camera button
          Container(
            padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 12),
            color: const Color(0xFF075E54),
            child: Row(
              children: [
                const Text(
                  'Status',
                  style: TextStyle(
                    color: Colors.white,
                    fontSize: 20,
                    fontWeight: FontWeight.bold,
                  ),
                ),
                const Spacer(),
                IconButton(
                  onPressed: () {
                    _showStatusOptions(context);
                  },
                  icon: const Icon(Icons.more_vert, color: Colors.white),
                ),
              ],
            ),
          ),

          // My Status Card
          Container(
            padding: const EdgeInsets.all(16),
            child: Row(
              children: [
                Stack(
                  children: [
                    const CircleAvatar(
                      radius: 30,
                      backgroundColor: Colors.grey,
                      child: Text(
                        'My',
                        style: TextStyle(
                          color: Colors.white,
                          fontWeight: FontWeight.bold,
                          fontSize: 14,
                        ),
                      ),
                    ),
                    Positioned(
                      bottom: 0,
                      right: 0,
                      child: Container(
                        padding: const EdgeInsets.all(2),
                        decoration: const BoxDecoration(
                          color: Color(0xFF00A884),
                          shape: BoxShape.circle,
                        ),
                        child: const Icon(
                          Icons.add,
                          color: Colors.white,
                          size: 16,
                        ),
                      ),
                    ),
                  ],
                ),
                const SizedBox(width: 16),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      const Text(
                        'My Status',
                        style: TextStyle(
                          fontSize: 18,
                          fontWeight: FontWeight.w600,
                          color: Colors.black,
                        ),
                      ),
                      const SizedBox(height: 4),
                      Text(
                        'Tap to add status update',
                        style: TextStyle(
                          color: Colors.grey[600],
                          fontSize: 14,
                        ),
                      ),
                    ],
                  ),
                ),
                IconButton(
                  onPressed: () {
                    _createNewStatus(context);
                  },
                  icon: const Icon(Icons.camera_alt, color: Color(0xFF00A884)),
                ),
              ],
            ),
          ),

          const Divider(height: 1),

          // Recent Updates Section
          if (recentStatuses.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  Text(
                    'Recent updates',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: recentStatuses.length,
                itemBuilder: (context, index) {
                  final status = recentStatuses[index];
                  return _buildStatusItem(context, status, isRecent: true);
                },
              ),
            ),
          ],

          // Viewed Updates Section
          if (viewedStatuses.isNotEmpty) ...[
            Container(
              padding: const EdgeInsets.all(16),
              child: const Row(
                children: [
                  Text(
                    'Viewed updates',
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: Colors.black,
                    ),
                  ),
                ],
              ),
            ),
            Expanded(
              child: ListView.builder(
                itemCount: viewedStatuses.length,
                itemBuilder: (context, index) {
                  final status = viewedStatuses[index];
                  return _buildStatusItem(context, status, isRecent: false);
                },
              ),
            ),
          ],
        ],
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00A884),
        onPressed: () {
          _createNewStatus(context);
        },
        child: const Icon(Icons.camera_alt, color: Colors.white),
      ),
    );
  }

  Widget _buildStatusItem(BuildContext context, Map<String, dynamic> status, {required bool isRecent}) {
    return ListTile(
      onTap: () {
        _viewStatus(context, status);
      },
      leading: Container(
        decoration: BoxDecoration(
          shape: BoxShape.circle,
          border: Border.all(
            color: isRecent ? const Color(0xFF00A884) : Colors.grey,
            width: 3,
          ),
        ),
        child: CircleAvatar(
          radius: 25,
          backgroundColor: Colors.grey,
          child: Text(
            status['avatar'],
            style: const TextStyle(
              color: Colors.white,
              fontWeight: FontWeight.bold,
            ),
          ),
        ),
      ),
      title: Text(
        status['name'],
        style: const TextStyle(
          fontSize: 17,
          fontWeight: FontWeight.w600,
          color: Colors.black,
        ),
      ),
      subtitle: Text(
        status['time'],
        style: const TextStyle(color: Colors.black54),
      ),
      trailing: status['hasStatus']
          ? IconButton(
              onPressed: () {
                _createNewStatus(context);
              },
              icon: const Icon(Icons.more_horiz, color: Colors.grey),
            )
          : null,
    );
  }

  void _showStatusOptions(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          padding: const EdgeInsets.symmetric(vertical: 20),
          child: Column(
            mainAxisSize: MainAxisSize.min,
            children: [
              ListTile(
                leading: const Icon(Icons.visibility_off),
                title: const Text('Status privacy'),
                onTap: () {
                  Navigator.pop(context);
                  _showPrivacySettings(context);
                },
              ),
              ListTile(
                leading: const Icon(Icons.settings),
                title: const Text('Settings'),
                onTap: () {
                  Navigator.pop(context);
                  // Navigate to status settings
                },
              ),
            ],
          ),
        );
      },
    );
  }

  void _showPrivacySettings(BuildContext context) {
    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text('Status privacy'),
          content: const Text('Choose who can see your status updates'),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('My contacts'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('My contacts except...'),
            ),
            TextButton(
              onPressed: () => Navigator.pop(context),
              child: const Text('Only share with...'),
            ),
          ],
        );
      },
    );
  }

  void _createNewStatus(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return Container(
          height: 200,
          padding: const EdgeInsets.all(20),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const Text(
                'Choose status type',
                style: TextStyle(
                  fontSize: 18,
                  fontWeight: FontWeight.bold,
                ),
              ),
              const SizedBox(height: 20),
              Row(
                children: [
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00A884),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.text_fields,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Text',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: BoxDecoration(
                            color: const Color(0xFF00A884),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.camera_alt,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Photo',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                  Expanded(
                    child: Column(
                      children: [
                        Container(
                          width: 60,
                          height: 60,
                          decoration: const BoxDecoration(
                            color: Color(0xFF00A884),
                            shape: BoxShape.circle,
                          ),
                          child: const Icon(
                            Icons.videocam,
                            color: Colors.white,
                            size: 30,
                          ),
                        ),
                        const SizedBox(height: 8),
                        const Text(
                          'Video',
                          style: TextStyle(fontSize: 14),
                        ),
                      ],
                    ),
                  ),
                ],
              ),
            ],
          ),
        );
      },
    );
  }

  void _viewStatus(BuildContext context, Map<String, dynamic> status) {
    Navigator.push(
      context,
      MaterialPageRoute(
        builder: (context) => StatusViewerScreen(
          status: status,
        ),
      ),
    );
  }
}

class StatusViewerScreen extends StatefulWidget {
  final Map<String, dynamic> status;

  const StatusViewerScreen({super.key, required this.status});

  @override
  State<StatusViewerScreen> createState() => _StatusViewerScreenState();
}

class _StatusViewerScreenState extends State<StatusViewerScreen> {
  double _progress = 0.0;
  Timer? _timer;

  @override
  void initState() {
    super.initState();
    _startProgressTimer();
  }

  @override
  void dispose() {
    _timer?.cancel();
    super.dispose();
  }

  void _startProgressTimer() {
    _timer = Timer.periodic(const Duration(milliseconds: 50), (timer) {
      setState(() {
        _progress += 0.01;
        if (_progress >= 1.0) {
          _progress = 0.0;
          Navigator.pop(context);
        }
      });
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.black,
      body: SafeArea(
        child: Stack(
          children: [
            // Status content
            Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  CircleAvatar(
                    radius: 40,
                    backgroundColor: Colors.grey[700],
                    child: Text(
                      widget.status['avatar'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 20,
                        fontWeight: FontWeight.bold,
                      ),
                    ),
                  ),
                  const SizedBox(height: 20),
                  Text(
                    widget.status['name'],
                    style: const TextStyle(
                      color: Colors.white,
                      fontSize: 24,
                      fontWeight: FontWeight.bold,
                    ),
                  ),
                  const SizedBox(height: 10),
                  Text(
                    widget.status['time'],
                    style: const TextStyle(
                      color: Colors.grey,
                      fontSize: 16,
                    ),
                  ),
                  const SizedBox(height: 30),
                  Container(
                    padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 15),
                    decoration: BoxDecoration(
                      color: Colors.white.withOpacity(0.1),
                      borderRadius: BorderRadius.circular(20),
                    ),
                    child: Text(
                      widget.status['statusContent'],
                      style: const TextStyle(
                        color: Colors.white,
                        fontSize: 18,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ),
                ],
              ),
            ),

            // Progress bar
            Positioned(
              top: 0,
              left: 0,
              right: 0,
              child: Container(
                height: 3,
                color: Colors.grey.withOpacity(0.3),
                child: FractionallySizedBox(
                  alignment: Alignment.centerLeft,
                  widthFactor: _progress,
                  child: Container(
                    color: const Color(0xFF00A884),
                  ),
                ),
              ),
            ),

            // Reply button
            Positioned(
              bottom: 100,
              left: 0,
              right: 0,
              child: Center(
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 12),
                  decoration: BoxDecoration(
                    color: Colors.white.withOpacity(0.1),
                    borderRadius: BorderRadius.circular(25),
                  ),
                  child: const Text(
                    'Reply',
                    style: TextStyle(
                      color: Colors.white,
                      fontSize: 16,
                    ),
                  ),
                ),
              ),
            ),

            // Back button
            Positioned(
              top: 20,
              left: 20,
              child: IconButton(
                onPressed: () => Navigator.pop(context),
                icon: const Icon(Icons.arrow_back, color: Colors.white),
              ),
            ),

            // More options
            Positioned(
              top: 20,
              right: 20,
              child: IconButton(
                onPressed: () {},
                icon: const Icon(Icons.more_vert, color: Colors.white),
              ),
            ),
          ],
        ),
      ),
    );
  }
}