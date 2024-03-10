import 'package:dailymood/entries.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormComment extends StatelessWidget {
  const FormComment({super.key});

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        TextField(
          onChanged: (value) {
            Provider.of<NewEntry>(context, listen: false).updateTitle(value);
          },
          decoration: const InputDecoration(
            labelText: 'Write a short title!',
          ),
        ),
        TextField(
          onChanged: (value) {
            Provider.of<NewEntry>(context, listen: false)
                .updateDescription(value);
          },
          decoration: const InputDecoration(
            labelText: 'Develop your thoughts here.',
          ),
        ),
      ],
    );
  }
}
