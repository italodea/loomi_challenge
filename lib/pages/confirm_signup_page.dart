import 'package:flutter/material.dart';
import 'package:get/get_state_manager/src/rx_flutter/rx_obx_widget.dart';
import 'package:get/route_manager.dart';
import 'package:loomi_chalenge/components/custom_image_picker_modal.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/custom_text_field.dart';
import 'package:loomi_chalenge/components/cutom_button.dart';
import 'package:loomi_chalenge/components/upload_button.dart';
import 'package:loomi_chalenge/controllers/signup_controller.dart';

class ConfirmSignupPage extends StatefulWidget {
  const ConfirmSignupPage({super.key, required this.userId});

  final String userId;

  @override
  State<ConfirmSignupPage> createState() => _ConfirmSignupPageState();
}

class _ConfirmSignupPageState extends State<ConfirmSignupPage> {

  final controller = SignupController();
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
                    imagePath: controller.userImage.firstOrNull?.path,
                    onTap: (){
                      showModalBottomSheet(context: context, builder: (context) {
                        return CustomImagePickerModal();
                      },);
                    }
                  ),
                ),
                SizedBox(height: 50),
                CustomTextField(
                  controller: controller.userNameController,
                  title: "Your Name",
                  hintText: "Enter your name",
                ),
                SizedBox(height: 50),
                CustomButton(label: "Continue", onPressed: () {}),
                SizedBox(height: 20),
                CustomTextButton(label: "Back", onPressed: () {
                  Get.back();
                }),
              ],
            ),
          ),
        ),
      ),
    );
  }
}