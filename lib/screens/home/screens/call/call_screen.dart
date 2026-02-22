import 'package:flutter/material.dart';
import 'package:whatsapp/screens/home/screens/call/audio_call.dart';
import 'package:whatsapp/screens/home/screens/call/video_call.dart';

class CallScreen extends StatelessWidget {
  const CallScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: Colors.white,
      body: ListView.separated(
        padding: const EdgeInsets.symmetric(vertical: 5),
        separatorBuilder: (context, index) => const Divider(
          color: Colors.grey,
          indent: 80,
          endIndent: 15,
          height: 10,
        ),
        itemCount: 10,
        itemBuilder: (context, index) => ListTile(
          onTap: () {
            // Navigate to audio call screen
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => AudioCallScreen(
                  callerName: "Muhammad Sohail",
                  callerImage: "AH",
                  isIncoming: index.isEven,
                ),
              ),
            );
          },
          tileColor: Colors.white,
          leading: const CircleAvatar(
            radius: 25,
            backgroundColor: Colors.grey,
            child: Text(
              'AH',
              style: TextStyle(
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),
          title: const Text(
            "Muhammad Sohail",
            style: TextStyle(
              fontSize: 17,
              fontWeight: FontWeight.w600,
              color: Colors.black,
            ),
          ),
          subtitle: Row(
            children: [
              Icon(
                index.isEven ? Icons.call_made : Icons.call_received,
                color: index.isEven ? Colors.green : Colors.red,
                size: 18,
              ),
              const SizedBox(width: 6),
              const Text(
                '35 minutes ago',
                style: TextStyle(color: Colors.black54),
              ),
            ],
          ),
          trailing: IconButton(
            onPressed: () {
              // Navigate to video call screen for making a video call
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
            icon: Icon(
              index.isEven ? Icons.call : Icons.videocam,
              color: Colors.green,
            ),
          ),
        ),
      ),
      floatingActionButton: FloatingActionButton(
        backgroundColor: const Color(0xFF00A884),
        onPressed: () {
          // Navigate to new call screen (could be a contact picker)
          _showContactPicker(context);
        },
        child: const Icon(Icons.add_call, color: Colors.white),
      ),
    );
  }

  void _showContactPicker(BuildContext context) {
    showModalBottomSheet(
      context: context,
      builder: (BuildContext context) {
        return SizedBox(
          height: 200,
          child: Column(
            children: [
              Container(
                padding: const EdgeInsets.all(16),
                child: const Text(
                  'Start a Call',
                  style: TextStyle(fontSize: 18, fontWeight: FontWeight.bold),
                ),
              ),
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Text('AH'),
                ),
                title: const Text('Muhammad Sohail'),
                subtitle: const Text('Recent contact'),
                onTap: () {
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
              ListTile(
                leading: const CircleAvatar(
                  backgroundColor: Colors.grey,
                  child: Icon(Icons.videocam, color: Colors.white, size: 20),
                ),
                title: const Text('Video Call - Muhammad Sohail'),
                subtitle: const Text('Start video call'),
                onTap: () {
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
              ListTile(
                leading: const Icon(Icons.search),
                title: const Text('Search contacts'),
                onTap: () {
                  Navigator.pop(context); // Close bottom sheet
                  // Navigate to contact search screen (placeholder)
                },
              ),
            ],
          ),
        );
      },
    );
  }
}
