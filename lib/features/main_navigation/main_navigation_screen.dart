import 'package:flutter/material.dart';
import 'package:font_awesome_flutter/font_awesome_flutter.dart';

class MainNavigationScreen extends StatefulWidget {
  const MainNavigationScreen({super.key});

  @override
  State<MainNavigationScreen> createState() => _MainNavigationScreenState();
}

class _MainNavigationScreenState extends State<MainNavigationScreen> {
  int _selectedIndex = 0;

  final screens = [
    const Center(
      child: Text('Home'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Search'),
    ),
    const Center(
      child: Text('Search'),
    ),
  ];

  void _onTap(int index) {
    setState(() {
      _selectedIndex = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: screens[_selectedIndex],
      bottomNavigationBar: BottomNavigationBar(
        type: BottomNavigationBarType.shifting, // Default BottomNavigationBarType is shifting but fixed also exists
        currentIndex: _selectedIndex,
        onTap: _onTap,
        selectedItemColor: Theme.of(context).primaryColor,
        items: const [
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.house),
            label: 'Home',
            // activeIcon: ,
            // backgroundColor: Colors.amber, // Changes the background color of whole BottomNavigationBar which has four or more BottomNavigationBarItem automatically
            tooltip: 'What are you?',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
            // activeIcon: ,
            // backgroundColor: Colors.blue,
            tooltip: 'What are you?',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
            // activeIcon: ,
            // backgroundColor: Colors.pink,
            tooltip: 'What are you?',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
            // activeIcon: ,
            // backgroundColor: Colors.yellow,
            tooltip: 'What are you?',
          ),
          BottomNavigationBarItem(
            icon: FaIcon(FontAwesomeIcons.magnifyingGlass),
            label: 'Search',
            // activeIcon: ,
            // backgroundColor: Colors.teal,
            tooltip: 'What are you?',
          ),
        ],
      ),
    );
  }
}
