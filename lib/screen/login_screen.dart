import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/inputnumber_screen.dart';
import 'package:aviz_project/screen/usersignupinfo.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  PageController controller = PageController(initialPage: 1);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Column(
          mainAxisAlignment: MainAxisAlignment.spaceEvenly,
          children: [
            SizedBox(
              height: 500,
              child: PageView.builder(
                controller: controller,
                itemCount: 3,
                itemBuilder: (context, index) {
                  return Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
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
                      Image.asset(
                        'images/textscreenlogin.png',
                        scale: 0.9,
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
                            color: Colors.grey[500],
                            fontSize: 17,
                            fontFamily: 'SN',
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ),
                    ],
                  );
                },
              ),
            ),
            const SizedBox(
              height: 30,
            ),
            Padding(
              padding: const EdgeInsets.only(bottom: 10),
              child: SmoothPageIndicator(
                controller: controller,
                count: 3,
                effect: ExpandingDotsEffect(
                  expansionFactor: 4,
                  dotHeight: 7,
                  dotWidth: 5,
                  dotColor: Colors.grey[500]!,
                  activeDotColor: CustomColor.red,
                  spacing: 5,
                ),
              ),
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceEvenly,
              children: [
                buttonLogIn(const InputNumberScreen(), 'ورود', CustomColor.grey,
                    CustomColor.red),
                buttonLogIn(const SignUpScreen(), 'ثبت نام', CustomColor.red,
                    CustomColor.grey),
              ],
            ),
          ],
        ),
      ),
    );
  }

// Button Widget for Login and Sing up
  GestureDetector buttonLogIn(
      dynamic function, String txt, Color colorcontain, Color colortxt) {
    return GestureDetector(
      onTap: () {
        Navigator.pushReplacement(
          context,
          MaterialPageRoute(
            builder: (context) => function,
          ),
        );
      },
      child: Container(
        width: 159,
        height: 40,
        alignment: Alignment.center,
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
            fontFamily: 'SN',
            fontWeight: FontWeight.w600,
          ),
        ),
      ),
    );
  }
}
