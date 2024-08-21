import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/screens.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({
    super.key,
    this.index = 3,
  });
  int index;
  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
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
        unselectedLabelStyle: const TextStyle(
          fontFamily: 'SN',
          fontSize: 12,
          color: CustomColor.grey400,
          fontWeight: FontWeight.w500,
        ),
        backgroundColor: CustomColor.grey,
        type: BottomNavigationBarType.fixed,
        elevation: 0,
        items: [
          BottomNavigationBarItem(
              icon: widget.index == 0
                  ? Image.asset('images/icon_profile-active.png')
                  : Image.asset('images/icon_profile.png'),
              label: 'آویز من'),
          BottomNavigationBarItem(
              icon: widget.index == 1
                  ? Image.asset('images/icon_add_active.png')
                  : Image.asset('images/icon_add.png'),
              label: 'افزودن آویز'),
          BottomNavigationBarItem(
              icon: widget.index == 2
                  ? Image.asset('images/note_red.png')
                  : Image.asset('images/note_grey.png'),
              label: 'آگهی من'),
          BottomNavigationBarItem(
              icon: widget.index == 3
                  ? Image.asset('images/icon_home_active.png')
                  : Image.asset('images/icon_home.png'),
              label: 'آویز آگهی ها'),
        ],
        currentIndex: widget.index,
        selectedItemColor: CustomColor.red,
        onTap: (index) {
          setState(() {
            widget.index = index;
          });
        },
      ),
      body: Center(
        child: screen.elementAt(widget.index),
      ),
    );
  }
}
