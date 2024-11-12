import 'dart:io';

import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:dotted_border/dotted_border.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';

// ignore: must_be_immutable
class UploadImage extends StatefulWidget {
  UploadImage({
    super.key,
    required this.onChange,
    required this.addImage,
    required this.fileImage,
    required this.isLoading,
  });
  Function() onChange;
  Function() addImage;
  List<File>? fileImage;
  bool isLoading;

  @override
  State<UploadImage> createState() => _UploadImageState();
}

class _UploadImageState extends State<UploadImage> {
  PageController controller =
      PageController(viewportFraction: 0.9, initialPage: 0);
  @override
  Widget build(BuildContext context) {
    final stateAd = context.read<RegisterInfoAdCubit>().state;
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
            child: widget.isLoading
                ? Column(
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      const Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.normalRed,
                        ),
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      Text(
                        widget.fileImage!.length <= 1
                            ? '...در حال آپلود تصویر'
                            : '...در حال آپلود تصاویر',
                        style: const TextStyle(
                          fontSize: 14,
                          fontWeight: FontWeight.bold,
                        ),
                      )
                    ],
                  )
                : PageView.builder(
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
                                    barrierDismissible: false,
                                    context: context,
                                    builder: (context) {
                                      return Stack(
                                        children: [
                                          AlertDialog(
                                            contentPadding: EdgeInsets.zero,
                                            content: ClipRRect(
                                              borderRadius:
                                                  BorderRadius.circular(8),
                                              child: InteractiveViewer(
                                                child: Image.file(
                                                  widget.fileImage![index],
                                                  key: ValueKey(widget
                                                      .fileImage![index].path),
                                                  fit: BoxFit.fill,
                                                ),
                                              ),
                                            ),
                                          ),
                                          Positioned(
                                            top: 1,
                                            right: 1,
                                            child: IconButton(
                                              onPressed: () {
                                                Navigator.pop(context);
                                              },
                                              icon: Container(
                                                width: 32,
                                                height: 32,
                                                decoration: BoxDecoration(
                                                  borderRadius:
                                                      BorderRadius.circular(18),
                                                  color: CustomColor.grey500
                                                      .withOpacity(0.8),
                                                  border: Border.all(
                                                      width: 2,
                                                      color: CustomColor.pink),
                                                ),
                                                child: Icon(
                                                  Icons.close_rounded,
                                                  color: CustomColor.white,
                                                ),
                                              ),
                                              color: Colors.red,
                                            ),
                                          ),
                                        ],
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
                              Visibility(
                                visible: widget.fileImage!.length != 8,
                                child: Positioned(
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
                              ),
                              Positioned(
                                top: 10,
                                left: 12,
                                child: GestureDetector(
                                  onTap: () {
                                    setState(() {
                                      widget.fileImage!.removeAt(index);
                                      stateAd.images?.remove(index);
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
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '.شما می توانید حداکثر 8 و حداقل 1 تصویر انتخاب کنید',
                  style: TextStyle(
                    fontSize: 13,
                    // fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              const Padding(
                padding: EdgeInsets.symmetric(horizontal: 10),
                child: Text(
                  '.حجم هر تصویر باید کمتر از 1 مگابایت باشد',
                  style: TextStyle(
                    fontSize: 13,

                    //fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              Center(
                child: GestureDetector(
                  onTap: () => widget.onChange(),
                  child: Container(
                    width: 149,
                    height: 50,
                    margin: const EdgeInsets.symmetric(vertical: 20),
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
