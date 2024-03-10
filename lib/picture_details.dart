import 'package:dailymood/entries.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart'; // Import the intl package

class PictureDetails extends StatelessWidget {
  const PictureDetails({super.key, required this.entry});

  final FinalEntry entry;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text("Details"),
      ),
      body: Column(
        children: [
          Image.file(entry.image),
          Text(
            entry.title,
            style: const TextStyle(fontSize: 30),
          ),
          Text(entry.description),
          Text(DateFormat('dd/MM/y').format(entry.date)), // Format the date

          ElevatedButton(
              onPressed: () {
                Entry.deleteEntry(entry.id);
                Navigator.pop(context);
              },
              child: const Text("Delete"))
        ],
      ),
    );
  }
}
