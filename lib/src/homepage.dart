import 'package:flutter/material.dart';
import 'package:material_design_icons_flutter/material_design_icons_flutter.dart';
import 'package:padelloversapp/src/clasificationPage.dart';
import 'package:padelloversapp/src/resultPage.dart';
import 'package:padelloversapp/src/selectLeague.dart';
import 'package:padelloversapp/src/widgets/itemResultList.dart';

class homePage extends StatefulWidget {
  static const double appbarheight = 50.0;
  static const List<Widget> _widgetOptions = <Widget>[
    LeagueSelection(),
    resultPage(),
    clasificationPage()
  ];

  @override
  _homePageState createState() => _homePageState();
}

class _homePageState extends State<homePage> {
  int _selectedIndex = 0;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: homePage._widgetOptions[_selectedIndex],
      ),
      bottomNavigationBar: BottomNavigationBar(
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.tennisBall),
            title: Text('Ligas'),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.view_list),
            title: Text('Resultados'),
          ),
          BottomNavigationBarItem(
            icon: Icon(MdiIcons.trophy),
            title: Text('Clasificación'),
          ),
        ],
        currentIndex: _selectedIndex,
        selectedItemColor: Colors.lightGreen,
        onTap: _onItemTapped,
      ),
      //floatingActionButton: FloatingActionButton(
      //  backgroundColor: Theme.of(context).primaryColor,
      //  onPressed: () => {},
      //  child: Icon(Icons.swap_horizontal_circle),
      //),
      floatingActionButtonLocation: FloatingActionButtonLocation.centerDocked,
    );
  }

  void _onItemTapped(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }
}
