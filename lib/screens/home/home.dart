import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:whatsapp/screens/home/screens/call/call_screen.dart';
import 'package:whatsapp/screens/home/screens/chat/chat.dart';
import 'package:whatsapp/screens/home/screens/status/status.dart';

class HomeScreen extends StatelessWidget {
  const HomeScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
      length: 4, // camera + 3 tabs
      initialIndex: 1, // start from CHATS (like WhatsApp)
      child: Scaffold(
        appBar: AppBar(
          automaticallyImplyLeading: false,
          elevation: 0,
          backgroundColor: const Color(0xFF075E54),
          title: const Text(
            'WhatsApp',
            style: TextStyle(
              fontWeight: FontWeight.bold,
              color: Colors.white,
            ),
          ),
          actions: [
            IconButton(
              onPressed: (){},
              icon: const Icon(CupertinoIcons.search, color: Colors.white),
            ),
            const SizedBox(width: 8),
            PopupMenuButton<String>( iconColor: Colors.white,
              onSelected: (value) {
            },
              itemBuilder: (context) => const [
                PopupMenuItem(value: "new_group", child: Text("New group")),
                PopupMenuItem(value: "settings", child: Text("Settings")),
            ],),
            const SizedBox(width: 8),
          ],
          bottom: const TabBar(
            indicatorColor: Colors.white,
            labelColor: Colors.white,
            unselectedLabelColor: Colors.white70,
            labelStyle: TextStyle(fontWeight: FontWeight.bold),
            unselectedLabelStyle: TextStyle(fontWeight: FontWeight.normal),
            tabs: [
              SizedBox(width: 20, child: Tab(icon: Icon(Icons.camera_alt))),
              Expanded(child: Tab(text: "CHATS")),
              Expanded(child: Tab(text: "STATUS")),
              Expanded(child: Tab(text: "CALLS")),
            ],
          ),
        ),
        body: const TabBarView(
          children: [
            Center(child: Text("Camera Screen")),
            Chat(),
            Status(),
            CallScreen()
          ],
        ),
        floatingActionButton: FloatingActionButton(
          backgroundColor: const Color(0xFF00A884),
          onPressed: () {},
          child: const Icon(Icons.message, color: Colors.white),
        ),
      ),
    );
  }
}
