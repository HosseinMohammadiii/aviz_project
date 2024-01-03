import 'dart:io';

import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';

class UploadImage extends StatelessWidget {
  UploadImage({
    super.key,
    required this.onChange,
    required this.fileImage,
  });
  Function() onChange;
  File? fileImage;
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
          color: fileImage == null ? CustomColor.grey350 : CustomColor.white,
          strokeWidth: 2,
          child: Container(
            height: 144,
          ),
        ),
        fileImage == null
            ? Column(
                children: [
                  textWidget(
                    'لطفا تصویر آویز خود را بارگذاری کنید',
                    CustomColor.grey500,
                    14,
                    FontWeight.w400,
                  ),
                  GestureDetector(
                    onTap: () => onChange(),
                    child: Container(
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
                  ),
                ],
              )
            : SizedBox(
                height: 144,
                width: double.infinity,
                child: ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: Image.file(
                    fileImage!,
                    fit: BoxFit.fill,
                  ),
                ),
              ),
      ],
    );
  }
}
