import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {
  const UploadImage({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        DottedBorder(
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          padding: const EdgeInsets.all(4),
          radius: const Radius.circular(4),
          dashPattern: const [8, 4],
          color: Colors.grey[350]!,
          strokeWidth: 2,
          child: Container(
            height: 144,
          ),
        ),
        Column(
          children: [
            textWidget(
              'لطفا تصویر آویز خود را بارگذاری کنید',
              Colors.grey[500]!,
              14,
              FontWeight.w400,
            ),
            Container(
              width: 149,
              height: 40,
              margin: const EdgeInsets.symmetric(vertical: 12),
              decoration: BoxDecoration(
                borderRadius: BorderRadius.circular(8),
                color: CustomColor.red,
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  textWidget(
                    'انتخاب تصویر',
                    CustomColor.grey,
                    16,
                    FontWeight.w400,
                  ),
                  Image.asset('images/document_upload_icon.png'),
                ],
              ),
            ),
          ],
        ),
      ],
    );
  }
}
