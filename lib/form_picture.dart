import 'dart:io';

import 'package:dailymood/empty_picture.dart';
import 'package:dailymood/entries.dart';
import 'package:dailymood/picture_frame.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';

class FormPicture extends StatefulWidget {
  const FormPicture({super.key, required this.onImageAdded});

  final VoidCallback onImageAdded;

  @override
  State<FormPicture> createState() => _FormPictureState();
}

class _FormPictureState extends State<FormPicture> {
  File? image;

  @override
  Widget build(BuildContext context) {
    setState(() {
      image = Provider.of<NewEntry>(context, listen: false).image;
    });

    Widget buildWithPicture() {
      return Column(
        children: [
          PictureFrame(pictureModel: FinalEntry.onlyImage(image!)),
          SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => takePicture(context),
            child: const Text("Take a new picture"),
          ),
        ],
      );
    }

    Widget buildNoPicture() {
      return Column(
        children: [
          GestureDetector(
            onTap: () => takePicture(context),
            child: const EmptyPicture(aspectRatio: 2 / 3),
          ),
        ],
      );
    }

    return Padding(
        padding: EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              "First step — Take a picture",
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            SizedBox(height: 10),
            image == null ? buildNoPicture() : buildWithPicture(),
          ],
        ));
  }

  void takePicture(BuildContext context) async {
    XFile? image = await ImagePicker()
        .pickImage(source: ImageSource.camera, imageQuality: 50);

    if (image == null) return;

    Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

    File newImage = File('${appDocumentsDirectory.path}/${image.name}');
    await image.saveTo(newImage.path);

    if (context.mounted) {
      Provider.of<NewEntry>(context, listen: false).updateImage(newImage);
    }

    widget.onImageAdded.call();
  }
}
