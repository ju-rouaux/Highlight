import 'package:dailymood/entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormComment extends StatefulWidget {
  const FormComment({super.key});

  @override
  State<FormComment> createState() => FormCommentState();
}

class FormCommentState extends State<FormComment> {
  @override
  Widget build(BuildContext context) {
    return Consumer<Entry>(
      builder: (context, entry, child) {
        if (entry.image != null) {
          return Image.file(entry.image!);
        } else {
          return Placeholder();
        }
      },
    );
  }
}