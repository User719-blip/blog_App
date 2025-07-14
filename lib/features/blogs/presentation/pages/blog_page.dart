import 'package:blog_app/features/blogs/presentation/pages/add_new_page.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';

class BlogPage extends StatelessWidget {
  const BlogPage({super.key});

  @override
  Widget build(BuildContext context) {
    print('Blog page built');
    return Scaffold(
      appBar: AppBar(
        title: const Text('Blog App'),
        actions: [
          IconButton(onPressed: () {
            Navigator.push(context, AddNewBlogPage.route());
          }, icon: Icon(CupertinoIcons.add_circled)),
        ],
      ),
      body: Container(),
    );
  }
}
