class VideoModel {
  final String title;
  final String description;
  final String url;

  VideoModel({
    required this.title,
    required this.description,
    required this.url,
  });

  static VideoModel fromJson(Map<String, dynamic> json) {
    return VideoModel(
      title: json['title'],
      description: json['description'],
      url: (json['sources'] as List)[0],
    );
  }
}
