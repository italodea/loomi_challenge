
class Comment {
  final String? id;
  final String? authorId;
  final String? authorName;
  final String? authorEmail;
  final String? authorPhotoUrl;
  final String? comment;
  final DateTime? createdAt;
  final int? replyId;
  final List<Comment> replies;

  Comment({
    this.id,
    this.authorId,
    this.authorName,
    this.authorEmail,
    this.authorPhotoUrl,
    this.comment,
    this.createdAt,
    this.replyId,
    List<Comment>? replies,
  }) : replies = replies ?? const [];

  factory Comment.fromJson(Map<String, dynamic> json) {
    return Comment(
      id: json['id'],
      authorId: json['author_id'],
      authorName: json['author_name'],
      authorEmail: json['author_email'],
      authorPhotoUrl: json['author_photo_url'],
      comment: json['comment'] ?? "",
      createdAt: json['created_at'] != null ? DateTime.parse(json['created_at']) : null,
      replyId: json['reply_id'],
      replies: (json['replies'] as List<dynamic>? ?? [])
          .map((e) => Comment.fromJson(e as Map<String, dynamic>))
          .toList(),
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'id': id,
      'author_id': authorId,
      'author_name': authorName,
      'author_email': authorEmail,
      'author_photo_url': authorPhotoUrl,
      'comment': comment,
      'created_at': createdAt?.toIso8601String(),
      'reply_id': replyId,
      'replies': replies.map((e) => e.toJson()).toList(),
    };
  }
}