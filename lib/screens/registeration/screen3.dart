import 'dart:io';

import 'package:flutter/material.dart';
import 'package:whatsapp/widgets/ui_helpers.dart';
import 'package:image_picker/image_picker.dart';
import '../home/home.dart';

class Profile extends StatefulWidget {
  const Profile({super.key});

  @override
  State<Profile> createState() => _ProfileState();
}

class _ProfileState extends State<Profile> {

  XFile? imageFile;


  Future<void> imageSelect() async {
    final ImagePicker picker = ImagePicker();
    final XFile? image = await picker.pickImage(source: ImageSource.gallery);

    if (image != null) {
      setState(() {
        imageFile = image;
      });
    }

  }
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: UiHelpers.customText(
          fontsWeight: FontWeight.w600,
          text: 'Profile info',
          fonts: 18,
          color: Color(0xFF00A884),
        ),
      ),
      body: Center(
        child: Padding(
          padding: const EdgeInsets.all(20.0),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              UiHelpers.customText(
                text: 'Please provide your name and an optional',
                fonts: 16,
                fontsWeight: FontWeight.w400,
              ),
              UiHelpers.customText(
                text: 'profile photo',
                fonts: 16,
                fontsWeight: FontWeight.w400,
              ),
              SizedBox(height: 20),
              CircleAvatar(
                radius: 80,
                backgroundColor: Colors.black12,
                backgroundImage:
                imageFile != null ? FileImage(File(imageFile!.path)) : null,
                child: imageFile == null
                    ? InkWell(
                  onTap: imageSelect,
                  child: Image.asset(
                    'assets/images/camera.png',
                    width: 50,
                    height: 50,
                    color: Colors.grey,
                  ),
                )
                    : null,
              ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 10),
                child: TextField(
                  decoration: InputDecoration(
                    labelText: 'Type your name here',
                    border: UnderlineInputBorder(
                      borderSide: BorderSide(color: Color(0xFF00A884)),
                    ),
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: UiHelpers.customButton(
        callback: () {
          Navigator.pushReplacement(context, MaterialPageRoute(builder: (context) => HomeScreen(),));
        },
        bgColor: Color(0xFF00A884),
        buttonName: 'Next',
      ),
    );
  }
}
