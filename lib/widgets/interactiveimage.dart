import 'dart:async';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../class/colors.dart';

class InterActiveImageWidget extends StatelessWidget {
  const InterActiveImageWidget({
    super.key,
    required this.allImages,
    required this.index,
  });
  final int index;
  final List<String> allImages;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        PageController controller2 = PageController(initialPage: index);

        Future<Size> getImageSize(String imageUrl) async {
          final Completer<Size> completer = Completer();
          final Image image = Image.network(imageUrl);

          image.image.resolve(const ImageConfiguration()).addListener(
            ImageStreamListener((ImageInfo info, bool _) {
              completer.complete(Size(
                info.image.width.toDouble(),
                info.image.height.toDouble(),
              ));
            }),
          );

          return completer.future;
        }

        showDialog(
          context: context,
          builder: (context) {
            return Dialog(
              child: ClipRRect(
                borderRadius: BorderRadius.circular(8),
                child: FutureBuilder<Size>(
                  future: getImageSize(allImages[index]),
                  builder: (context, snapshot) {
                    if (snapshot.connectionState == ConnectionState.waiting) {
                      return const Center(child: CircularProgressIndicator());
                    } else if (snapshot.hasError) {
                      return const Center(child: Text('خطا در بارگذاری تصویر'));
                    } else if (snapshot.hasData) {
                      final imageSize = snapshot.data!;
                      final dialogHeight =
                          (imageSize.height / imageSize.width) *
                              MediaQuery.of(context).size.width;

                      return SizedBox(
                        width: MediaQuery.of(context).size.width,
                        height: dialogHeight,
                        child: InteractiveViewer(
                          child: PageView.builder(
                            itemCount: allImages.length,
                            controller: controller2,
                            itemBuilder: (context, index) => Stack(
                              children: [
                                Positioned.fill(
                                  child: CachedNetworkImage(
                                    fit: BoxFit.fill,
                                    imageUrl: allImages[index],
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.red),
                                    ),
                                    placeholder: (context, url) => const Center(
                                      child: CircularProgressIndicator(
                                          color: Colors.grey),
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
                                        borderRadius: BorderRadius.circular(18),
                                        color: CustomColor.grey500
                                            .withOpacity(0.8),
                                        border: Border.all(
                                            width: 2, color: CustomColor.pink),
                                      ),
                                      child: Icon(
                                        Icons.close_rounded,
                                        color: CustomColor.white,
                                      ),
                                    ),
                                    color: Colors.red,
                                  ),
                                ),
                                Positioned(
                                  left: 0,
                                  right: 0,
                                  bottom: 4,
                                  child: Center(
                                    child: SmoothPageIndicator(
                                      controller: controller2,
                                      count: allImages.length,
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
                            ),
                          ),
                        ),
                      );
                    }
                    return const SizedBox();
                  },
                ),
              ),
            );
          },
        );
      },
      child: CachedNetworkImage(
        height: 110,
        width: double.infinity,
        fit: BoxFit.fill,
        imageUrl: allImages[index],
        errorWidget: (context, url, error) => const Center(
          child: CircularProgressIndicator(
            color: CustomColor.normalRed,
          ),
        ),
        placeholder: (context, url) => Center(
          child: Shimmer.fromColors(
            baseColor: const Color(0xffE1E1E1),
            highlightColor: const Color(0xffF3F3F2),
            child: const SizedBox(),
          ),
        ),
      ),
    );
  }
}
