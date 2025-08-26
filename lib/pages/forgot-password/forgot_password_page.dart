import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/animated_spacer.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/custom_text_field.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';
import 'package:loomi_chalenge/controllers/forgot_password_controller.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/utils/field_masks.dart';
import 'package:loomi_chalenge/utils/field_validatons.dart';

class ForgotPasswordPage extends StatefulWidget {
  const ForgotPasswordPage({super.key});

  @override
  State<ForgotPasswordPage> createState() => _ForgotPasswordPageState();
}

class _ForgotPasswordPageState extends State<ForgotPasswordPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final ForgotPasswordController _controller = Get.put(ForgotPasswordController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Form(
              key: _formKey,
              child: Column(
                children: [
                  Center(
                    child: Image.asset(
                      'assets/img/logo_minimal.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  AnimatedSpacer(beginHeight: 50, endHeight: 30),
                  Text(
                    "Forgot Password?",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  AnimatedSpacer(beginHeight: 50, endHeight: 30),
                  Text(
                    "Enter the email address you used when you joined and we’ll send you instructions to reset your password.",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  AnimatedSpacer(beginHeight: 70, endHeight: 40),
                  CustomTextField(
                    title: "Email",
                    hintText: "Enter your email",
                    inputFormatters: FieldMasks.formatEmail(),
                    validator: FieldValidations.validateEmail,
                    controller: _controller.emailController,
                  ),
                  AnimatedSpacer(beginHeight: 100, endHeight: 170),
                  SizedBox(
                    height: MediaQuery.of(context).size.height - 700 < 0
                        ? 0
                        : MediaQuery.of(context).size.height - 700,
                  ),
                  CustomButton(
                    label: "Send Instructions",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await _controller.sendPasswordResetEmail();
                        Get.offNamed(AppRoutes.emailSent);
                      }
                    },
                  ),
                  SizedBox(height: 12),
                  CustomTextButton(
                    label: "Back",
                    onPressed: () {
                      Navigator.pop(context);
                    },
                  ),
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
