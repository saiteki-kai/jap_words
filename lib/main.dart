import 'package:bottom_navigation_badge/bottom_navigation_badge.dart';
import 'package:flutter/material.dart';
import 'package:nihongo_courses/pages/course_page.dart';
import 'package:nihongo_courses/pages/courses_page.dart';
import 'package:nihongo_courses/pages/session_page.dart';
import 'package:nihongo_courses/pages/step_page.dart';
import 'package:nihongo_courses/pages/settings_page.dart';

void main() => runApp(AppPage());

class AppPage extends StatelessWidget {
  @override
  Widget build(BuildContext context) {
    return MaterialApp(
      theme: ThemeData(primarySwatch: Colors.indigo),
      home: HomePage(),
      routes: <String, WidgetBuilder>{
        '/settings': (BuildContext context) => SettingsPage(),
        '/course': (BuildContext context) => CoursePage(),
        '/step': (BuildContext context) => StepPage(),
        '/session': (BuildContext context) {
          final Map args = ModalRoute.of(context).settings.arguments;
          return SessionPage(args["words"]);
        },
      },
    );
  }
}

// TODO: Pagina per il Progresso
// TODO: Multilingua

class HomePage extends StatefulWidget {
  @override
  _HomePageState createState() => _HomePageState();
}

class _HomePageState extends State<HomePage> {
  var _selectedIndex = 0;

  final _pages = [CoursesPage(), null, SettingsPage()];

  _onItemSelected(index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  final _items = [
    BottomNavigationBarItem(
      icon: Icon(Icons.home),
      title: Text('Home'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.rate_review),
      title: Text('Reviews'),
    ),
    BottomNavigationBarItem(
      icon: Icon(Icons.settings),
      title: Text('Settings'),
    ),
  ];

  @override
  Widget build(BuildContext context) {
    var badger = BottomNavigationBadge(
      backgroundColor: Colors.red,
      badgeShape: BottomNavigationBadgeShape.circle,
      textColor: Colors.white,
      position: BottomNavigationBadgePosition.topRight,
      textSize: 8,
    );

    badger.setBadge(_items, "2", 1);

    return Scaffold(
      appBar: AppBar(title: Text("Nome App")),
      body: _pages.elementAt(_selectedIndex),
      bottomNavigationBar: BottomNavigationBar(
        onTap: _onItemSelected,
        currentIndex: _selectedIndex,
        items: _items,
      ),
    );
  }
}
