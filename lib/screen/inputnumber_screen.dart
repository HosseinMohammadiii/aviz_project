import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/screen/confirmationnumber_screen.dart';
import 'package:aviz_project/screen/usersignupinfo.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:flutter/material.dart';

class InputNumberScreen extends StatelessWidget {
  const InputNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Image.asset('images/textinputnumscreen.png'),
              const SizedBox(
                height: 12,
              ),
              textWidget('خوشحالیم که مجددا آویز رو برای آگهی انتخاب کردی!',
                  CustomColor.grey500, 15, FontWeight.w400),
              const SizedBox(
                height: 25,
              ),
              TextFieldBox(
                hint: 'شماره موبایل',
                textInputType: TextInputType.number,
                countLine: 1,
                focusNode: FocusNode(),
                textInputAction: TextInputAction.done,
              ),
              const Spacer(),
              GestureDetector().textButton(
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationNumberScreen(
                          'کد ورود پیامک شده را وارد کنید',
                          '00:45',
                          CustomColor.grey500,
                          CustomColor.black),
                    ),
                  );
                },
                'مرحله بعد',
                CustomColor.red,
                CustomColor.grey,
                true,
              ),
              const SizedBox(
                height: 10,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  GestureDetector(
                    onTap: () {
                      Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const SignUpScreen(),
                        ),
                      );
                    },
                    child: textWidget(
                      ' ثبت نام',
                      CustomColor.red,
                      17,
                      FontWeight.w600,
                    ),
                  ),
                  textWidget(
                    'تا حالا ثبت نام نکردی؟',
                    CustomColor.grey500,
                    17,
                    FontWeight.w400,
                  ),
                ],
              ),
            ],
          ),
        ),
      ),
    );
  }
}
