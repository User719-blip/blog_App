import 'package:blog_app/features/blogs/domain/entities.dart';

class BlogModel extends Blog {
  BlogModel({
    required super.id,
    required super.posterId,
    required super.title,
    required super.content,
    required super.imageUrl,
    required super.topics,
    required super.updateAt,
  });

  Map<String, dynamic> toJson() {
    return <String, dynamic>{
      'id': id,
      'poster_Id': posterId,
      'title': title,
      'content': content,
      'imageUrl': imageUrl,
      'topics': topics,
      'updateAt': updateAt.toIso8601String(),
    };
  }

  factory BlogModel.fromMap(Map<String, dynamic> map) {
    return BlogModel(
      id: map['id'] as String,
      posterId: map['posterId'] as String,
      title: map['title'] as String,
      content: map['content'] as String,
      imageUrl: map['imageUrl'] as String,
      topics: List<String>.from(map['topics'] as List<String>),
      updateAt: map['updated_at'] == null
          ? DateTime.now()
          : DateTime.parse(map['updated_at']),
    );
  }
}
