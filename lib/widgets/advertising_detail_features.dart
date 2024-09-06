import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_event.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/ad_details/Data/model/ad_detail.dart';
import '../DataFuture/home/Data/model/advertising.dart';
import '../class/colors.dart';
import 'display_ad_facilities.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
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
    BlocProvider.of<AdHomeFeaturesBloc>(context)
        .add(AdFeaturesGetInitializeData(widget.ad.id, widget.ad.idFacilities));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdHomeFeaturesBloc, AdFeaturesState>(
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
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
            if (state is AdDetailRequestSuccessState) ...[
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
                  return Container(
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
                        ListView.builder(
                          shrinkWrap: true,
                          physics: const NeverScrollableScrollPhysics(),
                          itemCount: document.length,
                          itemBuilder: (context, index) =>
                              advertisingDocumentWidget(document[index]),
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
                            return ListView.builder(
                              shrinkWrap: true,
                              physics: const NeverScrollableScrollPhysics(),
                              itemCount: direction.length,
                              itemBuilder: (context, index) =>
                                  advertisingFeatutersDirection(
                                      direction[index]),
                            );
                          },
                        ),
                      ],
                    ),
                  );
                },
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
            if (state is AdDetailLoadingState) ...[
              const Center(
                child: CircularProgressIndicator(),
              ),
            ],
            if (state is AdDetailRequestSuccessState) ...[
              state.advertisingFacilitiesList.fold(
                (error) => Center(
                  child: textWidget(
                    error,
                    CustomColor.black,
                    16,
                    FontWeight.w500,
                  ),
                ),
                (facilities) => ListView.builder(
                  shrinkWrap: true,
                  physics: const NeverScrollableScrollPhysics(),
                  itemCount: facilities.length,
                  itemBuilder: (context, index) =>
                      DisplayAdFacilities(facilities: facilities[index]),
                ),
              ),
            ],
          ],
        );
      },
    );
  }

  Widget advertisingFeatutersDirection(AdvertisingFeatures ad) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textWidget(
          ad.direction,
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
  }

  Widget advertisingDocumentWidget(AdvertisingFeatures ad) {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textWidget(
          ad.document,
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
  }
}
