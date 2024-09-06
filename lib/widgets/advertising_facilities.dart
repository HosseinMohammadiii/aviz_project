import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';
import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../class/colors.dart';
import 'display_ad_facilities.dart';
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
    return BlocBuilder<AdHomeFeaturesBloc, AdFeaturesState>(
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
                  (r) => DisplayAdFacilities(facilities: r[index]),
                )
              ],
            ],
          ),
        );
      },
    );
  }
}
