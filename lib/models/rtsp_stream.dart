class RtspStream {
  final String url;
  final String? title;

  RtspStream({required this.url, this.title});

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'title': title,
    };
  }

  factory RtspStream.fromJson(Map<String, dynamic> json) {
    return RtspStream(
      url: json['url'],
      title: json['title'],
    );
  }
}
