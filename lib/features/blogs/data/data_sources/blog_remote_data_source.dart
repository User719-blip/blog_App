import 'package:blog_app/features/blogs/data/models.dart';
import 'package:supabase_flutter/supabase_flutter.dart';

abstract interface class BlogRemoteDataSource {
  Future<BlogModel> uplodeBlog(BlogModel blog);
}

class BlogRemoteDataSourceImpl implements BlogRemoteDataSource {
  final SupabaseClient supabaseClient;

  BlogRemoteDataSourceImpl({required this.supabaseClient});

  @override
  Future<BlogModel> uplodeBlog(BlogModel blog) async {
    try {
      final blogData = await supabaseClient
          .from('blogs')
          .insert(blog.toJson())
          .select();
      return BlogModel.fromMap(blogData.first);
    // ignore: empty_catches
    } catch (e) {
      throw e.toString();
    }
  }
}
