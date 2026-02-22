import 'package:flutter/material.dart';
import 'package:whatsapp/screens/registeration/screen1.dart';
import 'package:whatsapp/widgets/ui_helpers.dart';

class OnboardingScreen extends StatelessWidget {
  const OnboardingScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Column(
        crossAxisAlignment: CrossAxisAlignment.center,
        children: [
          Container(
            margin: EdgeInsets.only(top: 100, bottom: 40),
            height: 350,
            width: 350,
            decoration: BoxDecoration(
              image: DecorationImage(
                fit: BoxFit.cover,
                image: AssetImage('assets/images/onboarding_circle.png'),
              ),
              shape: BoxShape.circle,
            ),
          ),
          UiHelpers.customText(
            text: 'Welcome to WhatsApp',
            fonts: 20,
            fontsWeight: FontWeight.w400,
            color: Colors.black,
          ),
          SizedBox(height: 10),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiHelpers.customText(
                text: 'Read out ',
                fonts: 14,
                fontsWeight: FontWeight.w300,
              ),
              InkWell(onTap: (){},
                child: UiHelpers.customText(
                text: 'Privacy Policy.',
                fonts: 14,
                fontsWeight: FontWeight.w300,
                color: Colors.blueAccent,
              ),),
              UiHelpers.customText(
                text: 'Tap “Agree and continue” ',
                fonts: 14,
                fontsWeight: FontWeight.w300,
              ),
            ],
          ),
          SizedBox(height: 4),
          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              UiHelpers.customText(
                text: 'To accept the',
                fonts: 14,
                fontsWeight: FontWeight.w300,
              ),
              InkWell(onTap: (){},
                child: UiHelpers.customText(
                text: 'Teams of Service',
                fonts: 14,
                color: Colors.blueAccent,
                fontsWeight: FontWeight.w300,
              ),)
            ],
          ),
        ],
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: UiHelpers.customButton(
        callback: () {
          Navigator.push(context, MaterialPageRoute(builder: (context) => MobileNumber(),));
        },
        bgColor: Color(0xFF00A884),
        buttonName: 'Agree and continue',
      ),
    );
  }
}
