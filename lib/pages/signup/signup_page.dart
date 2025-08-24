import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/custom_divider.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/custom_text_field.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';
import 'package:loomi_chalenge/components/social_icon_apple.dart';
import 'package:loomi_chalenge/components/social_icon_google.dart';
import 'package:loomi_chalenge/controllers/signup_controller.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:loomi_chalenge/utils/field_masks.dart';
import 'package:loomi_chalenge/utils/field_validatons.dart';

class SignupPage extends StatefulWidget {
  const SignupPage({super.key});

  @override
  State<SignupPage> createState() => _SignupPageState();
}

class _SignupPageState extends State<SignupPage> {

  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  final SignupController _signupController = Get.put(SignupController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 20),
        child: Form(
          key: _formKey,
          child: Center(
            child: ConstrainedBox(
              constraints: BoxConstraints(maxWidth: 500),
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/img/logo.png',
                      width: 150,
                      height: 150,
                    ),
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Already have an account?",
                        style: Theme.of(context).textTheme.bodyLarge!.copyWith(
                          color: AppTheme.secondaryDarkColor,
                        ),
                      ),
                      CustomTextButton(
                        label: "Sign In!",
                        onPressed: () {
                          Get.offNamed(AppRoutes.login);
                        },
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Create Account",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "To get started, please complete your account registration.",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSocialIconGoogle(
                        onPressed: () {
                          _signupController.loginWithGoogle();
                        },
                      ),
                      SizedBox(width: 16),
                      CustomSocialIconApple(),
                    ],
                  ),
                  SizedBox(height: 40),
                  CustomDivider(
                    text: "Or Sign up With",
                  ),
                  SizedBox(height: 40),
                  CustomTextField(
                    title: "Email",
                    hintText: "Enter your email",
                    inputFormatters: FieldMasks.formatEmail(),
                    validator: FieldValidations.validateEmail,
                    controller: _signupController.emailController,
                  ),
                  CustomTextField(
                    title: "Password",
                    hintText: "Enter your password",
                    obscureText: true,
                    controller: _signupController.passwordController,
                    validator: FieldValidations.validatePassword,
                  ),
                  CustomTextField(
                    title: "Confirm Password",
                    hintText: "Confirm your password",
                    obscureText: true,
                    controller: _signupController.confirmPasswordController,
                    validator: (value) => FieldValidations.validateEqualPassword(
                      _signupController.passwordController.text,
                      value,
                    ),
                  ),

                  SizedBox(height: 20),
                  CustomButton(
                    label: "Create Account",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        Get.toNamed(
                          AppRoutes.confirmSignup,
                        );
                      }
                    },
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
