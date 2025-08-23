import 'package:flutter/material.dart';
import 'package:loomi_chalenge/components/custom_icon_button.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class CustomImagePickerModal extends StatefulWidget {
  const CustomImagePickerModal({super.key});

  @override
  State<CustomImagePickerModal> createState() => _CustomImagePickerModalState();
}

class _CustomImagePickerModalState extends State<CustomImagePickerModal> {
  @override
  Widget build(BuildContext context) {
    return Container(
      width: double.infinity,
      decoration: BoxDecoration(
        color: AppTheme.backgroundColor,
        borderRadius: BorderRadius.only(
          topLeft: Radius.circular(20),
          topRight: Radius.circular(20),
        ),
      ),
      height: 400,
      child: SingleChildScrollView(
        child: Column(
          children: [
            Row(
              children: [
                CustomIconButton(
                  backgroundColor: Colors.transparent,
                  icon: Icon(Icons.arrow_back_ios, color: AppTheme.primaryColor),
                  onPressed: () {
                    // Handle image picking
                  },
                ),
                Expanded(
                  child: Text(
                    "CHOOSE IMAGE",
                    style: AppTheme.textThemeSecondary.labelLarge,
                  ),
                ),
              ],
            ),
            SizedBox(height: 16),
            Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                CustomIconButton(
                  icon: AppIcons.icon(AppIcons.camera, color: AppTheme.primaryColor),
                  label: "Take a photo",
                  border: BorderSide(color: AppTheme.primaryColor),
                  onPressed: () {
                    // Handle image picking
                  },
                ),
                SizedBox(width: 16),
                CustomIconButton(
                  icon: AppIcons.icon(AppIcons.gallery, color: AppTheme.textColor),
                  label: "Choose from gallery",
                  backgroundColor: AppTheme.backgroundInputColor,
                  border: BorderSide(color: AppTheme.borderColor),
                  onPressed: () {
                    // Handle image picking
                  },
                ),
              ],
            )
          ],
        ),
      ),
    );
  }
}
