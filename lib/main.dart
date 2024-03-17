import 'package:flutter/services.dart';
import 'package:highlight/calendar.dart';
import 'package:highlight/timeline.dart';
import 'package:flutter/material.dart';
import 'package:flutter_localizations/flutter_localizations.dart';
import 'package:flutter_gen/gen_l10n/app_localizations.dart';
import 'package:intl/date_symbol_data_local.dart';

Future<void> main() async {
  WidgetsFlutterBinding.ensureInitialized();
  await initializeDateFormatting();

  runApp(MaterialApp(
    title: 'Highlight',
    theme: ThemeData.light(),
    darkTheme: ThemeData.dark(),
    themeMode: ThemeMode.system, // Use system theme
    localizationsDelegates: const [
      AppLocalizations.delegate,
      GlobalMaterialLocalizations.delegate,
      GlobalWidgetsLocalizations.delegate,
      GlobalCupertinoLocalizations.delegate,
    ],
    supportedLocales: const [
      Locale('en'), // English
      Locale('fr'), // French
    ],
    home: OrientationBuilder(
      builder: (BuildContext context, Orientation orientation) {
        // Block rotation if device too small
        if (MediaQuery.of(context).size.shortestSide < 500) {
          SystemChrome.setPreferredOrientations([
            DeviceOrientation.portraitUp,
            DeviceOrientation.portraitDown,
          ]);
        }
        if (orientation == Orientation.landscape) {
          return const MyHomePageWithoutTabs(title: 'Highlight');
        } else {
          return const MyHomePage(title: 'Highlight');
        }
      },
    ),
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
              child: Timeline(),
            ),
            Calendar(),
          ],
        ),
      ),
    );
  }
}

class MyHomePageWithoutTabs extends StatelessWidget {
  const MyHomePageWithoutTabs({super.key, required this.title});

  final String title;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        title: Text(title),
      ),
      body: const Row(
        children: [
          Expanded(
            child: Padding(
              padding: EdgeInsets.symmetric(horizontal: 20),
              child: Timeline(),
            ),
          ),
          Expanded(
            child: Calendar(),
          ),
        ],
      ),
    );
  }
}
