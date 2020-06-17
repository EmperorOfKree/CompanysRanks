import 'package:companiesranks/feature/company_rank/ui/company_rank_page.dart';
import 'package:companiesranks/feature/import_data/ui/import_data_page.dart';
import 'package:flutter/material.dart';

class HomeNavigation extends StatefulWidget {
  static const String routeName = "app_navigation_bar";
  @override
  _HomeNavigationState createState() => _HomeNavigationState();
}

class _HomeNavigationState extends State<HomeNavigation> {
  int _currentIndex = 0;
  final List<Widget> _children = [CompanyRankPage(), ImportDataPage()];

  void _onItemTapped(int index) {
    setState(() {
      _currentIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      resizeToAvoidBottomInset: false,
      body: _children[_currentIndex],
      appBar: AppBar(
        title: const Text(
          "Companies Ranks",
          style: TextStyle(color: Colors.white, fontSize: 30),
        ),
        backgroundColor: Colors.purple,
        actions: <Widget>[],
      ),
      bottomNavigationBar: BottomNavigationBar(
        currentIndex: _currentIndex,
        onTap: _onItemTapped,
        items: const <BottomNavigationBarItem>[
          BottomNavigationBarItem(
            icon: Icon(Icons.home),
            title: Text("Home"),
          ),
          BottomNavigationBarItem(
            icon: Icon(Icons.import_export),
            title: Text("Import data"),
          ),
        ],
      ),
    );
  }
}
