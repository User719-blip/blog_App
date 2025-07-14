import 'dart:io';

import 'package:blog_app/core/theme/app_pallet.dart';
import 'package:blog_app/core/utils/pick_image.dart';
import 'package:blog_app/features/blogs/presentation/widgets/blog_editor.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class AddNewBlogPage extends StatefulWidget {
  static route() => MaterialPageRoute(builder: (context) => AddNewBlogPage());
  const AddNewBlogPage({super.key});

  @override
  _AddNewPageState createState() => _AddNewPageState();
}

class _AddNewPageState extends State<AddNewBlogPage> {
  final titleController = TextEditingController();
  final contentController = TextEditingController();
  List<String> selectedTopics = [];
  File? image;

  void selecteImage() async {
    final pickedImage = await pickImage();
    if (pickedImage != null) {
      setState(() {
        image = pickedImage;
      });
    }
  }

  @override
  void dispose() {
    titleController.dispose();
    contentController.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        actions: [IconButton(onPressed: () {}, icon: Icon(Icons.done_rounded))],
      ),
      body: SingleChildScrollView(
        child: Padding(
          padding: const EdgeInsets.all(16.0),
          child: Column(
            children: [
              image != null
                  ? SizedBox(
                      height: 150,
                      width: double.infinity,
                      child: Image.file(image!),
                    )
                  : GestureDetector(
                      onTap: () {
                        selecteImage();
                      },
                      child: DottedBorder(
                        options: RectDottedBorderOptions(
                          color: const Color.fromARGB(207, 73, 56, 56),
                          dashPattern: const [10, 4],
                          strokeCap: StrokeCap.round,
                        ),
                        child: Container(
                          height: 150,
                          width: double.infinity,
                          child: Center(
                            child: Column(
                              children: [
                                SizedBox(height: 20),
                                Icon(Icons.folder_open, size: 40),
                                SizedBox(height: 15),
                                Text(
                                  'Select your Image',
                                  style: TextStyle(fontSize: 15),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ),
              SizedBox(height: 20),
              Padding(
                padding: const EdgeInsets.all(8.0),
                child: SingleChildScrollView(
                  scrollDirection: Axis.horizontal,
                  child: Row(
                    children:
                        [
                              //loop over the each ellemnt using map then convert to a list e brlongs to chips
                              'Technology',
                              'Business',
                              'programming',
                              'Entertainment',
                            ]
                            .map(
                              (e) => Padding(
                                padding: const EdgeInsets.symmetric(
                                  horizontal: 8.0,
                                ),
                                child: GestureDetector(
                                  onTap: () {
                                    if (selectedTopics.contains(e)) {
                                      selectedTopics.remove(e);
                                    } else {
                                      selectedTopics.add(e);
                                    }
                                    setState(() {
                                      //  print(selectedTopics);
                                    });
                                  },
                                  child: Chip(
                                    label: Text(e),
                                    color: selectedTopics.contains(e)
                                        ? const WidgetStatePropertyAll(
                                            AppPallet.gradient1,
                                          )
                                        : null,
                                    side: BorderSide(
                                      color: AppPallet.borderColor,
                                    ),
                                  ),
                                ),
                              ),
                            )
                            .toList(),
                  ),
                ),
              ),
              BlogEditor(
                textEditingController: titleController,
                hintText: 'Blog Title',
              ),
              SizedBox(height: 10),
              BlogEditor(
                textEditingController: contentController,
                hintText: 'Blog Body',
              ),
            ],
          ),
        ),
      ),
    );
  }
}
