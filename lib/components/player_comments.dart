import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/components/comment_card.dart';
import 'package:loomi_chalenge/components/custom_text_button.dart';
import 'package:loomi_chalenge/components/dot_loading_indicator.dart';
import 'package:loomi_chalenge/components/input_comment.dart';
import 'package:loomi_chalenge/controllers/comment_card_controller.dart';
import 'package:loomi_chalenge/controllers/watch_movie_controller.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';

class PlayerComments extends StatelessWidget {
  PlayerComments({super.key});

  final WatchMovieController controller = Get.find<WatchMovieController>();
  final CommentCardController commentCardController = Get.put(CommentCardController());

  @override
  Widget build(BuildContext context) {
    return Material(
      child: Container(
        color: AppTheme.backgroundColor,
        padding: EdgeInsets.symmetric(horizontal: 24, vertical: 16),
        width: 400,
        height: double.infinity,
        child: Obx(() {
          if (controller.comments.value == null) {
            return DotLoadingIndicator();
          }
          if (controller.comments.value!.isEmpty) {
            return Column(
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    CustomTextButton(
                      label: "Close",
                      onPressed: () {
                        controller.toggleComments();
                        if(commentCardController.isFullyExpanded.value){
                          commentCardController.toggleFullyExpanded();
                        }
                      },
                    ),
                  ],
                ),
                SizedBox(height: 20),
                Expanded(
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.center,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Align(
                        alignment: Alignment.center,
                        child: Text(
                          "No comments yet",
                          style: AppTheme.textThemeSecondary.displayMedium,
                        ),
                      ),
                    ],
                  ),
                ),
                InputComment(
                ),
              ],
            );
          }
          return Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Text(
                    "${controller.movie?.commentsCount ?? 0} Comments",
                    style: AppTheme.textThemeSecondary.displayLarge,
                  ),
                  CustomTextButton(
                    label: "Close",
                    onPressed: () {
                      controller.toggleComments();
                      if(commentCardController.isFullyExpanded.value){
                        commentCardController.toggleFullyExpanded();
                      }
                    },
                  ),
                ],
              ),
              Expanded(
                child: ListView.builder(
                  itemCount: controller.comments.value!.length,
                  itemBuilder: (context, index) {
                    final comment = controller.comments.value![index];
                    return CommentCard(comment: comment);
                  },
                ),
              ),
            ],
          );
        }),
      ),
    );
  }
}
