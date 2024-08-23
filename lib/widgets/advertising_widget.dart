import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/items_information_advertising.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../DataFuture/ad_details/Data/model/ad_facilities.dart';
import '../DataFuture/add_advertising/Data/model/ad_gallery.dart';
import '../DataFuture/add_advertising/Data/model/register_future_ad.dart';
import '../screen/info_myad.dart';

// ignore: must_be_immutable
class AdvertisingWidget extends StatefulWidget {
  AdvertisingWidget({
    super.key,
    required this.advertising,
    required this.advertisingImages,
    required this.advertisingFacilities,
  });
  RegisterFutureAd advertising;
  RegisterFutureAdGallery advertisingImages;
  AdvertisingFacilities advertisingFacilities;
  @override
  State<AdvertisingWidget> createState() => _AdvertisingWidgetState();
}

class _AdvertisingWidgetState extends State<AdvertisingWidget> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'fa-IR', symbol: '');
  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        setState(() {
          ItemInformation(advertising: widget.advertising);
        });
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformatioMyAdvertising(
              advertisingHome: widget.advertising,
              registerFutureAdGallery: widget.advertisingImages,
              advertisingFacilities: widget.advertisingFacilities,
            ),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 6),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: CustomColor.white,
          boxShadow: const [
            BoxShadow(
              color: CustomColor.black,
              blurRadius: 40,
              spreadRadius: -35,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              height: 107,
              width: 111,
              child: ListView.builder(
                itemBuilder: (context, index) {
                  return CachedNetworkImage(
                    imageUrl: widget.advertisingImages.images[index = 0],
                    height: 110,
                    width: double.infinity,
                    fit: BoxFit.cover,
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
                },
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  textWidget(
                    widget.advertising.titlehome,
                    CustomColor.black,
                    14,
                    FontWeight.w700,
                  ),
                  textWidget(
                    widget.advertising.description,
                    CustomColor.black,
                    12,
                    FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  priceText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget For display Price Advertising
  Row priceText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          height: 26,
          width: 95,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 6),
          alignment: Alignment.centerLeft,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: CustomColor.grey200,
          ),
          child: Text(
            currencyFormat.format(widget.advertising.homeprice),
            overflow: TextOverflow.ellipsis,
            textAlign: TextAlign.left,
            style: const TextStyle(
              color: CustomColor.red,
              fontSize: 12,
              decoration: TextDecoration.none,
              fontFamily: 'SN',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        textWidget(
          'قیمت:',
          CustomColor.black,
          12,
          FontWeight.w500,
        ),
      ],
    );
  }
}
