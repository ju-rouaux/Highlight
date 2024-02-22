import 'package:flutter/material.dart';

class PicFrame extends StatefulWidget {
  const PicFrame({super.key});

  @override
  State<PicFrame> createState() => _PicFrameState();
}

class _PicFrameState extends State<PicFrame> {

  // Setup
  final double borderRadius = 30;

  @override
  Widget build(BuildContext context) {

    return Stack(
      children: [

        // Image
        AspectRatio(
          aspectRatio: 3/4,

          child: Container(
            decoration: BoxDecoration(
              color: Colors.white,
              borderRadius: BorderRadius.circular(borderRadius)
            ),
            clipBehavior: Clip.antiAlias,
            // child: Image.asset("")
            child: Image.asset("assets/images/cat_placeholder.jpg", fit:BoxFit.cover)
          )
        ),

        // Transparent gradient
        AspectRatio(aspectRatio: 3/4,
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
        const Positioned(
              bottom: 16.0,
              left: 16.0,
              child: Text(
                'Your Text Here',
                style: TextStyle(
                  color: Colors.white, // Change text color as needed
                  fontSize: 20.0,
                  fontWeight: FontWeight.bold,
                ),
              ),
        ),

        const Positioned(
              top: 16.0,
              right: 16.0,
              child: Text(
                '🥴',
                style: TextStyle(
                  fontSize: 40
                ),
              ),
        )

      ]
    );
  }
}