class TagData      {
  int tagId;
  int repoTagId;
  String title;

  TagData({
    required this.tagId,
    required this.repoTagId,
    required this.title,
  });

  // ساختن شیء از JSON
  factory TagData.fromJson(Map<String, dynamic> json) {
    return TagData(
      tagId: json['tagId'] as int,
      repoTagId: json['repoTagId'] as int,
      title: json['title'] as String,
    );
  }

  // تبدیل شیء به JSON
  Map<String, dynamic> toJson() {
    return {
      'tagId': tagId,
      'repoTagId': repoTagId,
      'title': title,
    };
  }
}