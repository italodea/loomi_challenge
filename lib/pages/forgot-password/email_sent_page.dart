import 'package:flutter/material.dart';
import 'package:get/route_manager.dart';
import 'package:loomi_chalenge/components/animated_spacer.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';

class EmailSent extends StatefulWidget {
  const EmailSent({super.key});

  @override
  State<EmailSent> createState() => _EmailSentState();
}

class _EmailSentState extends State<EmailSent> {

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Column(
              children: [
                Center(
                  child: Image.asset(
                    'assets/img/logo_minimal.png',
                    width: 40,
                    height: 40,
                  ),
                ),
                AnimatedSpacer(beginHeight: 20, endHeight: 60),
                SizedBox(
                  width: 250,
                  child: Text(
                    "The instructions were sent!",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                ),
                AnimatedSpacer(beginHeight: 20, endHeight: 60),
                Text(
                  "If this was a valid email, instructions to reset your password will be sent to you. Please check your email.",
                  style: Theme.of(context).textTheme.bodyMedium,
                  textAlign: TextAlign.center,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height - 550,
                ),
                AnimatedSpacer(beginHeight: 120, endHeight: 40),
                CustomButton(
                  label: "Login",
                  onPressed: () async {
                    Get.back();
                  },
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }
}
