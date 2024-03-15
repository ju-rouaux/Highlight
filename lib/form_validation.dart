import 'package:highlight/entries.dart';
import 'package:highlight/picture_frame.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormValidation extends StatefulWidget {
  const FormValidation({super.key});

  @override
  State<FormValidation> createState() => _FormValidationState();
}

class _FormValidationState extends State<FormValidation> {
  @override
  Widget build(BuildContext context) {
    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.lastStep,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Consumer<NewEntry>(
              builder: (BuildContext context, NewEntry entry, Widget? child) {
            if (entry.image != null) {
              return PictureFrame(pictureModel: FinalEntry.fromNewEntry(entry));
            }
            return const Placeholder(); // This is not supposed to be displayed under normal usage.
          }),
          const SizedBox(height: 10),
          ElevatedButton(
              onPressed: () {
                NewEntry entry = Provider.of<NewEntry>(context, listen: false);
                entry.updateDate(DateTime.now());
                entry.saveEntry();
                Navigator.pop(context);
              },
              child: Text(AppLocalizations.of(context)!.confirmQuestion))
        ],
      ),
    );
  }
}
