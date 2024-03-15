import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';

class EmptyPicture extends StatelessWidget {
  const EmptyPicture({super.key, required this.aspectRatio});

  final double aspectRatio;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: aspectRatio,
      // Border
      child: DottedBorder(
        borderType: BorderType.RRect,
        radius: const Radius.circular(30),
        padding: const EdgeInsets.all(4),
        color: Theme.of(context).colorScheme.onBackground,
        borderPadding: const EdgeInsets.all(1),

        // Frame
        child: ClipRRect(
          borderRadius: BorderRadius.circular(30),
          child: Container(
            decoration: const BoxDecoration(
                color: Colors.transparent), // Required for tap detection
            child: Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                // Text and Icon
                children: [
                  const Icon(Icons.add_circle_outline_sharp, size: 50.0),
                  Text(
                    AppLocalizations.of(context)!.takeDailyPhoto,
                    style: const TextStyle(fontWeight: FontWeight.bold),
                    textAlign: TextAlign.center,
                  )
                ],
              ),
            ),
          ),
        ),
      ),
    );
  }
}
