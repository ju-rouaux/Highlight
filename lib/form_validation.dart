import 'package:dailymood/entry.dart';
import 'package:dailymood/picture_frame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormValidation extends StatefulWidget {
  const FormValidation({super.key});

  @override
  State<FormValidation> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        PictureFrame(pictureModel: Provider.of<Entry>(context, listen: false)),
        ElevatedButton(
          onPressed: () {
            //TODO SAVE ENTRY
            Navigator.pop(context);
          },
          child: Text("Confirmer ?")
        )
      ],
    );
  }
}