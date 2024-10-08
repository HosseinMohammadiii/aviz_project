import 'dart:io';

import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import '../Hive/Advertising/register_id.dart';

// ignore: must_be_immutable
class UploadImage extends StatefulWidget {
  UploadImage({
    super.key,
    required this.onChange,
    required this.addImage,
    required this.fileImage,
  });
  Function() onChange;
  Function() addImage;
  List<File>? fileImage;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  PageController controller =
      PageController(viewportFraction: 0.9, initialPage: 0);
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
          color: widget.fileImage!.isEmpty
              ? CustomColor.grey350
              : Colors.transparent,
          strokeWidth: 2,
          child: Container(
            height: 144,
          ),
        ),
        Visibility(
          visible: widget.fileImage!.isEmpty,
          replacement: SizedBox(
            height: 150,
            child: PageView.builder(
              controller: controller,
              itemCount: widget.fileImage?.length ?? 0,
              itemBuilder: (context, index) {
                return Padding(
                  padding: const EdgeInsets.symmetric(horizontal: 5),
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Stack(
                      fit: StackFit.expand,
                      children: [
                        GestureDetector(
                          onTap: () {
                            showDialog(
                              context: context,
                              builder: (context) {
                                return AlertDialog(
                                  contentPadding: EdgeInsets.zero,
                                  content: ClipRRect(
                                    borderRadius: BorderRadius.circular(8),
                                    child: InteractiveViewer(
                                      child: Image.file(
                                        widget.fileImage![index],
                                        key: ValueKey(
                                            widget.fileImage![index].path),
                                        fit: BoxFit.fill,
                                      ),
                                    ),
                                  ),
                                );
                              },
                            );
                          },
                          child: Image.file(
                            widget.fileImage![index],
                            key: ValueKey(widget.fileImage![index].path),
                            fit: BoxFit.fill,
                          ),
                        ),
                        Positioned(
                          top: 10,
                          right: 12,
                          child: GestureDetector(
                            onTap: () => widget.addImage(),
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: CustomColor.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                Icons.add_a_photo_rounded,
                                color: CustomColor.white,
                              ),
                            ),
                          ),
                        ),
                        Positioned(
                          top: 10,
                          left: 12,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                widget.fileImage!.removeAt(index);

                                BlocProvider.of<AddAdvertisingBloc>(context)
                                    .add(DeleteImageData(
                                        RegisterId().getIdGallery()));
                                if (widget.fileImage!.isNotEmpty) {
                                  BlocProvider.of<AddAdvertisingBloc>(context)
                                      .add(AddImagesToGallery(
                                          widget.fileImage!));
                                }
                              });
                            },
                            child: Container(
                              width: 30,
                              height: 30,
                              decoration: BoxDecoration(
                                color: CustomColor.red,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              child: Icon(
                                Icons.delete,
                                color: CustomColor.white,
                              ),
                            ),
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            ),
          ),
          child: Column(
            children: [
              textWidget(
                'لطفا تصاویر آویز خود را بارگذاری کنید',
                CustomColor.grey500,
                14,
                FontWeight.w400,
              ),
              GestureDetector(
                onTap: () => widget.onChange(),
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
          ),
        ),
        Visibility(
          visible: widget.fileImage!.isNotEmpty,
          child: Positioned(
            bottom: 12,
            child: SmoothPageIndicator(
              controller: controller,
              count: widget.fileImage!.length,
              effect: const ExpandingDotsEffect(
                expansionFactor: 5,
                dotHeight: 8,
                dotWidth: 8,
                dotColor: Colors.white,
                activeDotColor: CustomColor.red,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
