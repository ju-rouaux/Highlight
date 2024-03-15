import 'package:dailymood/entries.dart';
import 'package:dailymood/form_root.dart';
import 'package:dailymood/mood_enum.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class PictureDetails extends StatefulWidget {
  const PictureDetails({super.key, required this.entry});

  final FinalEntry entry;

  @override
  State<PictureDetails> createState() => _PictureDetailsState();
}

class _PictureDetailsState extends State<PictureDetails> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
        actions: [
          // Delete
          if (DateTime.now()
                  .toIso8601String()
                  .split('T')[0]
                  .replaceAll("-", "") ==
              widget.entry.id)
            IconButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return FormRoot(entry: NewEntry.fromFinalEntry(widget.entry));
                }),
              ).then((_) {
                Navigator.pop(context);
              }),
              icon: const Icon(Icons.edit),
            ),
          // Edit
          IconButton(
            onPressed: () {
              showDialog(
                context: context,
                builder: (BuildContext context) {
                  return AlertDialog(
                    title: const Text('Confirm deletion'),
                    content: const Text('Are you sure you want to delete?'),
                    actions: [
                      TextButton(
                        onPressed: () {
                          Navigator.of(context).pop();
                        },
                        child: const Text('Cancel'),
                      ),
                      TextButton(
                        onPressed: () {
                          Entry.deleteEntry(widget.entry.id);
                          Navigator.popUntil(context, (route) => route.isFirst);
                        },
                        child: const Text('Delete'),
                      ),
                    ],
                  );
                },
              );
            },
            icon: const Icon(Icons.delete),
          ),
        ],
      ),
      body: SingleChildScrollView(
        child: Column(
          children: [
            Image.file(widget.entry.image),
            Padding(
              padding: const EdgeInsets.all(15),
              child: Column(
                children: [
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.entry.title,
                      style: const TextStyle(
                          fontSize: 20, fontWeight: FontWeight.bold),
                    ),
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      "Mood: ${widget.entry.mood.toText} - ${DateFormat('dd/MM/y').format(widget.entry.date)}",
                      style: const TextStyle(fontSize: 14),
                    ),
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  Align(
                    alignment: Alignment.centerLeft,
                    child: Text(
                      widget.entry.description,
                      textAlign: TextAlign.justify,
                    ),
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }
}
