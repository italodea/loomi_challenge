import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/custom_divider.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/custom_text_field.dart';
import 'package:loomi_chalenge/components/custom_button.dart';
import 'package:loomi_chalenge/components/social_icon_apple.dart';
import 'package:loomi_chalenge/components/social_icon_google.dart';
import 'package:loomi_chalenge/controllers/signin_controller.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:loomi_chalenge/utils/field_masks.dart';
import 'package:loomi_chalenge/utils/field_validatons.dart';

class LoginPage extends StatefulWidget {
  const LoginPage({super.key});

  @override
  State<LoginPage> createState() => _LoginPageState();
}

class _LoginPageState extends State<LoginPage> {

  final SigninController _controller = Get.put(SigninController());

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
              key: _controller.formKey,
              child: Column(
                mainAxisSize: MainAxisSize.min,
                children: [
                  Center(
                    child: Image.asset(
                      'assets/img/logo_minimal.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Welcome Back",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Look who is here!",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 30),
                  CustomTextField(
                    title: "Email",
                    hintText: "Enter your email",
                    inputFormatters: FieldMasks.formatEmail(),
                    validator: FieldValidations.validateEmail,
                    controller: _controller.emailController,
                  ),
                  CustomTextField(
                    title: "Password",
                    hintText: "Enter your password",
                    obscureText: true,
                    controller: _controller.passwordController,
                    validator: FieldValidations.validatePassword,
                  ),
                  Align(
                    alignment: Alignment.centerRight,
                    child: TextButton(
                      onPressed: () {
                        Get.toNamed(AppRoutes.forgotPassword);
                      },
                      child: Text(
                        "Forgot Password?",
                        style: TextStyle(color: Theme.of(context).primaryColor),
                      ),
                    ),
                  ),
                  SizedBox(height: 30),
                  CustomButton(
                    label: "Login",
                    onPressed: _controller.signIn,
                  ),
                  SizedBox(height: 20),
                  CustomDivider(text: "Or Sign in With"),
                  SizedBox(height: 20),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      CustomSocialIconGoogle(
                        onPressed: _controller.signInWithGoogle,
                      ),
                      SizedBox(width: 16),
                      CustomSocialIconApple(),
                    ],
                  ),
                  SizedBox(height: 30),
                  Row(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Text(
                        "Don't have an account?",
                        style: Theme.of(context).textTheme.bodyLarge!
                            .copyWith(
                              color: AppTheme.secondaryDarkColor,
                            ),
                      ),
                      CustomTextButton(
                        label: "Sign Up",
                        onPressed: () {
                          Get.offNamed(AppRoutes.signup);
                        },
                      ),
                    ],
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
