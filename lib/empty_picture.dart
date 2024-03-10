import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

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
            child: const Center(
              child: Column(
                mainAxisAlignment: MainAxisAlignment.center,

                // Text and Icon
                children: [
                  Icon(Icons.add_circle_outline_sharp, size: 50.0),
                  Text(
                    "Tap to take you daily photo!",
                    style: TextStyle(fontWeight: FontWeight.bold),
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
