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
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            Provider.of<Entry>(context, listen: false).updateTitle(value);
          },
          decoration: InputDecoration(
            labelText: 'Write a short title!',
          ),
        ),
        TextField(
          onChanged: (value) {
            Provider.of<Entry>(context, listen: false).updateDescription(value);
          },
          decoration: InputDecoration(
            labelText: 'Develop your thoughts here.',
          ),
        ),
      ],
    );
  }
}