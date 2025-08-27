import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/custom_circle_avatar.dart';
import 'package:loomi_chalenge/components/custom_icon_button.dart';
import 'package:loomi_chalenge/components/custom_text_field.dart';
import 'package:loomi_chalenge/components/dot_loading_indicator.dart';
import 'package:loomi_chalenge/controllers/comment_card_controller.dart';
import 'package:loomi_chalenge/controllers/watch_movie_controller.dart';
import 'package:loomi_chalenge/themes/app_icons.dart';

class InputComment extends StatelessWidget {
  InputComment({super.key});

  final CommentCardController controller = Get.put(CommentCardController());
  final WatchMovieController watchMovieController = Get.find<WatchMovieController>();

  @override
  Widget build(BuildContext context) {
    return Obx(() {
      if (controller.currentUser.value == null) {
        return Center(child: DotLoadingIndicator());
      }
      return InkWell(
        highlightColor: Colors.transparent,
        focusColor: Colors.transparent,
        hoverColor: Colors.transparent,
        onTap: (){
          if (!controller.isFullyExpanded.value) {
            controller.toggleFullyExpanded();
            watchMovieController.toggleInterface();
            watchMovieController.setVertical();
          }
        },
        child: Row(
          children: [
            CustomCircleAvatar(
              userName: controller.currentUser.value!.displayName ?? '',
              imageUrl: controller.currentUser.value!.photoURL ?? '',
            ),
            SizedBox(width: 12),
            Expanded(
              child: CustomTextField(
                hintText: 'Add a reply...',
                controller: controller.commentController,
              ),
            ),
            SizedBox(width: 12),
            controller.isFullyExpanded.value ? CustomIconButton(
              padding: EdgeInsets.zero,
              margin: EdgeInsets.zero,
              onPressed: () async {
                await controller.sendComment(watchMovieController.movie!);
                await watchMovieController.loadComments();
              },
              maximumSize: Size(40, 40),
              minimumSize: Size(40, 40),
              backgroundColor: Colors.transparent,
              icon: AppIcons.icon(AppIcons.send, fit: BoxFit.cover, size: 24),
            ) : Container(),
          ],
        ),
      );
    });
  }
}
