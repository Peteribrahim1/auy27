import 'package:auy27/screens/categoy_screens.dart';
import 'package:auy27/screens/general_map.dart';
import 'package:auy27/screens/home.dart';
import 'package:auy27/screens/live_chat.dart';
import 'package:auy27/screens/search_map.dart';
import 'package:flutter/material.dart';

import 'help.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({Key? key, this.number}) : super(key: key);

  final int? number;
  static const routeName = '/tabscreen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  final List<Map<String, dynamic>> _pages = [
    {
      'page': const Home(),
    },
    {
      'page': const CategoryScreen(),
    },
    {
      'page': const GeneralMap(),
    },
    {
      'page': LiveChat(),
    },
  ];
  int _selectedPageIndex = 0;

  @override
  Widget build(BuildContext context) {
    _selectedPageIndex = widget.number ?? _selectedPageIndex;

    void _selectPage(int index) {
      setState(() {
        _selectedPageIndex = index;
      });
    }

    return Scaffold(
      body: _pages[_selectedPageIndex]['page'],
      bottomNavigationBar: BottomNavigationBar(
        key: GlobalKey(),
        onTap: _selectPage,
        backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
        unselectedItemColor: const Color.fromRGBO(123, 141, 158, 1),
        selectedItemColor: Colors.black,

        currentIndex: _selectedPageIndex,
        // type: BottomNavigationBarType.fixed,
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.home, color: Colors.black),
            label: 'Home',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.category_outlined, color: Colors.black),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.location_on, color: Colors.black),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.help, color: Colors.black),
            label: 'Help',
          ),
        ],
      ),
    );
  }
}
