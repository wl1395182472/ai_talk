/// 小说标签模型
class NovelTag {
  final String name;
  final String? description;

  const NovelTag({
    required this.name,
    this.description,
  });

  factory NovelTag.fromJson(Map<String, dynamic> json) {
    return NovelTag(
      name: json['name'] is String ? json['name'] : '',
      description: json['description'] is String ? json['description'] : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'name': name,
      'description': description,
    };
  }
}

/// 小说模型
class Novel {
  final int? novelId;
  final String title;
  final String description;
  final String? coverImage;
  final List<String>? tags;
  final int? authorId;
  final String? authorName;
  final DateTime? createdAt;
  final DateTime? updatedAt;

  const Novel({
    this.novelId,
    required this.title,
    required this.description,
    this.coverImage,
    this.tags,
    this.authorId,
    this.authorName,
    this.createdAt,
    this.updatedAt,
  });

  factory Novel.fromJson(Map<String, dynamic> json) {
    return Novel(
      novelId: json['novel_id'] is int ? json['novel_id'] : null,
      title: json['title'] is String ? json['title'] : '',
      description: json['description'] is String ? json['description'] : '',
      coverImage: json['cover_image'] is String ? json['cover_image'] : null,
      tags: (json['tags'] is List<dynamic>)
          ? (json['tags'] as List<dynamic>)
              .map((e) => e is String ? e : '')
              .toList()
              .cast<String>()
          : null,
      authorId: json['author_id'] is int ? json['author_id'] : null,
      authorName: json['author_name'] is String ? json['author_name'] : null,
      createdAt: json['created_at'] is String
          ? DateTime.tryParse(json['created_at'])
          : null,
      updatedAt: json['updated_at'] is String
          ? DateTime.tryParse(json['updated_at'])
          : null,
    );
  }

  Map<String, dynamic> toJson() {
    return {
      'novel_id': novelId,
      'title': title,
      'description': description,
      'cover_image': coverImage,
      'tags': tags,
      'author_id': authorId,
      'author_name': authorName,
      'created_at': createdAt?.toIso8601String(),
      'updated_at': updatedAt?.toIso8601String(),
    };
  }
}
