import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_event.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../class/colors.dart';
import 'text_widget.dart';

class AdvertisingGalleryImages extends StatefulWidget {
  const AdvertisingGalleryImages({
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
  void initState() {
    BlocProvider.of<AdImagesHomeBloc>(context)
        .add(AdGalleryImagesDataEvent(widget.advertisingHome.idGallery));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdImagesHomeBloc, AdImagesState>(
      builder: (context, state) {
        return Column(
          children: [
            if (state is AdGalleryImagesDataState) ...[
              state.displayImagesAdvertising.fold(
                (error) => Center(
                  child: textWidget(
                    error,
                    CustomColor.black,
                    16,
                    FontWeight.w500,
                  ),
                ),
                (r) {
                  // Combine all images into a single list from all items
                  List<String> allImages =
                      r.expand((item) => item.images).toList();

                  return SizedBox(
                    height: 160,
                    width: double.infinity,
                    child: PageView.builder(
                      itemCount: allImages.length,
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
                                GestureDetector(
                                  onTap: () {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          contentPadding: EdgeInsets.zero,
                                          content: ClipRRect(
                                            borderRadius:
                                                BorderRadius.circular(8),
                                            child: InteractiveViewer(
                                              child: CachedNetworkImage(
                                                fit: BoxFit.cover,
                                                imageUrl: allImages[index],
                                                errorWidget:
                                                    (context, url, error) =>
                                                        const Center(
                                                  child:
                                                      CircularProgressIndicator(),
                                                ),
                                                placeholder: (context, url) =>
                                                    Center(
                                                  child: Shimmer.fromColors(
                                                    baseColor:
                                                        const Color(0xffE1E1E1),
                                                    highlightColor:
                                                        const Color(0xffF3F3F2),
                                                    child: Container(
                                                      color: Colors.blue,
                                                    ),
                                                  ),
                                                ),
                                              ),
                                            ),
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  child: CachedNetworkImage(
                                    height: 110,
                                    width: double.infinity,
                                    fit: BoxFit.cover,
                                    imageUrl: allImages[index],
                                    errorWidget: (context, url, error) =>
                                        const Center(
                                      child: CircularProgressIndicator(),
                                    ),
                                    placeholder: (context, url) => Center(
                                      child: Shimmer.fromColors(
                                        baseColor: const Color(0xffE1E1E1),
                                        highlightColor: const Color(0xffF3F3F2),
                                        child: const SizedBox(),
                                      ),
                                    ),
                                  ),
                                ),
                                Positioned(
                                  bottom: 12,
                                  child: SmoothPageIndicator(
                                    controller: widget.controller,
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
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  );
                },
              ),
            ],
          ],
        );
      },
    );
  }
}
