import 'package:dailymood/mood_enum.dart';
import 'package:dailymood/entry.dart';
import 'package:flutter/material.dart';

class PictureFrame extends StatefulWidget {
  const PictureFrame({super.key, required this.pictureModel});

  final Entry pictureModel;

  @override
  State<PictureFrame> createState() => _PictureFrameState();
}

class _PictureFrameState extends State<PictureFrame> {
  // Setup
  final double borderRadius = 30;

  @override
  Widget build(BuildContext context) {
    return Stack(children: [
      // Image
      AspectRatio(
        aspectRatio: 3 / 4,

        child: Container(

          decoration: BoxDecoration(
            color: Colors.white,
            borderRadius: BorderRadius.circular(borderRadius)
          ),

          clipBehavior: Clip.antiAlias,
          
          // child: Image.asset("assets/images/cat_placeholder.jpg", fit: BoxFit.cover)
          child: Image.file(widget.pictureModel.image!, fit: BoxFit.cover)

        )
      ),

      // Transparent gradient
      AspectRatio(
        aspectRatio: 3 / 4,
        child: Container(
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(borderRadius),
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
        )
      ),

      // Text
      Positioned(
        bottom: 16.0,
        left: 16.0,
        child: Text(
          widget.pictureModel.title,
          style: TextStyle(
            color: Colors.white, // Change text color as needed
            fontSize: 20.0,
            fontWeight: FontWeight.bold,
          ),
        ),
      ),

      Positioned(
        top: 16.0,
        right: 16.0,
        child: Text(
          widget.pictureModel.mood.toEmoji,
          style: TextStyle(fontSize: 40),
        ),
      )
    ]);
  }
}
