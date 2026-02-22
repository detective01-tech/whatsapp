import 'package:flutter/material.dart';
import 'package:pinput/pinput.dart';
import 'package:whatsapp/screens/registeration/screen3.dart';
import 'package:intl_phone_number_input/intl_phone_number_input.dart';
import 'package:whatsapp/widgets/ui_helpers.dart';

class CodeNumber extends StatefulWidget {
  final PhoneNumber number;
  const CodeNumber({required this.number, super.key});

  @override
  State<CodeNumber> createState() => _CodeNumberState();
}

class _CodeNumberState extends State<CodeNumber> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        centerTitle: true,
        automaticallyImplyLeading: false,
        title: UiHelpers.customText(
          fontsWeight: FontWeight.w600,
          text: 'Verifying your number',
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
                text: 'You’ve tried to register ${widget.number.phoneNumber}',
                fonts: 16,
                fontsWeight: FontWeight.w400,
              ),
              UiHelpers.customText(
                text: 'recently. Wait before requesting an sms or a call.',
                fonts: 16,
                fontsWeight: FontWeight.w400,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  UiHelpers.customText(
                    text: ' with your code.',
                    fonts: 16,
                    fontsWeight: FontWeight.w400,
                  ),
                  InkWell(
                    onTap: () {},
                    child: UiHelpers.customText(
                      color: Color(0xFF00A884),
                      text: ' Wrong number?',
                      fonts: 16,
                      fontsWeight: FontWeight.w400,
                    ),
                  ),
                ],
              ),
              Container(
                margin: EdgeInsets.symmetric(horizontal: 25, vertical: 25),
                child: Pinput(
                  obscureText: true,
                  length: 6,
                  keyboardType: TextInputType.number,
                ),
              ),
              InkWell(
                onTap: () {},
                child: UiHelpers.customText(
                  color: Color(0xFF00A884),
                  text: 'Didn’t receive code?',
                  fonts: 16,
                  fontsWeight: FontWeight.w400,
                ),
              ),
            ],
          ),
        ),
      ),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerFloat,
      floatingActionButton: UiHelpers.customButton(
        callback: () {
          Navigator.pushReplacement(
            context,
            MaterialPageRoute(builder: (context) => Profile()),
          );
        },
        bgColor: Color(0xFF00A884),
        buttonName: 'Next',
      ),
    );
  }
}
