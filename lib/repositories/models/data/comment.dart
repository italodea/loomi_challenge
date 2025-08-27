import 'package:loomi_chalenge/repositories/models/data/user.dart';

class Comment {
  final int? id;
  final User? user;
  final String? comment;
  final DateTime? createdAt;
  final int? replyId;
  final List<Comment> replies;

  Comment({
    this.id,
    this.user,
    this.comment,
    this.createdAt,
    this.replyId,
    this.replies = const [],
  });

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      user: User.fromJson(json['user']),
      comment: json['comment'] ?? "",
      createdAt: DateTime.parse(json['created_at']),
      replyId: json['reply_id'],
      replies: (json['replies'] as List<dynamic>? ?? [])
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }
}