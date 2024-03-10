import 'package:dailymood/mood_enum.dart';
import 'package:dailymood/entries.dart';
import 'package:flutter/material.dart';

class PictureFrame extends StatelessWidget {
  const PictureFrame({super.key, required this.pictureModel});

  final FinalEntry pictureModel;

  @override
  Widget build(BuildContext context) {
    return AspectRatio(
      aspectRatio: 3 / 4,
      child: ClipRRect(
        borderRadius: BorderRadius.circular(30),
        child: Stack(children: [
          // Image
          Container(
            constraints: const BoxConstraints.expand(),
            decoration: const BoxDecoration(
              color: Colors.transparent,
            ),
            clipBehavior: Clip.antiAlias,
            child: Image.file(pictureModel.image, fit: BoxFit.cover),
          ),

          // Transparent gradient
          Container(
            decoration: BoxDecoration(
              gradient: LinearGradient(
                begin: const Alignment(-2, 2),
                end: const Alignment(-0.5, -1),
                stops: const [0, 1],
                colors: [
                  Colors.black.withOpacity(0.6),
                  Colors.transparent,
                ],
              ),
            ),
          ),

          // Text
          Positioned(
            bottom: 16.0,
            left: 16.0,
            child: Text(
              pictureModel.title,
              style: const TextStyle(
                color: Colors.white, // Change text color as needed
                fontSize: 20.0,
                fontWeight: FontWeight.bold,
              ),
            ),
          ),

          // Emoji mood
          Positioned(
            top: 16.0,
            right: 16.0,
            child: Text(
              pictureModel.mood.toEmoji,
              style: const TextStyle(fontSize: 40),
            ),
          )
        ]),
      ),
    );
  }
}
