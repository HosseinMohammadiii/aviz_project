import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../class/colors.dart';

class AdvertisingGalleryImages extends StatefulWidget {
  AdvertisingGalleryImages({
    super.key,
    required this.advertisingHome,
    required this.controller,
  });
  final AdvertisingHome advertisingHome;
  final PageController controller;

  @override
  State<AdvertisingGalleryImages> createState() =>
      _AdvertisingGalleryImagesState();
}

class _AdvertisingGalleryImagesState extends State<AdvertisingGalleryImages> {
  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 160,
      width: double.infinity,
      child: PageView.builder(
        itemCount: widget.advertisingHome.images.length,
        controller: widget.controller,
        itemBuilder: (context, index) {
          return Padding(
            padding: const EdgeInsets.symmetric(horizontal: 5),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(8),
              child: Stack(
                fit: StackFit.expand,
                alignment: Alignment.bottomCenter,
                children: [
                  CachedNetworkImage(
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
                    imageUrl: widget.advertisingHome.images[index],
                    errorWidget: (context, url, error) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    placeholder: (context, url) => Center(
                      child: Shimmer.fromColors(
                        baseColor: const Color(0xffE1E1E1),
                        highlightColor: const Color(0xffF3F3F2),
                        child: Container(
                          height: 110,
                          width: double.infinity,
                          color: Colors.blue,
                        ),
                      ),
                    ),
                  ),
                  Positioned(
                    bottom: 12,
                    child: SmoothPageIndicator(
                      controller: widget.controller,
                      count: widget.advertisingHome.images.length,
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
              ),
            ),
          );
        },
      ),
    );
  }
}
