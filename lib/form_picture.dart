import 'dart:io';

import 'package:dailymood/entry.dart';
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

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        ElevatedButton(
          onPressed: () async {
            XFile? image = await ImagePicker().pickImage(source: ImageSource.camera);
            
            if (image == null) return;
            
            Directory appDocumentsDirectory = await getApplicationDocumentsDirectory();

            File newImage = File('${appDocumentsDirectory.path}/${image.name}');
            await image.saveTo(newImage.path);
            
            if (context.mounted) {
              Provider.of<Entry>(context, listen: false).updateImage(newImage);
            }

            widget.onImageAdded.call();
          }, 
          child: Text("Take picture")
        ),
      ],
    );
  }

}