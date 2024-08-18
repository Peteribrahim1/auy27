// import 'package:auy27/screens/categoy_screens.dart';
// import 'package:auy27/screens/general_map.dart';
// import 'package:auy27/screens/home.dart';
// import 'package:auy27/screens/live_chat.dart';
// import 'package:auy27/screens/todo_screen.dart';
// import 'package:flutter/material.dart';
//
// import 'help.dart';
//
// class TabsScreen extends StatefulWidget {
//   TabsScreen({Key? key, this.number}) : super(key: key);
//
//   final int? number;
//   static const routeName = '/tabscreen';
//
//   @override
//   State<TabsScreen> createState() => _TabsScreenState();
// }
//
// class _TabsScreenState extends State<TabsScreen> {
//   final List<Map<String, dynamic>> _pages = [
//     {
//       'page': const Home(),
//     },
//     {
//       'page': const CategoryScreen(),
//     },
//     {
//       'page': const GeneralMap(),
//     },
//     {
//       'page': const TodoScreen(),
//     },
//     {
//       'page': LiveChat(),
//     },
//   ];
//   // int _selectedPageIndex = widget.number ?? 0;
//   int _selectedPageIndex = TabsScreen().number ?? 1;
//   // setState(() {});
//   @override
//   Widget build(BuildContext context) {
//     // setState(() {
//     //   _selectedPageIndex = widget.number ?? _selectedPageIndex;
//     // });
//     print('selected page index ${_selectedPageIndex}');
//     print('try this${widget.number}');
//     setState(() {});
//     void _selectPage(int index) {
//       setState(() {
//         _selectedPageIndex = index;
//       });
//       print('hey ${_selectedPageIndex}');
//     }
//
//     return Scaffold(
//       body: _pages[_selectedPageIndex]['page'],
//       bottomNavigationBar: BottomNavigationBar(
//         key: GlobalKey(),
//         onTap: _selectPage,
//         backgroundColor: const Color.fromRGBO(255, 255, 255, 1),
//         unselectedItemColor: const Color.fromRGBO(123, 141, 158, 1),
//         selectedItemColor: Colors.black,
//
//         currentIndex: _selectedPageIndex,
//         // type: BottomNavigationBarType.fixed,
//         items: const [
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Icon(Icons.stacked_bar_chart,
//                 color: Color.fromRGBO(47, 79, 79, 1)),
//             label: 'Dashboard',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Icon(Icons.category_outlined,
//                 color: Color.fromRGBO(47, 79, 79, 1)),
//             label: 'Category',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Icon(Icons.location_on, color: Color.fromRGBO(47, 79, 79, 1)),
//             label: 'Map',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Icon(Icons.list_alt, color: Color.fromRGBO(47, 79, 79, 1)),
//             label: 'Todo',
//           ),
//           BottomNavigationBarItem(
//             backgroundColor: Colors.white,
//             icon: Icon(Icons.help, color: Color.fromRGBO(47, 79, 79, 1)),
//             label: 'Help',
//           ),
//         ],
//       ),
//     );
//   }
// }
import 'package:flutter/material.dart';
import 'package:auy27/screens/categoy_screens.dart';
import 'package:auy27/screens/general_map.dart';
import 'package:auy27/screens/home.dart';
import 'package:auy27/screens/live_chat.dart';
import 'package:auy27/screens/todo_screen.dart';

class TabsScreen extends StatefulWidget {
  TabsScreen({Key? key, this.number}) : super(key: key);

  final int? number;
  static const routeName = '/tabscreen';

  @override
  State<TabsScreen> createState() => _TabsScreenState();
}

class _TabsScreenState extends State<TabsScreen> {
  late int _selectedPageIndex;

  @override
  void initState() {
    super.initState();
    // Initialize _selectedPageIndex with the value from the widget's constructor.
    _selectedPageIndex =
        widget.number ?? 0; // Default to 1 if widget.number is null
  }

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
      'page': const TodoScreen(),
    },
    {
      'page': LiveChat(),
    },
  ];

  @override
  Widget build(BuildContext context) {
    void _selectPage(int index) {
      setState(() {
        _selectedPageIndex = index;
      });
      //  print('Selected page index after tap: $_selectedPageIndex');
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
        items: const [
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.stacked_bar_chart,
                color: Color.fromRGBO(47, 79, 79, 1)),
            label: 'Dashboard',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.category_outlined,
                color: Color.fromRGBO(47, 79, 79, 1)),
            label: 'Category',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.location_on, color: Color.fromRGBO(47, 79, 79, 1)),
            label: 'Map',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.list_alt, color: Color.fromRGBO(47, 79, 79, 1)),
            label: 'Todo',
          ),
          BottomNavigationBarItem(
            backgroundColor: Colors.white,
            icon: Icon(Icons.help, color: Color.fromRGBO(47, 79, 79, 1)),
            label: 'Help',
          ),
        ],
      ),
    );
  }
}
