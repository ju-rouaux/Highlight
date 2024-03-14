import 'package:dailymood/entries.dart';
import 'package:dailymood/form_root.dart';
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
      ),
      body: Column(
        children: [
          Image.file(widget.entry.image),
          Text(
            widget.entry.title,
            style: const TextStyle(fontSize: 30),
          ),
          Text(widget.entry.description),
          Text(DateFormat('dd/MM/y').format(widget.entry.date)), // Format the date

          ElevatedButton(
              onPressed: () {
                Entry.deleteEntry(widget.entry.id);
                Navigator.pop(context);
              },
              child: const Text("Delete")),

          if (DateTime.now().toIso8601String().split('T')[0].replaceAll("-", "") == widget.entry.id)
            ElevatedButton(
              onPressed: () => Navigator.push(
                context,
                MaterialPageRoute(builder: (context) {
                  return FormRoot(entry: NewEntry.fromFinalEntry(widget.entry));
                }),
              ).then((_) {
                Navigator.pop(context);
              }),
              child: const Text("Edit")
            ),
        ],
      ),
    );
  }
}
