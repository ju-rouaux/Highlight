import 'package:dailymood/entries.dart';
import 'package:dailymood/picture_frame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormComment extends StatelessWidget {
  const FormComment({super.key});

  @override
  Widget build(BuildContext context) {
    TextEditingController titleController = TextEditingController(text: Provider.of<NewEntry>(context, listen: false).title);
    TextEditingController descriptionController = TextEditingController(text: Provider.of<NewEntry>(context, listen: false).description);

    return SingleChildScrollView(
      child: Column(
        children: [
          AspectRatio(
            aspectRatio: 3 / 4,
            child: Stack(
              children: [
                Consumer<NewEntry>(builder:
                    (BuildContext context, NewEntry entry, Widget? child) {
                  if (entry.image != null) {
                    return PictureFrame(
                        pictureModel: FinalEntry.onlyImage(entry.image!));
                  }
                  return const Placeholder(); // This is not supposed to be displayed under normal usage.
                }),

                // Text field
                Positioned(
                  bottom: 0.5,
                  left: 16.0,
                  child: Container(
                    color: Colors.transparent,
                    child: SizedBox(
                      width: 300,
                      child: TextField(
                        controller: titleController,
                        onChanged: (value) {
                          Provider.of<NewEntry>(context, listen: false)
                              .updateTitle(value);
                        },
                        maxLength: 25,

                        // Entry style
                        style: TextStyle(
                          color: Colors.white, // Change text color as needed
                          fontSize: 20.0,
                          fontWeight: FontWeight.bold,
                        ),

                        // Field style
                        decoration: InputDecoration(
                            hintText: "Tap to write a short title!",
                            hintStyle: TextStyle(
                              color:
                                  Colors.white, // Change text color as needed
                              fontSize: 20.0,
                              fontWeight: FontWeight.bold,
                            ),
                            counterStyle: TextStyle(color: Colors.white)),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          TextField(
            controller: descriptionController,
            onChanged: (value) {
              Provider.of<NewEntry>(context, listen: false)
                  .updateDescription(value);
            },
            decoration: const InputDecoration(
              labelText: 'Develop your thoughts here.',
            ),
          ),
        ],
      ),
    );
  }
}
