import 'package:dailymood/entries.dart';
import 'package:dailymood/mood_enum.dart';
import 'package:dailymood/picture_details.dart';
import 'package:flutter/material.dart';
import 'package:table_calendar/table_calendar.dart';
import 'package:collection/collection.dart';

class Calendar extends StatefulWidget {
  const Calendar({super.key});

  @override
  State<Calendar> createState() => _CalendarState();
}

class _CalendarState extends State<Calendar> {
  List<FinalEntry> entries = [];

  @override
  void initState() {
    super.initState();
    loadEntries();
  }

  void loadEntries() async {
    entries = await Entry.entries();
    setState(() {});
  }

  @override
  Widget build(BuildContext context) {
    return TableCalendar(
      focusedDay: DateTime.now(),
      firstDay: DateTime.utc(2020),
      lastDay: DateTime.utc(2060),
      headerStyle: HeaderStyle(
        formatButtonVisible: false
      ),

      onDaySelected: (selectedDay, focusedDay) {
        FinalEntry? entry = entries
            .firstWhereOrNull((entry) => _isSameDay(entry.date, selectedDay));

        if (entry != null) {
          Navigator.push(
              context,
              MaterialPageRoute(
                  builder: (context) => PictureDetails(entry: entry)));
        }
      },

      // Cells
      calendarBuilders: CalendarBuilders(
        markerBuilder: (context, date, events) {
          FinalEntry? entry =
              entries.firstWhereOrNull((entry) => _isSameDay(entry.date, date));

          if (entry != null) {
            return Positioned(
              top: -5,
              right: 0,
              child: Text(
                entry.mood == Mood.none ? "●" : entry.mood.toEmoji,
                style: TextStyle(fontSize: 18),
              ),
            );
          } else {
            return Container();
          }
        },
      ),
    );
  }

  bool _isSameDay(DateTime d1, DateTime d2) {
    return d1.year == d2.year && d1.month == d2.month && d1.day == d2.day;
  }
}
