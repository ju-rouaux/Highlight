import 'package:dailymood/entry.dart';
import 'package:dailymood/form_root.dart';
import 'package:dailymood/picture_frame.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<Entry> entries = [];

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  void loadEntries() async {
    entries = await Entry.entries();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return ListView.builder(
      // TODO CHECK SI UNE ENTREE DU JOUR EST FAITE
      itemCount: entries.length + 1, // +1 pour l'élément du haut
      itemBuilder: (context, index) {
        if (index == 0) {
          return ElevatedButton(
            onPressed: () {
              Navigator.push(
                context,
                MaterialPageRoute(builder: (context) => FormRoot(entry: entries[0])),
              );
            }, 
            child: Text("New entry")
          ); // Customize this placeholder as needed
        }
        return Padding(
            padding: EdgeInsets.symmetric(vertical: 20), 
            child: PictureFrame(pictureModel: entries[index - 1]));
      },
    );
  }
}
 