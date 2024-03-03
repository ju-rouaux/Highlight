import 'package:dailymood/form_comment.dart';
import 'package:dailymood/form_mood.dart';
import 'package:dailymood/form_picture.dart';
import 'package:dailymood/form_validation.dart';
import 'package:dailymood/entry.dart';
import 'package:flutter/material.dart';
import 'package:provider/provider.dart';

class FormRoot extends StatefulWidget {
  const FormRoot({super.key});

  @override
  State<FormRoot> createState() => _FormRootState();
}

class _FormRootState extends State<FormRoot> {

  final PageController _pageController = PageController();

  int _currentPage = 0;
  static const int maxPages = 4;
  bool _imageAdded = false;

  @override
  Widget build(BuildContext context) {

    return Scaffold(

      appBar: AppBar(
        title: Text("New input"),
      ),

      body: Column(
        children: [

          Expanded(

            child: ChangeNotifierProvider(
              create: (context) => Entry(),

              child: PageView(
                controller: _pageController,
                onPageChanged: (int page) {
                  setState(() {
                    _currentPage = page;
                  });
                },
                physics: NeverScrollableScrollPhysics(),
              
                children: [
                  
                  FormPicture(onImageAdded: () => setState(() {
                    _imageAdded = true;
                  })),

                  FormComment(),

                  FormMood(),

                  FormValidation()
                ],
              ),
            ),
          ),

          Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [

              Opacity(
                opacity: (_currentPage != 0) ? 1 : 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_back),

                  onPressed: () {
                    FocusScope.of(context).unfocus();
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
                opacity: (_currentPage != maxPages-1) && _imageAdded ? 1 : 0,
                child: IconButton(
                  icon: Icon(Icons.arrow_forward),

                  onPressed: () {
                    if(!_imageAdded) return;
                    FocusScope.of(context).unfocus();
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
