import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:shimmer/shimmer.dart';

class cachedNetworkImage extends StatelessWidget {
  const cachedNetworkImage({
    super.key,
    required this.imgUrl,
  });
  final String imgUrl;
  @override
  Widget build(BuildContext context) {
    return CachedNetworkImage(
      height: 110,
      width: double.infinity,
      fit: BoxFit.cover,
      imageUrl: imgUrl,
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
