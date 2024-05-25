import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

import '../DataFuture/home/Data/model/advertising.dart';

class cachedNetworkImage extends StatelessWidget {
  cachedNetworkImage({
    super.key,
    required this.advertisingHome,
  });
  final AdvertisingHome advertisingHome;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 110,
      width: double.infinity,
      fit: BoxFit.cover,
      imageUrl: advertisingHome.images,
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
    );
  }
}
