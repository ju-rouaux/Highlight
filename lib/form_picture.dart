import 'dart:io';

import 'package:highlight/empty_picture.dart';
import 'package:highlight/entries.dart';
import 'package:highlight/picture_frame.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';
import 'package:path_provider/path_provider.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

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
          const SizedBox(height: 10),
          ElevatedButton(
            onPressed: () => takePicture(context),
            child: Text(AppLocalizations.of(context)!.newPicture),
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
        padding: const EdgeInsets.all(10),
        child: Column(
          children: [
            Text(
              AppLocalizations.of(context)!.firstStep,
              textAlign: TextAlign.center,
              style: TextStyle(
                  color: Theme.of(context).colorScheme.onBackground,
                  fontSize: 20,
                  fontWeight: FontWeight.w600),
            ),
            const SizedBox(height: 10),
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
