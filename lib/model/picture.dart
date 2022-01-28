class Picture {
  String url;

  Picture(this.url);
  Picture.fromJson(Map<String, dynamic> json) : url = json['url'];

  Map<String, dynamic> toJson() => {'url': url};
}
