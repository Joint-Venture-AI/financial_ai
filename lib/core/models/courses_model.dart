class Course {
  final String id;
  final String title;
  final String image;
  final String description;
  final String url;
  final DateTime createdAt;
  final DateTime updatedAt;
  final int v;

  Course({
    required this.id,
    required this.title,
    required this.image,
    required this.description,
    required this.url,
    required this.createdAt,
    required this.updatedAt,
    required this.v,
  });

  factory Course.fromJson(Map<String, dynamic> json) {
    return Course(
      id: json['_id'],
      title: json['title'],
      image: json['image'],
      description: json['description'],
      url: json['url'],
      createdAt: DateTime.parse(json['createdAt']),
      updatedAt: DateTime.parse(json['updatedAt']),
      v: json['__v'],
    );
  }

  Map<String, dynamic> toJson() {
    return {
      '_id': id,
      'title': title,
      'image': image,
      'description': description,
      'url': url,
      'createdAt': createdAt.toIso8601String(),
      'updatedAt': updatedAt.toIso8601String(),
      '__v': v,
    };
  }
}
