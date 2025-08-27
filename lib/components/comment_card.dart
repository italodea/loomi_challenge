import 'package:flutter/material.dart';
import 'package:loomi_chalenge/repositories/models/data/comment.dart';
import 'package:loomi_chalenge/themes/app_theme.dart';
import 'package:loomi_chalenge/utils/time_convert.dart';

class CommentCard extends StatelessWidget {
  const CommentCard({super.key, this.comment});

  final Comment? comment;

  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 8.0),
      child: Row(
        crossAxisAlignment: CrossAxisAlignment.start,
        mainAxisAlignment: MainAxisAlignment.start,
        children: [
          CircleAvatar(
            maxRadius: 20,
            child: Text(
              comment?.user?.username.split('').first.toUpperCase() ?? '',
              style: AppTheme.textThemeSecondary.displayLarge,
            ),
          ),
          SizedBox(width: 20),
          Expanded(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                Text(
                  comment?.user?.username ?? '',
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
                comment!.replies.isNotEmpty
                    ? Row(
                        children: [
                          Icon(
                            Icons.arrow_drop_down_rounded,
                            color: AppTheme.activeBorderColor,
                            size: 36,
                          ),
                          Text(
                            "View ${comment!.replies.length} Replies",
                            style: AppTheme.textThemeSecondary.displayMedium
                                ?.copyWith(color: AppTheme.activeBorderColor),
                          ),
                        ],
                      )
                    : Container(),
              ],
            ),
          ),
        ],
      ),
    );
  }
}
