import 'package:flutter/material.dart';
import 'package:get/get.dart';
import 'package:loomi_chalenge/controllers/comment_card_controller.dart';
import 'package:loomi_chalenge/repositories/models/data/comment.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:loomi_chalenge/utils/time_convert.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, this.comment});

  final Comment? comment;

  @override
  Widget build(BuildContext context) {
    final controller = Get.put(
      CommentCardController(),
      tag: comment?.id?.toString() ?? UniqueKey().toString(),
    );
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            maxRadius: 20,
            child: Text(
              comment?.authorName?.split('').first.toUpperCase() ?? '',
              style: AppTheme.textThemeSecondary.displayLarge,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment?.authorName ?? '',
                  style: AppTheme.textThemeSecondary.displayLarge,
                ),
                SizedBox(height: 4),
                Text(
                  TimeConvert.timeAgo(comment?.createdAt ?? DateTime.now()),
                  style: AppTheme.textThemeSecondary.labelSmall,
                ),
                Text(
                  comment?.comment ?? '',
                  style: AppTheme.textThemeSecondary.bodyLarge,
                ),
                SizedBox(height: 4),
                if (comment!.replies.isNotEmpty)
                  GestureDetector(
                    onTap: controller.toggleExpanded,
                    child: Row(
                      children: [
                        Obx(() => Icon(
                              controller.isExpanded.value
                                  ? Icons.arrow_drop_up_rounded
                                  : Icons.arrow_drop_down_rounded,
                              color: AppTheme.activeBorderColor,
                              size: 36,
                            )),
                        Text(
                          controller.isExpanded.value
                              ? "Hide Replies"
                              : "View ${comment!.replies.length} Replies",
                          style: AppTheme.textThemeSecondary.displayMedium?.copyWith(color: AppTheme.activeBorderColor),
                        ),
                      ],
                    ),
                  ),
                Obx(() => controller.isExpanded.value
                    ? Column(
                        children: [
                          ...comment!.replies.map((reply) => Padding(
                                padding: const EdgeInsets.only(left: 24.0, top: 8.0),
                                child: CommentCard(comment: reply),
                              ))
                        ],
                      )
                    : Container()),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
