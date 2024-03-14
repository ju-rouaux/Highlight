import 'package:dailymood/calendar.dart';
import 'package:dailymood/timeline.dart';
import 'package:flutter/material.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();

  runApp(MaterialApp(
    title: 'Daily Mood',
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system, // Use system theme
    home: const MyHomePage(title: 'Daily Mood'),
  ));
}

class MyHomePage extends StatefulWidget {
  const MyHomePage({super.key, required this.title});

  final String title;

  @override
  State<MyHomePage> createState() => _MyHomePageState();
}

class _MyHomePageState extends State<MyHomePage> {
  @override
  Widget build(BuildContext context) {
    return DefaultTabController(
        initialIndex: 0,
        length: 2,
        child: Scaffold(
          appBar: AppBar(
            title: Text(widget.title),
            bottom: const TabBar(
              tabs: [
                Tab(icon: Icon(Icons.home)),
                Tab(icon: Icon(Icons.calendar_today))
              ],
            ),
          ),
          body: const TabBarView(
            children: [
              Padding(
                  padding: EdgeInsets.symmetric(horizontal: 20),
                  child: Timeline()),
              Calendar(),
            ],
          ),
        ));
  }
}
