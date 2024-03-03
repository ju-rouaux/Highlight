import 'dart:io';

import 'package:dailymood/mood_enum.dart';
import 'package:flutter/material.dart';

class Entry extends ChangeNotifier {
  File? _image;
  String _title = "";
  String _description = "";
  Mood _mood = Mood.neutral;

  File? get image => _image;
  String get title => _title;
  String get description => _description;
  Mood get mood => _mood;

  void updateImage(File newImage) {
    _image = newImage;
    notifyListeners();
  }

  void updateTitle(String newTitle) {
    _title = newTitle;
    notifyListeners();
  }

  void updateDescription(String newDesc) {
    _description = newDesc;
    notifyListeners();
  }

  void updateMood(Mood newMood) {
    _mood = newMood;
    notifyListeners();
  }
  
}