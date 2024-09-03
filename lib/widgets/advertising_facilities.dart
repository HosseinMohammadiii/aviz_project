import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';

import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../class/colors.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class AdvertisingFacilitiesWidget extends StatefulWidget {
  AdvertisingFacilitiesWidget({
    super.key,
    required this.adFacilities,
  });
  List<AdvertisingFacilities> adFacilities;

  @override
  State<AdvertisingFacilitiesWidget> createState() =>
      _AdvertisingFacilitiesWidgetState();
}

class _AdvertisingFacilitiesWidgetState
    extends State<AdvertisingFacilitiesWidget> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdFeaturesBloc, AdFeaturesState>(
      builder: (context, state) {
        return SliverList.builder(
          itemCount: widget.adFacilities.length,
          itemBuilder: (context, index) => Column(
            children: [
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
                  (r) => showFacilitiesAdvertising(r[index]),
                )
              ],
            ],
          ),
        );
      },
    );
  }

  Widget showFacilitiesAdvertising(AdvertisingFacilities facilities) {
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
          if (facilities.parking == true) ...[
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
