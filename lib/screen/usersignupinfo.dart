import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/screen/confirmationnumber_screen.dart';
import 'package:aviz_project/screen/inputnumber_screen.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:flutter/material.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  Image.asset('images/aviz_icon.png'),
                  const SizedBox(
                    width: 4,
                  ),
                  textWidget(
                    'خوش اومدی به',
                    CustomColor.black,
                    16,
                    FontWeight.w700,
                  ),
                ],
              ),
              const SizedBox(
                height: 12,
              ),
              textWidget(
                'این فوق العادست که آویزو برای آگهی هات انتخاب کردی!',
                CustomColor.grey500,
                15,
                FontWeight.w400,
              ),
              const SizedBox(
                height: 25,
              ),
              TextFieldBox(
                hint: 'نام و نام خانوادگی',
                textInputType: TextInputType.name,
                countLine: 1,
                focusNode: FocusNode(),
                textInputAction: TextInputAction.next,
              ),
              const SizedBox(
                height: 30,
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
                  Navigator.push(
                    context,
                    MaterialPageRoute(
                      builder: (context) => ConfirmationNumberScreen(
                        'کد ثبت نام پیامک شده را وارد کنید',
                        '00:00',
                        CustomColor.black,
                        CustomColor.grey500,
                      ),
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
                          builder: (context) => const InputNumberScreen(),
                        ),
                      );
                    },
                    child: textWidget(
                      '  ورود',
                      CustomColor.red,
                      17,
                      FontWeight.w600,
                    ),
                  ),
                  textWidget(
                    'قبلا ثبت نام کردی؟',
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
