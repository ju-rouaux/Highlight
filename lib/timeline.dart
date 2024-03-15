import 'package:highlight/empty_picture.dart';
import 'package:highlight/entries.dart';
import 'package:highlight/form_root.dart';
import 'package:highlight/picture_details.dart';
import 'package:highlight/picture_frame.dart';
import 'package:flutter/material.dart';

class Timeline extends StatefulWidget {
  const Timeline({super.key});

  @override
  State<Timeline> createState() => _TimelineState();
}

class _TimelineState extends State<Timeline> {
  List<FinalEntry> entries = [];
  bool hasEntryForToday = false;

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  void loadEntries() async {
    entries = await Entry.entries();
    hasEntryForToday = await Entry.todayEntryDoesExist();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    int offset = hasEntryForToday ? 0 : 1;
    return ListView.builder(
      itemCount: entries.length + offset, // +1 pour l'élément du haut
      itemBuilder: (context, index) {
        if (index == 0 && !hasEntryForToday) {
          return Padding(
            padding: const EdgeInsets.only(top: 20),
            child: buildNewEntryButton(() => Navigator.push(
                  context,
                  MaterialPageRoute(builder: (context) {
                    return const FormRoot();
                  }),
                ).then((_) => loadEntries())),
          );
        }
        return Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: GestureDetector(
                onTap: () {
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) =>
                          PictureDetails(entry: entries[index - offset]),
                    ),
                  ).then((_) => loadEntries());
                },
                child: PictureFrame(pictureModel: entries[index - offset])));
      },
    );
  }

  Widget buildNewEntryButton(void Function() onTap) {
    return GestureDetector(
        onTap: onTap, child: const EmptyPicture(aspectRatio: 3 / 2));
  }
}
