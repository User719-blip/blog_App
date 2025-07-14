// ignore_for_file: public_member_api_docs, sort_constructors_first


//incapsulates fundamental busness rules or logic of the application
// defines the core entities for an appliction or a featutre
class Blog {
  final String id;
  final String posterId;
  final String title;
  final String content;
  final String imageUrl;
  final List<String> topics;
  final DateTime updateAt;

  Blog({
    required this.id,
    required this.posterId,
    required this.title,
    required this.content,
    required this.imageUrl,
    required this.topics,
    required this.updateAt,
  });

  

}
