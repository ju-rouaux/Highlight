import 'package:dailymood/form_comment.dart';
import 'package:dailymood/form_mood.dart';
import 'package:dailymood/form_picture.dart';
import 'package:dailymood/form_validation.dart';
import 'package:flutter/cupertino.dart';
import 'package:flutter/material.dart';
import 'package:flutter/widgets.dart';

class FormV2 extends StatefulWidget {
  const FormV2({super.key});

  @override
  State<FormV2> createState() => _FormV2State();
}

class _FormV2State extends State<FormV2> {

  final PageController _pageController = PageController();

  int _currentPage = 1;
  static const int maxPages = 4;
  

  @override
  Widget build(BuildContext context) {
    return Scaffold(

      appBar: AppBar(
        title: Text("New input"),
      ),

      body: Column(
        children: [

          Expanded(
            child: PageView(
              controller: _pageController,
              onPageChanged: (int page) {
                setState(() {
                  _currentPage = page;
                });
              },

              children: const [
                FormPicture(),
                FormComment(),
                FormMood(),
                FormValidation()
              ],
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              Opacity(
                opacity: _currentPage != 0 ? 1 : 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),
                  onPressed: () {
                    setState(() {
                      _pageController.previousPage(duration: Duration(milliseconds: 10), curve: Curves.ease);
                    });
                  },
                ),
              ),

              Container(
                padding: EdgeInsets.all(16.0),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: List.generate(
                    maxPages,
                    (index) => buildPageIndicator(index),
                  ),
                ),
              ),

              Opacity(
                opacity: _currentPage != maxPages-1 ? 1 : 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),
                  onPressed: () {
                    setState(() {
                      _pageController.nextPage(duration: Duration(milliseconds: 10), curve: Curves.ease);
                    });
                  },
                ),
              ),
            ],
          )
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
