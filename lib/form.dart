import 'dart:async';
import 'dart:io';

import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:path_provider/path_provider.dart';

import 'package:image_picker/image_picker.dart';


/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH
/// WORK IN PROGRESS DO NOT TOUCH

class DailyInputForm extends StatefulWidget {
  const DailyInputForm({super.key});

  @override
  State<DailyInputForm> createState() => _DailyInputFormState();
}

class _DailyInputFormState extends State<DailyInputForm> {
  final PageController _pageController = PageController();
  int _currentPage = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: const Text('Page Indicator Demo'),
      ),
      body: Column(
        children: [
          Container(
            padding: EdgeInsets.all(16.0),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: List.generate(
                3, // Change this to the number of pages
                (index) => buildPageIndicator(index),
              ),
            ),
          ),
          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },
              children: [
                // Replace these with your pages
                Container(
                  color: Colors.blue,
                  child: Center(
                    child: ElevatedButton(
                        child: Text("yo"), onPressed: () => takePicture()),
                  ),
                ),
                Container(
                  color: Colors.green,
                  child: Center(
                    child: Text('Page 2'),
                  ),
                ),
                Container(
                  color: Colors.orange,
                  child: Center(
                    child: Text('Page 3'),
                  ),
                ),
              ],
            ),
          ),
          SizedBox(height: 16.0),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              IconButton(
                icon: Icon(Icons.arrow_back),
                onPressed: () {
                  if (_currentPage > 0) {
                    _pageController.previousPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
              IconButton(
                icon: Icon(Icons.arrow_forward),
                onPressed: () {
                  if (_currentPage < 2) {
                    _pageController.nextPage(
                      duration: Duration(milliseconds: 500),
                      curve: Curves.ease,
                    );
                  }
                },
              ),
            ],
          ),
        ],
      ),
    );
  }

  Widget buildPageIndicator(int index) {
    return Container(
      width: 8.0,
      height: 8.0,
      margin: EdgeInsets.symmetric(horizontal: 4.0),
      decoration: BoxDecoration(
        shape: BoxShape.circle,
        color: _currentPage == index ? Colors.blue : Colors.grey,
      ),
    );
  }
}

///
/// CAMERA
///

Future<void> takePicture() async {
  final picker = ImagePicker();
  final XFile? pickedFile = await picker.pickImage(source: ImageSource.camera);

  if (pickedFile != null) {
    // Do something with the image file (e.g., save it, display it, etc.)
    const Dialog.fullscreen(child: 
    DailyInputForm());
  } else {
    // User canceled the image picking
    print("User canceled");
  }
}
