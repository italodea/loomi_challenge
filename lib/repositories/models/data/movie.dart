import 'package:loomi_chalenge/repositories/models/data/comment.dart';
import 'package:loomi_chalenge/repositories/models/data/movie_poster.dart';

class Movie {
  final int id;
  final String name;
  final String synopsis;
  final bool currentlyPlaying;
  final String streamLink;
  final String genre;
  final DateTime endDate;
  final MoviePoster poster;
  final Comment? lastComment;
  final int commentsCount;

  Movie({
    required this.id,
    required this.name,
    required this.synopsis,
    required this.currentlyPlaying,
    required this.streamLink,
    required this.genre,
    required this.endDate,
    required this.poster,
    this.lastComment,
    required this.commentsCount,
  });

  factory Movie.fromJson(Map<String, dynamic> json) {
    return Movie(
      id: json['id'] as int,
      name: json['name'] as String,
      synopsis: json['synopsis'] as String,
      currentlyPlaying: json['currentlyPlaying'] as bool,
      streamLink: json['streamLink'] as String,
      genre: json['genre'] as String,
      endDate: DateTime.parse(json['endDate'] as String),
      poster: MoviePoster.fromJson(json['poster']),
      lastComment: json['lastComment'] != null
          ? Comment.fromJson(json['lastComment'])
          : null,
          commentsCount: json['commentsCount'] as int,
    );
  }
}