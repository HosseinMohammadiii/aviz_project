import 'dart:io';

import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

class UploadImage extends StatelessWidget {
  UploadImage({
    super.key,
    required this.onChange,
    required this.fileImage,
  });
  Function() onChange;
  List<File>? fileImage;

  @override
  Widget build(BuildContext context) {
    PageController controller =
        PageController(viewportFraction: 0.9, initialPage: 0);
    return Stack(
      alignment: Alignment.center,
      children: [
        DottedBorder(
          strokeCap: StrokeCap.round,
          borderType: BorderType.RRect,
          padding: const EdgeInsets.all(4),
          radius: const Radius.circular(4),
          dashPattern: const [8, 4],
          color: fileImage!.isEmpty ? CustomColor.grey350 : Colors.transparent,
          strokeWidth: 2,
          child: Container(
            height: 144,
          ),
        ),
        fileImage!.isEmpty
            ? Column(
                children: [
                  textWidget(
                    'لطفا تصاویر آویز خود را بارگذاری کنید',
                    CustomColor.grey500,
                    14,
                    FontWeight.w400,
                  ),
                  GestureDetector(
                    onTap: () => onChange(),
                    child: Container(
                      width: 149,
                      height: 50,
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
                child: PageView.builder(
                  controller: controller,
                  itemCount: fileImage!.length,
                  itemBuilder: (context, index) {
                    return Padding(
                      padding: const EdgeInsets.symmetric(horizontal: 5),
                      child: ClipRRect(
                        borderRadius: BorderRadius.circular(8),
                        child: Stack(
                          fit: StackFit.expand,
                          children: [
                            Image.file(
                              fileImage![index],
                              fit: BoxFit.fill,
                            ),
                            Positioned(
                              top: 10,
                              right: 12,
                              child: GestureDetector(
                                onTap: () => onChange(),
                                child: const Icon(
                                  Icons.add_a_photo,
                                  color: CustomColor.red,
                                ),
                              ),
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                )),
        Padding(
          padding: const EdgeInsets.only(top: 115),
          child: SmoothPageIndicator(
            controller: controller,
            count: fileImage!.length,
            effect: const ExpandingDotsEffect(
              expansionFactor: 5,
              dotHeight: 8,
              dotWidth: 8,
              dotColor: Colors.white,
              activeDotColor: CustomColor.red,
            ),
          ),
        ),
      ],
    );
  }
}
