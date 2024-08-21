import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/widgets/buttomnavigationbar.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:pinput/pinput.dart';
import 'package:flutter/material.dart';

// ignore: must_be_immutable
class ConfirmationNumberScreen extends StatefulWidget {
  ConfirmationNumberScreen(this.txt1, this.txt2, this.color1, this.color2,
      {super.key});
  String txt1;
  String txt2;
  Color color1;
  Color color2;
  @override
  State<ConfirmationNumberScreen> createState() =>
      _ConfirmationNumberScreenState();
}

class _ConfirmationNumberScreenState extends State<ConfirmationNumberScreen> {
  final FocusNode focusNode = FocusNode();
  @override
  Widget build(BuildContext context) {
    final defaultPinTheme = PinTheme(
      width: MediaQuery.of(context).size.width,
      height: 60,
      textStyle: const TextStyle(
        fontSize: 22,
        fontFamily: 'SN',
      ),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: CustomColor.grey200,
      ),
    );
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              textWidget(
                'تایید شماره موبایل',
                CustomColor.black,
                20,
                FontWeight.w700,
              ),
              const SizedBox(
                height: 12,
              ),
              textWidget(
                widget.txt1,
                CustomColor.grey500,
                15,
                FontWeight.w400,
              ),
              const SizedBox(
                height: 23,
              ),
              Pinput(
                focusNode: focusNode,
                onTapOutside: (event) {
                  focusNode.unfocus();
                },
                defaultPinTheme: defaultPinTheme,
                submittedPinTheme: defaultPinTheme.copyWith(
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                    color: CustomColor.grey350,
                  ),
                ),
              ),
              const SizedBox(
                height: 35,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  textWidget(
                    ' ارسال مجدد کد',
                    widget.color1,
                    15,
                    FontWeight.w600,
                  ),
                  textWidget(
                    widget.txt2,
                    widget.color2,
                    16,
                    FontWeight.w700,
                  ),
                ],
              ),
              const Spacer(),
              GestureDetector().textButton(
                () {
                  Navigator.pushReplacement(
                    context,
                    MaterialPageRoute(
                      builder: (context) => BottomNavigationScreen(),
                    ),
                  );
                },
                'تایید ورود',
                CustomColor.red,
                CustomColor.grey,
                false,
              ),
              const SizedBox(
                height: 10,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
