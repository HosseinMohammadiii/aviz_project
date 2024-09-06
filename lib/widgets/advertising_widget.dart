import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:shimmer/shimmer.dart';

import '../DataFuture/ad_details/Data/model/ad_facilities.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Data/model/register_future_ad.dart';
import '../screen/info_myad.dart';

// ignore: must_be_immutable
class AdvertisingWidget extends StatefulWidget {
  AdvertisingWidget({
    super.key,
    required this.advertising,
    required this.advertisingImages,
    required this.advertisingFacilities,
    this.isDelete,
  });
  RegisterFutureAd advertising;
  String advertisingImages;
  AdvertisingFacilities advertisingFacilities;
  bool? isDelete;
  @override
  State<AdvertisingWidget> createState() => _AdvertisingWidgetState();
}

class _AdvertisingWidgetState extends State<AdvertisingWidget> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'fa-IR', symbol: '');

  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => InformatioMyAdvertising(
              advertisingHome: widget.advertising,
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
              spreadRadius: -50,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Stack(
          children: [
            Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                ClipRRect(
                  borderRadius: BorderRadius.circular(8),
                  child: CachedNetworkImage(
                    imageUrl: widget.advertisingImages,
                    height: 107,
                    width: 107,
                    fit: BoxFit.cover,
                    errorWidget: (context, url, error) => const Center(
                      child: CircularProgressIndicator(),
                    ),
                    placeholder: (context, url) => Center(
                      child: Shimmer.fromColors(
                        baseColor: const Color(0xffE1E1E1),
                        highlightColor: const Color(0xffF3F3F2),
                        child: Container(
                          height: 107,
                          width: 107,
                          color: Colors.blue,
                        ),
                      ),
                    ),
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
            Positioned(
              bottom: 16,
              child: GestureDetector(
                onTap: () {
                  context.read<BoolStateCubit>().state.isDelete = false;
                },
                child: AnimatedSize(
                  duration: const Duration(milliseconds: 100),
                  curve: Curves.easeIn,
                  child: Container(
                    width: widget.isDelete! ? 25 : 0,
                    height: widget.isDelete! ? 25 : 0,
                    decoration: const BoxDecoration(
                      color: CustomColor.red,
                      borderRadius: BorderRadius.only(
                        topRight: Radius.circular(8),
                        bottomLeft: Radius.circular(8),
                      ),
                    ),
                    child: widget.isDelete!
                        ? Icon(
                            Icons.check_rounded,
                            color: CustomColor.white,
                          )
                        : null,
                  ),
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget For display Price Advertising
  Widget priceText() {
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

// ignore: must_be_immutable
class ItemInformation extends StatefulWidget {
  ItemInformation({
    super.key,
    required this.advertising,
  });
  RegisterFutureAd advertising;
  @override
  State<ItemInformation> createState() => _ItemInformationState();
}

class _ItemInformationState extends State<ItemInformation> {
  List listTextTitle = [
    'متراژ',
    'اتاق',
    'طبقه',
    'ساخت',
  ];
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 30),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: [
            informationBoxItem('ساخت', widget.advertising.yearBiuld),
            informationBoxItem('طبقه', widget.advertising.floor),
            informationBoxItem('اتاق', widget.advertising.countRoom),
            informationBoxItem('متراژ', widget.advertising.metr),
          ],
        ),
      ),
    );
  }

  Column informationBoxItem(
    String title,
    num advertising,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 14,
        ),
        textWidget(
          title,
          CustomColor.grey500,
          15,
          FontWeight.w400,
        ),
        Container(
          width: 40,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 12),
          child: SizedBox(
            height: 40,
            child: Text(
              advertising.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'SN',
                color: CustomColor.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}
