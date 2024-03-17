import 'package:highlight/entries.dart';
import 'package:highlight/mood_enum.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class FormMood extends StatefulWidget {
  const FormMood({super.key});

  @override
  State<FormMood> createState() => _FormMoodState();
}

class _FormMoodState extends State<FormMood> {
  Mood _selectedMood = Mood.none;

  @override
  Widget build(BuildContext context) {
    setState(() {
      _selectedMood = Provider.of<NewEntry>(context, listen: false).mood;
    });

    return Padding(
      padding: const EdgeInsets.all(10),
      child: Column(
        children: [
          Text(
            AppLocalizations.of(context)!.thirdStep,
            textAlign: TextAlign.center,
            style: TextStyle(
                color: Theme.of(context).colorScheme.onBackground,
                fontSize: 20,
                fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 10),
          Expanded(
            child: GridView.count(
              crossAxisCount: 3,
              children: Mood.values
                  .where((mood) => mood != Mood.none)
                  .map((mood) => buildMoodButton(mood))
                  .toList(),
            ),
          ),
        ],
      ),
    );
  }

  Widget buildMoodButton(Mood mood) {
    final isSelected = mood == _selectedMood;

    return GestureDetector(
      onTap: () {
        setState(() {
          _selectedMood = mood;
        });
        Provider.of<NewEntry>(context, listen: false).updateMood(mood);
      },
      child: Column(
        children: [
          Stack(alignment: Alignment.center, children: [
            Container(
              width: 64.0,
              height: 64.0,
              margin:
                  const EdgeInsets.symmetric(horizontal: 4.0, vertical: 4.0),
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                border: Border.all(
                  color: isSelected
                      ? Theme.of(context).colorScheme.primary
                      : Colors.transparent,
                  width: 4.0,
                ),
              ),
            ),
            Text(mood.toEmoji, style: const TextStyle(fontSize: 40))
          ]),
          Text(mood.toLocalizedString(context))
        ],
      ),
    );
  }
}
