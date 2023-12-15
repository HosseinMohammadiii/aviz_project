import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class UploadLocation extends StatelessWidget {
  const UploadLocation({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        Container(
          height: 144,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: Colors.blue[100],
          ),
        ),
        Container(
          width: 185,
          height: 40,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(8),
            color: CustomColor.red,
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Image.asset('images/location_icon.png'),
              textWidget(
                'گرگان، صیاد شیرا...',
                CustomColor.grey,
                16,
                FontWeight.w400,
              ),
            ],
          ),
        ),
      ],
    );
  }
}
