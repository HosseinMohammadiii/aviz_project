import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class UploadLocation extends StatelessWidget {
  UploadLocation({
    super.key,
    required this.address,
  });
  String address;
  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        SizedBox(
          height: 144,
          width: double.infinity,
          child: ClipRRect(
            borderRadius: BorderRadius.circular(8),
            child: Image.asset(
              'images/map_image.png',
              fit: BoxFit.cover,
            ),
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
                address,
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
