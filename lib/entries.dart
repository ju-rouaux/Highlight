import 'dart:io';
import 'package:dailymood/mood_enum.dart';
import 'package:flutter/material.dart';
import 'package:path/path.dart';
import 'package:sqflite/sqflite.dart';

// Set of functions to manipulate the database
class Entry {
  Entry._(); // Private constructor

  static Database? _database;

  static Future<Database> get database async {
    _database ??= await openDatabase(
      join(await getDatabasesPath(), 'dailymood_test02.db'),
      onCreate: (db, version) {
        return db.execute(
          "CREATE TABLE entries(id INTEGER PRIMARY KEY, date TEXT, image TEXT, title TEXT, description TEXT, mood TEXT)",
        );
      },
      version: 1,
    );

    return _database!;
  }

  static Future<List<FinalEntry>> entries() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('entries', orderBy: 'date DESC');
    return List.generate(maps.length, (i) {
      return FinalEntry(
        maps[i]['id'],
        DateTime.parse(maps[i]['date']),
        File(maps[i]['image']),
        maps[i]['title'],
        maps[i]['description'],
        Mood.values.firstWhere((e) => e.toString() == maps[i]['mood']),
      );
    });
  }

  static Future<bool> todayEntryDoesExist() async {
    final db = await database;
    final List<Map<String, dynamic>> maps =
        await db.query('entries', orderBy: 'date DESC');
    if (maps.isNotEmpty) {
      return maps[0]['id'].toString() ==
          DateTime.now().toIso8601String().split('T')[0].replaceAll("-", "");
    }
    return false;
  }

  static Future<void> deleteEntry(int? id) async {
    if (id == null) return;

    final db = await database;

    await db.delete(
      'entries',
      where: 'id = ?',
      whereArgs: [id],
    );
  }
}

// Entry whith no listener, cannot be modified after creation
class FinalEntry {
  final int? id;
  final DateTime date;
  final File image;
  final String title;
  final String description;
  final Mood mood;

  FinalEntry(
      this.id, this.date, this.image, this.title, this.description, this.mood);

  FinalEntry.fromNewEntry(NewEntry newEntry)
      : id = newEntry._id,
        date = newEntry.date,
        image = newEntry.image!,
        title = newEntry.title,
        description = newEntry.description,
        mood = newEntry.mood;

  FinalEntry.onlyImage(File img)
      : id = null,
        date = DateTime.now(),
        image = img,
        title = "",
        description = "",
        mood = Mood.none;
}

// Entry with listener for UI, can be modified after creation
class NewEntry extends ChangeNotifier {
  int? _id;
  DateTime _date = DateTime.now();
  File? _image;
  String _title = "";
  String _description = "";
  Mood _mood = Mood.none;

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

  Future<void> saveEntry() async {
    final db = await Entry.database;

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

  Future<void> updateEntry() async {
    final db = await Entry.database;

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
