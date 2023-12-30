import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/screens.dart';
import 'package:flutter/material.dart';

class BottomNavigationScreen extends StatefulWidget {
  const BottomNavigationScreen({super.key});

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _selectedItem = 3;

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: CustomColor.grey,
      bottomNavigationBar: BottomNavigationBar(
        selectedLabelStyle: const TextStyle(
          fontFamily: 'SN',
          fontSize: 14,
          color: CustomColor.red,
          fontWeight: FontWeight.w600,
        ),
        unselectedLabelStyle: TextStyle(
          fontFamily: 'SN',
          fontSize: 12,
          color: Colors.grey[400],
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: CustomColor.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: _selectedItem == 0
                  ? Image.asset('images/icon_profile-active.png')
                  : Image.asset('images/icon_profile.png'),
              label: 'آویز من'),
          BottomNavigationBarItem(
              icon: _selectedItem == 1
                  ? Image.asset('images/icon_add_active.png')
                  : Image.asset('images/icon_add.png'),
              label: 'افزودن آویز'),
          BottomNavigationBarItem(
              icon: _selectedItem == 2
                  ? Image.asset('images/note_red.png')
                  : Image.asset('images/note_grey.png'),
              label: 'آگهی من'),
          BottomNavigationBarItem(
              icon: _selectedItem == 3
                  ? Image.asset('images/icon_home_active.png')
                  : Image.asset('images/icon_home.png'),
              label: 'آویز آگهی ها'),
        ],
        currentIndex: _selectedItem,
        selectedItemColor: CustomColor.red,
        onTap: (index) {
          setState(() {
            _selectedItem = index;
          });
        },
      ),
      body: Center(
        child: screen.elementAt(_selectedItem),
      ),
    );
  }
}
