import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_event.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/ad_details/Data/model/ad_detail.dart';
import '../DataFuture/home/Data/model/advertising.dart';
import '../class/colors.dart';
import 'advertising_facilities.dart';
import 'text_widget.dart';

class AdvertisindFeaturesWidget extends StatefulWidget {
  AdvertisindFeaturesWidget({
    super.key,
    required this.ad,
  });
  AdvertisingHome ad;

  @override
  State<AdvertisindFeaturesWidget> createState() =>
      _AdvertisindFeaturesWidgetState();
}

class _AdvertisindFeaturesWidgetState extends State<AdvertisindFeaturesWidget> {
  @override
  void initState() {
    BlocProvider.of<AdFeaturesBloc>(context)
        .add(AdFeaturesGetInitializeData(widget.ad.id));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdFeaturesBloc, AdFeaturesState>(
      builder: (context, state) {
        return Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                textWidget(
                  'ویژگی ها',
                  CustomColor.black,
                  16,
                  FontWeight.w700,
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset('images/clipboard.png'),
              ],
            ),
            if (state is AdDetailLoadingState) ...[
              const SizedBox(
                height: 112,
                child: Center(
                  child: CircularProgressIndicator(),
                ),
              ),
            ],
            if (state is AdDetailRequestSuccessState) ...[
              Container(
                height: 112,
                padding: const EdgeInsets.symmetric(horizontal: 15),
                margin: const EdgeInsets.symmetric(vertical: 20),
                decoration: BoxDecoration(
                  border: Border.all(color: CustomColor.grey350),
                  borderRadius: BorderRadius.circular(4),
                ),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    state.advertisingdetails.fold(
                      (error) {
                        return Center(
                          child: textWidget(
                            error,
                            CustomColor.black,
                            16,
                            FontWeight.w500,
                          ),
                        );
                      },
                      (document) {
                        return advertisingDocumentWidget(document);
                      },
                    ),
                    DottedLine(
                      dashColor: CustomColor.grey350,
                      lineThickness: 1.5,
                      dashLength: 6,
                    ),
                    state.advertisingdetails.fold(
                      (error) {
                        return Center(
                          child: textWidget(
                            error,
                            CustomColor.black,
                            16,
                            FontWeight.w500,
                          ),
                        );
                      },
                      (direction) {
                        return advertisingFeatutersDirection(direction);
                      },
                    ),
                  ],
                ),
              ),
            ],
            Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                textWidget(
                  'امکانات',
                  CustomColor.black,
                  16,
                  FontWeight.w700,
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset('images/magicpen.png'),
              ],
            ),
            // if (state is AdDetailRequestSuccessState) ...[
            //   state.advertisingFacilities.fold(
            //     (error) => Center(
            //       child: textWidget(
            //         error,
            //         CustomColor.black,
            //         16,
            //         FontWeight.w500,
            //       ),
            //     ),
            //     (facilities) => adTrueFacilities(facilities),
            //   ),
            // ],
            if (state is AdDetailRequestSuccessState) ...[
              state.advertisingFacilities.fold(
                (error) => Center(
                  child: textWidget(
                    error,
                    CustomColor.black,
                    16,
                    FontWeight.w500,
                  ),
                ),
                (facilities) => CustomScrollView(
                  physics: const NeverScrollableScrollPhysics(),
                  shrinkWrap: true, // Add this line
                  slivers: [
                    SliverList.builder(
                      itemCount: facilities.length,
                      itemBuilder: (context, index) {
                        return AdvertisingFacilitiesWidget(
                          adFacilities: facilities[index],
                        );
                      },
                    ),
                  ],
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget adTrueFacilities(List<AdvertisingFacilities> adFacilities) {
    return SliverList.builder(
      //physics: const NeverScrollableScrollPhysics(),
      itemCount: adFacilities.length,
      itemBuilder: (context, index) {
        return AdvertisingFacilitiesWidget(adFacilities: adFacilities[index]);
      },
    );
  }

  Widget advertisingFeatutersDirection(List<AdvertisingFeatures> ad) {
    return SizedBox(
      height: 25,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ad.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget(
                ad[index].direction,
                CustomColor.grey500,
                16,
                FontWeight.w700,
              ),
              textWidget(
                'جهت ساختمان',
                CustomColor.grey500,
                16,
                FontWeight.w700,
              ),
            ],
          );
        },
      ),
    );
  }

  Widget advertisingDocumentWidget(List<AdvertisingFeatures> ad) {
    return SizedBox(
      height: 20,
      child: ListView.builder(
        physics: const NeverScrollableScrollPhysics(),
        itemCount: ad.length,
        itemBuilder: (context, index) {
          return Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              textWidget(
                ad[index].document,
                CustomColor.grey500,
                16,
                FontWeight.w700,
              ),
              textWidget(
                'سند',
                CustomColor.grey500,
                16,
                FontWeight.w700,
              ),
            ],
          );
        },
      ),
    );
  }
}
