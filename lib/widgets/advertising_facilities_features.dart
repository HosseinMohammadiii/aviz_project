import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
import 'package:dotted_line/dotted_line.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/ad_details/Bloc/detail_ad_event.dart';
import '../DataFuture/ad_details/Data/model/ad_facilities.dart';
import '../DataFuture/add_advertising/Data/model/register_future_ad.dart';
import '../class/colors.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class AdvertisingFacilitiesWidget extends StatefulWidget {
  AdvertisingFacilitiesWidget({
    super.key,
    required this.advertisingHome,
  });
  RegisterFutureAd advertisingHome;

  @override
  State<AdvertisingFacilitiesWidget> createState() =>
      _AdvertisingFacilitiesWidgetState();
}

class _AdvertisingFacilitiesWidgetState
    extends State<AdvertisingFacilitiesWidget> {
  @override
  void initState() {
    BlocProvider.of<AdHomeFeaturesBloc>(context).add(
        AdFeaturesGetInitializeData(widget.advertisingHome.idFacilities,
            widget.advertisingHome.idFeatures));
    documentAndView();
    super.initState();
  }

  String document = '';
  String view = '';
  void documentAndView() {
    switch (widget.advertisingHome.idFeatures) {
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
      case 'ti012w7mmoyhmw2':
        document = 'ندارد';
        view = 'نامشخص';
        break;
      case 'gmxzv044ugckigz':
        document = 'ندارد';
        view = 'شمالی';
        break;
      case '65ym07y7mwlmy2a':
        document = 'ندارد';
        view = 'جنوبی';
        break;
      case '01zb7u52n31fi8m':
        document = 'ندارد';
        view = 'غربی';
        break;
      case '761f4u4nm3qpuzp':
        document = 'ندارد';
        view = 'شرقی';
        break;
      case 'gdhpz7funqv0rkf':
        document = 'وقفی';
        view = 'نامشخص';
        break;
      case 'oqha6d4la84cy8c':
        document = 'شش دانگ';
        view = 'نامشخص';
        break;
      case 'oj9ecj5tleyczx8':
        document = 'تک برگ';
        view = 'نامشخص';
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
                child: CircularProgressIndicator(
                  color: CustomColor.normalRed,
                ),
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
                Image.asset('images/clipboard.png'),
              ],
            ),
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
                      _displayAdFacilitiesItems(facilities: facilities[index]),
                ),
              )
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

//Widget for Display Facilities Advertising
  Widget _displayAdFacilitiesItems({
    required final AdvertisingFacilities facilities,
  }) {
    return Container(
      width: double.infinity,
      margin: const EdgeInsets.symmetric(vertical: 20),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey350),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        crossAxisAlignment: CrossAxisAlignment.end,
        children: [
          if (facilities.elevator) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'آسانسور',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            _dottedLineWidget(),
          ],
          if (facilities.parking) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'پارکینگ',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            _dottedLineWidget(),
          ],
          if (facilities.storeroom) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'انباری',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            _dottedLineWidget(),
          ],
          if (facilities.balcony) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'بالکن',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            _dottedLineWidget(),
          ],
          if (facilities.penthouse) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'پنت هاوس',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            _dottedLineWidget(),
          ],
          if (facilities.duplex) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'دوبلکس',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            _dottedLineWidget(),
          ],
          if (facilities.water) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'آب',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            facilities.electricity == true || facilities.gas == true
                ? _dottedLineWidget()
                : const Center(),
          ],
          if (facilities.electricity) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: GestureDetector(
                child: textWidget(
                  'برق',
                  CustomColor.grey500,
                  16,
                  FontWeight.w400,
                ),
              ),
            ),
            facilities.gas == true ? _dottedLineWidget() : const Center(),
          ],
          if (facilities.gas) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'گاز',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
          ],
          if (facilities.floormaterial.isNotEmpty) ...[
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'جنس کف: ${facilities.floormaterial}',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
            _dottedLineWidget(),
            Padding(
              padding: const EdgeInsets.symmetric(vertical: 15, horizontal: 15),
              child: textWidget(
                'سرویس بهداشتی: ${facilities.wc}',
                CustomColor.grey500,
                16,
                FontWeight.w400,
              ),
            ),
          ]
        ],
      ),
    );
  }

  //Widget For Display Dotted Line
  Padding _dottedLineWidget() {
    return Padding(
      padding: const EdgeInsets.only(left: 15, right: 15),
      child: DottedLine(
        dashColor: CustomColor.grey350,
        lineThickness: 1.5,
        dashLength: 6,
      ),
    );
  }
}
