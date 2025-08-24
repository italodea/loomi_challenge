import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/custom_image_picker_modal.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/custom_text_field.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';
import 'package:loomi_chalenge/components/upload_button.dart';
import 'package:loomi_chalenge/controllers/signup_controller.dart';
import 'package:loomi_chalenge/routes/app_routes.dart';
import 'package:loomi_chalenge/utils/field_validatons.dart';

class ConfirmSignupPage extends StatefulWidget {
  ConfirmSignupPage({super.key});

  final SignupController controller = Get.put(SignupController());

  @override
  State<ConfirmSignupPage> createState() => _ConfirmSignupPageState();
}

class _ConfirmSignupPageState extends State<ConfirmSignupPage> {
  final GlobalKey<FormState> _formKey = GlobalKey<FormState>();
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 40),
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
                      'assets/img/logo_minimal.png',
                      width: 40,
                      height: 40,
                    ),
                  ),
                  SizedBox(height: 20),
                  Text(
                    "Tell us more!",
                    style: Theme.of(context).textTheme.titleLarge,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 10),
                  Text(
                    "Complete your profile",
                    style: Theme.of(context).textTheme.bodyMedium,
                    textAlign: TextAlign.center,
                  ),
                  SizedBox(height: 50),
                  Obx(
                    () => UploadImageComponent(
                      imagePath: widget.controller.userImage.firstOrNull?.path,
                      onTap: () {
                        showModalBottomSheet(
                          context: context,
                          builder: (context) {
                            return CustomImagePickerModal(
                              onPressCamera:
                                  widget.controller.pickImageFromCamera,
                              onPressGallery:
                                  widget.controller.pickImageFromGallery,
                            );
                          },
                        );
                      },
                    ),
                  ),
                  SizedBox(height: 50),
                  CustomTextField(
                    controller: widget.controller.userNameController,
                    title: "Your Name",
                    hintText: "Enter your name",
                    validator: (value) =>
                        FieldValidations.validateMinimumLengh(value, "name", 3),
                  ),
                  SizedBox(height: 50),
                  CustomButton(
                    label: "Continue",
                    onPressed: () async {
                      if (_formKey.currentState!.validate()) {
                        await widget.controller.registerWithEmailAndPassword();

                        Get.offAllNamed(AppRoutes.home);
                      }
                    },
                  ),
                  SizedBox(height: 20),
                  CustomTextButton(
                    label: "Back",
                    onPressed: () {
                      Get.back();
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
