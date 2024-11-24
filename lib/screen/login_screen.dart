import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/inputnumber_screen.dart';
import 'package:aviz_project/screen/usersignupinfo.dart';
import 'package:flutter/material.dart';

import '../widgets/text_widget.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          scrolledUnderElevation: 0,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    const SizedBox(
                      height: 100,
                    ),
                    Stack(
                      alignment: Alignment.center,
                      children: [
                        Image.asset('images/backhomeimage.png'),
                        Image.asset('images/homeimage.png'),
                      ],
                    ),
                    const SizedBox(
                      height: 40,
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        textWidget(
                          'آگهی شماست ',
                          CustomColor.black,
                          18,
                          FontWeight.w700,
                        ),
                        Image.asset(
                          'images/welcome_to_Aviz.png',
                          scale: 0.8,
                        ),
                        textWidget(
                          'اینجا محل ',
                          CustomColor.black,
                          18,
                          FontWeight.w700,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 6),
                      child: Text(
                        'در آویز ملک خود را برای فروش،اجاره و رهن آگهی کنید و یا اگر دنبال ملک با مشخصات دلخواه خود هستید آویز ها را ببینید',
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: CustomColor.grey500,
                          fontSize: 17,
                          fontFamily: 'SN',
                          fontWeight: FontWeight.w400,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              SliverToBoxAdapter(
                child: Align(
                  alignment: Alignment.bottomCenter,
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                    children: [
                      buttonLogIn(const InputNumberScreen(), 'ورود',
                          CustomColor.white, CustomColor.red),
                      const SizedBox(
                        width: 15,
                      ),
                      buttonLogIn(const SignUpScreen(), 'ثبت نام',
                          CustomColor.red, CustomColor.grey),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 15,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

// Button Widget for Login and Sing up
  GestureDetector buttonLogIn(
    Widget screen,
    String txt,
    Color colorcontain,
    Color colortxt,
  ) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => screen,
          ),
        );
      },
      child: Container(
        width: 159,
        height: 40,
        alignment: Alignment.center,
        margin: const EdgeInsets.only(top: 135),
        decoration: BoxDecoration(
          color: colorcontain,
          borderRadius: BorderRadius.circular(4),
          border: Border.all(
            color: CustomColor.red,
          ),
        ),
        child: Text(
          txt,
          textAlign: TextAlign.center,
          style: TextStyle(
            color: colortxt,
            fontSize: 18,
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
