import 'dart:io';
import 'package:dailymood/mood_enum.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

class Entry extends ChangeNotifier {

  int? _id;
  DateTime _date = DateTime.now();
  File? _image;
  String _title = "";
  String _description = "";
  Mood _mood = Mood.neutral;

  DateTime get date => _date;
  File? get image => _image;
  String get title => _title;
  String get description => _description;
  Mood get mood => _mood;

  void updateDate(DateTime newDate) {
    _date = newDate;
    notifyListeners();
  }

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


  static Future<Database> get database async {
    return openDatabase(
      join(await getDatabasesPath(), 'dailymood_test02.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE entries(id INTEGER PRIMARY KEY, date TEXT, image TEXT, title TEXT, description TEXT, mood TEXT)",
        );
      },
      version: 1,
    );
  }

  Future<void> saveEntry() async {
    final db = await database;

    await db.insert(
      'entries',
      {
        'id': _date.toIso8601String().split('T')[0].replaceAll("-", ""),
        'date': _date.toIso8601String(),
        'image': _image?.path,
        'title': _title,
        'description': _description,
        'mood': _mood.toString(),
      },
      conflictAlgorithm: ConflictAlgorithm.replace,
    );
  }

  static Future<List<Entry>> entries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps = await db.query('entries', orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return Entry()
        .._id = maps[i]['id']
        ..updateDate(DateTime.parse(maps[i]['date']))
        ..updateImage(File(maps[i]['image']))
        ..updateTitle(maps[i]['title'])
        ..updateDescription(maps[i]['description'])
        ..updateMood(Mood.values.firstWhere((e) => e.toString() == maps[i]['mood']));
    });
  }

  Future<void> updateEntry() async {
    final db = await database;

    await db.update(
      'entries',
      {
        'date': _date.toIso8601String(),
        'image': _image?.path,
        'title': _title,
        'description': _description,
        'mood': _mood.toString(),
      },
      where: 'id = ?',
      whereArgs: [_id],
    );
  }

}