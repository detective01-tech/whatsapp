import 'dart:async';

import 'package:flutter/material.dart';

import '../../widgets/ui_helpers.dart';
import '../onboardingScreen/onboarding_screen.dart';

class SplashScreen extends StatefulWidget {
  const SplashScreen({super.key});

  @override
  State<SplashScreen> createState() => _SplashScreenState();
}

class _SplashScreenState extends State<SplashScreen> {
  @override
  void initState() {
    Timer(Duration(seconds: 5), () {
      Navigator.pushReplacement(
        context,
        MaterialPageRoute(builder: (context) => OnboardingScreen()),
      );
    });
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.center,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset(height: 80, "assets/images/logo.png"),
            SizedBox(height: 5,),
            UiHelpers.customText(
              text: 'WhatsApp',
              fonts: 16,
              color: Colors.black,
            ),
          ],
        ),
      ),
    );
  }
}
