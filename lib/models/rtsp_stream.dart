class RtspStream {
  final String url;
  final String? username;
  final String? password;

  RtspStream({required this.url, this.username, this.password});

  Map<String, dynamic> toJson() {
    return {
      'url': url,
      'username': username,
      'password': password,
    };
  }

  factory RtspStream.fromJson(Map<String, dynamic> json) {
    return RtspStream(
      url: json['url'],
      username: json['username'],
      password: json['password'],
    );
  }
}