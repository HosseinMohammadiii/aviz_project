import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_event.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Data/model/register_future_ad.dart';
import '../class/colors.dart';
import 'display_ad_facilities.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class AdvertisindFeaturesWidget extends StatefulWidget {
  AdvertisindFeaturesWidget({
    super.key,
    required this.ad,
  });
  RegisterFutureAd ad;

  @override
  State<AdvertisindFeaturesWidget> createState() =>
      _AdvertisindFeaturesWidgetState();
}

class _AdvertisindFeaturesWidgetState extends State<AdvertisindFeaturesWidget> {
  @override
  void initState() {
    BlocProvider.of<AdHomeFeaturesBloc>(context).add(
        AdFeaturesGetInitializeData(
            widget.ad.idFacilities, widget.ad.idFeatures));
    documentAndView();
    super.initState();
  }

  String document = '';
  String view = '';
  void documentAndView() {
    switch (widget.ad.idFeatures) {
      case '6prs9whayez5ndc':
        document = 'وقفی';
        view = 'شرقی';
        break;
      case 'y4nt0dvixr4xcna':
        document = 'شش دانگ';
        view = 'شرقی';
        break;
      case 'c756fp5htkh2gno':
        document = 'تک برگ';
        view = 'شرقی';
        break;
      case 'urmnw7g2c4zegf1':
        document = 'وقفی';
        view = 'غربی';
        break;
      case 'xw0low6fmir8sgo':
        document = 'شش دانگ';
        view = 'غربی';
        break;
      case 'mj34tvx7hhsm27u':
        document = 'تک برگ';
        view = 'غربی';
        break;
      case 'jvnz5pbmul5s6oi':
        document = 'وقفی';
        view = 'جنوبی';
        break;
      case 'adgv0zg79giyxni':
        document = 'شش دانگ';
        view = 'جنوبی';
        break;
      case 'v6ixmhzhqziudho':
        document = 'تک برگ';
        view = 'جنوبی';
        break;
      case 'io5oqwlgulcgehk':
        document = 'وقفی';
        view = 'شمالی';
        break;
      case 'hnrty8b2u4uu2zo':
        document = 'شش دانگ';
        view = 'شرقی';
        break;
      case 'nish48ruq5zsisv':
        document = 'تک برگ';
        view = 'شرقی';
        break;
    }
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
                              advertisingDocumentWidget(),
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
                                  advertisingFeatutersDirection(),
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

  Widget advertisingFeatutersDirection() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textWidget(
          view,
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

  Widget advertisingDocumentWidget() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        textWidget(
          document,
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
