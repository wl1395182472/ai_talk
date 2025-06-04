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
      name: json['name'] as String,
      description: json['description'] as String?,
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
      novelId: json['novel_id'] as int?,
      title: json['title'] as String,
      description: json['description'] as String,
      coverImage: json['cover_image'] as String?,
      tags: (json['tags'] as List<dynamic>?)?.cast<String>(),
      authorId: json['author_id'] as int?,
      authorName: json['author_name'] as String?,
      createdAt: json['created_at'] != null
          ? DateTime.parse(json['created_at'] as String)
          : null,
      updatedAt: json['updated_at'] != null
          ? DateTime.parse(json['updated_at'] as String)
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
