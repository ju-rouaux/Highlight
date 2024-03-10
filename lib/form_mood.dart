import 'package:dailymood/entries.dart';
import 'package:dailymood/mood_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormMood extends StatefulWidget {
  const FormMood({super.key});

  @override
  State<FormMood> createState() => _FormMoodState();
}

class _FormMoodState extends State<FormMood> {
  @override
  Widget build(BuildContext context) {
    return GridView.count(
      crossAxisCount: 3,
      children: Mood.values.map((mood) => buildMoodButton(mood)).toList(),
    );
  }

  Widget buildMoodButton(Mood mood) {
    return GestureDetector(
      onTap: () =>
          Provider.of<NewEntry>(context, listen: false).updateMood(mood),
      child: Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              width: 64.0,
              height: 64.0,
              margin: const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Colors.grey,
              ),
            ),
            Text(mood.toEmoji, style: const TextStyle(fontSize: 40))
          ]),
          Text(mood.toText)
        ],
      ),
    );
  }
}
