class MoviePoster {
  final String name;
  final int width;
  final int height;
  final int size;
  final String url;

  MoviePoster({
    required this.name,
    required this.width,
    required this.height,
    required this.size,
    required this.url,
  });

  factory MoviePoster.fromJson(Map<String, dynamic> json) {
    return MoviePoster(
      name: json['name'] as String,
      width: json['width'] as int,
      height: json['height'] as int,
      size: json['size'] as int,
      url: json['url'] as String,
    );
  }
}