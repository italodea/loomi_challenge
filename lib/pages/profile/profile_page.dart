import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/custom_button.dart';
import 'package:loomi_chalenge/components/custom_circle_avatar.dart';
import 'package:loomi_chalenge/components/custom_icon_button.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/expanded_button.dart';
import 'package:loomi_chalenge/components/loading_effect.dart';
import 'package:loomi_chalenge/controllers/profile_controller.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:loomi_chalenge/utils/time_convert.dart';

class ProfilePage extends StatelessWidget {
  ProfilePage({super.key});

  final ProfileController profileController = Get.put(ProfileController());

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(),
      body: SingleChildScrollView(
        padding: const EdgeInsets.only(right: 12, left: 12, top: 40),
        child: Center(
          child: ConstrainedBox(
            constraints: BoxConstraints(maxWidth: 500),
            child: Obx(() {
              bool loading = profileController.user.value == null;
              return Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      CustomIconButton(
                        icon: Icon(
                          Icons.arrow_back_ios,
                          color: AppTheme.activeBorderColor,
                        ),
                        onPressed: () {
                          Get.back();
                        },
                        maximumSize: Size(50, 50),
                        minimumSize: Size(50, 50),
                        padding: EdgeInsets.zero,
                        backgroundColor: Colors.transparent,
                        margin: EdgeInsets.zero,
                      ),
                      CustomButton(
                        label: 'Edit Profile',
                        onPressed: () async {},
                        maximumSize: Size(120, 60),
                        minimumSize: Size(20, 20),
                        padding: EdgeInsets.symmetric(
                          horizontal: 18,
                          vertical: 12,
                        ),
                        opacity: 0,
                        textStyle: AppTheme.textThemeSecondary.displayMedium!
                            .copyWith(color: AppTheme.primaryColor),
                        shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(20),
                        ),
                        side: BorderSide(color: AppTheme.primaryDarkColor),
                      ),
                    ],
                  ),
                  Row(
                    children: [
                      LoadingEffect(
                        loaded: !loading,
                        child: CustomCircleAvatar(
                          userName:
                              profileController.user.value!.displayName ?? '',
                          imageUrl: profileController.user.value!.photoURL,
                          maxRadius: 40,
                        ),
                      ),
                      SizedBox(width: 12),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.start,
                        children: [
                          LoadingEffect(
                            loaded: !loading,
                            child: Text(
                              "Hello,",
                              style: AppTheme.textThemeSecondary.displaySmall,
                            ),
                          ),
                          SizedBox(height: 4),
                          LoadingEffect(
                            loaded: !loading,
                            child: Text(
                              profileController.user.value?.displayName ??
                                  'Loading...',
                              style: AppTheme.textThemeSecondary.displayLarge,
                            ),
                          ),
                        ],
                      ),
                    ],
                  ),
                  SizedBox(height: 40),
                  ExpandedButton(
                    label: "Change password",
                    icon: AppIcons.shield,
                    onPressed: () {},
                  ),
                  ExpandedButton(
                    label: "Delete my account",
                    icon: AppIcons.trash,
                    onPressed: () {
                      showModalBottomSheet(
                        context: context,
                        backgroundColor: AppTheme.backgroundColor,
                        constraints: BoxConstraints(minHeight: 350, maxHeight: 600),
                        builder: (BuildContext context) {
                          return SingleChildScrollView(
                            child: Padding(
                              padding: EdgeInsetsGeometry.only(),
                              child: Column(
                                children: [
                                  SizedBox(height: 12),
                                  Row(
                                    children: [
                                      CustomIconButton(
                                        icon: Icon(
                                          Icons.arrow_back_ios,
                                          color: AppTheme.activeBorderColor,
                                        ),
                                        onPressed: () {
                                          Get.back();
                                        },
                                        maximumSize: Size(50, 50),
                                        minimumSize: Size(50, 50),
                                        padding: EdgeInsets.zero,
                                        backgroundColor: Colors.transparent,
                                        margin: EdgeInsets.zero,
                                      ),
                                      Expanded(
                                        child: Center(
                                          child: Text(
                                            "Warning",
                                            style: AppTheme
                                                .textThemeSecondary
                                                .displayMedium,
                                          ),
                                        ),
                                      ),
                                      SizedBox(width: 50),
                                    ],
                                  ),
                                  Padding(
                                    padding: EdgeInsets.only(
                                      left: 40.0,
                                      right: 40.0,
                                      top: 12.0,
                                      bottom: 12.0,
                                    ),
                                    child: Column(
                                      children: [
                                        Text(
                                          "Are you sure you want to delete your account?",
                                          style: AppTheme
                                              .textThemeSecondary
                                              .displayMedium,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 12),
                                        Text(
                                          "This action is irreversible and all of your data will be permanently deleted. If you're having any issues with our app, we'd love to help you resolve them.",
                                          style: AppTheme
                                              .textThemeSecondary
                                              .displaySmall,
                                          textAlign: TextAlign.center,
                                        ),
                                        SizedBox(height: 40),
                                        Row(
                                          children: [
                                            Expanded(
                                              child: CustomTextButton(
                                                label: "Cancel",
                                                onPressed: () {
                                                  Get.back();
                                                },
                                              ),
                                            ),
                                            Expanded(
                                              child: CustomButton(
                                                label: "Delete account",
                                                onPressed: profileController.deleteAccount,
                                                minimumSize: Size(150, 50),
                                              ),
                                            )
                                          ],
                                        ),
                                      ],
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          );
                        },
                      );
                    },
                  ),
                  SizedBox(height: 40),
                  Text(
                    "Subscriptions",
                    style: AppTheme.textThemeSecondary.displayLarge,
                  ),
                  ExpandedButton(
                    onPressed: () {},
                    prefix: Image.asset("assets/img/logo_premium.png"),
                    suffix: Text(
                      "Coming soon",
                      style: AppTheme.textThemeSecondary.bodySmall!.copyWith(
                        color: AppTheme.primaryColor,
                      ),
                    ),
                    child: Column(
                      crossAxisAlignment: CrossAxisAlignment.start,
                      children: [
                        Text(
                          "STREAM premium",
                          style: AppTheme.textThemeSecondary.displayMedium!
                              .copyWith(fontSize: 17),
                        ),
                        SizedBox(height: 4),
                        Text(
                          TimeConvert.formatTextDate(DateTime.now()),
                          style: AppTheme.textThemeSecondary.bodyMedium,
                        ),
                      ],
                    ),
                  ),
                  SizedBox(height: 40),
                  Center(
                    child: CustomButton(
                      label: "Log out",
                      onPressed: profileController.logout,
                      maximumSize: Size(120, 60),
                      minimumSize: Size(20, 20),
                      padding: EdgeInsets.symmetric(
                        horizontal: 28,
                        vertical: 15,
                      ),
                      opacity: 0,
                      textStyle: AppTheme.textThemeSecondary.displayMedium!,
                      shape: RoundedRectangleBorder(
                        borderRadius: BorderRadius.circular(20),
                      ),
                      side: BorderSide(color: AppTheme.textColor),
                    ),
                  ),
                ],
              );
            }),
          ),
        ),
      ),
    );
  }
}
