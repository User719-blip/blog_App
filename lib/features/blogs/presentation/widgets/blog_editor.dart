import 'package:flutter/material.dart';

class BlogEditor extends StatelessWidget {
  
  final TextEditingController textEditingController;
  final String hintText;
  
  const BlogEditor({ super.key, required this.textEditingController, required this.hintText });

  @override
  Widget build(BuildContext context){
    return TextFormField(
      controller: textEditingController ,
      decoration: InputDecoration(
        hintText: hintText
      ),
      maxLength: null,
    );
  }
}