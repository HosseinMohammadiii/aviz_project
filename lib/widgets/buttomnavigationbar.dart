import 'package:aviz_project/class/checkconnection.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/screens.dart';
import 'package:aviz_project/screen/register_phonenumber.dart';
import 'package:flutter/material.dart';

import '../Hive/Advertising/register_id.dart';

// ignore: must_be_immutable
class BottomNavigationScreen extends StatefulWidget {
  BottomNavigationScreen({
    this.index = 2,
  }) : super();
  int index;

  @override
  State<BottomNavigationScreen> createState() => _BottomNavigationScreenState();
}

class _BottomNavigationScreenState extends State<BottomNavigationScreen> {
  int _previousIndex = 0;

//Methode for Set Idexed Screens
  void onItemTapped(int index) async {
    if (!await checkInternetConnection(context)) {
      return;
    }
    if (index == 1) {
      //Check Save PhoneNumber
      final isPhoneSaved = RegisterId().getPhoneNumber().isNotEmpty;

      if (!isPhoneSaved) {
        //Save Last Index Screen
        _previousIndex = widget.index;

        //Navigate to RegisterPhonenumber Screen
        final result = await Navigator.push(
          context,
          MaterialPageRoute(
            builder: (_) => const RegisterPhonenumber(),
          ),
        );

        // If the User does not Enter the Phonenumber
        if (result == null) {
          setState(() {
            //Back to Last Index Screen
            widget.index = _previousIndex;
          });
          return;
        }
      }
    } //Set widget.index
    setState(() {
      widget.index = index;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
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
                  ? Image.asset('images/icon_home_active.png')
                  : Image.asset('images/icon_home.png'),
              label: 'آویز ها'),
        ],
        currentIndex: widget.index,
        selectedItemColor: CustomColor.red,
        onTap: onItemTapped,
      ),
      body: Center(
        child: screen.elementAt(widget.index),
      ),
    );
  }
}
