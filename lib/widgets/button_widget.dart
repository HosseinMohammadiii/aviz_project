import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class ButtonWidget extends StatelessWidget {
  const ButtonWidget({super.key});

  @override
  Widget build(BuildContext context) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        Container(
          width: 159,
          height: 40,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: CustomColor.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              textWidget(
                'اطلاعات تماس',
                CustomColor.grey,
                16,
                FontWeight.w500,
              ),
              Image.asset('images/call_icon.png')
            ],
          ),
        ),
        Container(
          width: 159,
          height: 40,
          margin: const EdgeInsets.only(bottom: 15),
          decoration: BoxDecoration(
            color: CustomColor.red,
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              textWidget(
                'گفتگو',
                CustomColor.grey,
                16,
                FontWeight.w500,
              ),
              const SizedBox(
                width: 12,
              ),
              Image.asset('images/message_icon.png')
            ],
          ),
        ),
      ],
    );
  }
}
