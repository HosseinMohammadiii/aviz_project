import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/info_myad.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';

import '../widgets/buttomnavigationbar.dart';
import '../widgets/displayreconnection.dart';

class MyAdvertisingScreen extends StatefulWidget {
  const MyAdvertisingScreen({super.key});

  @override
  State<MyAdvertisingScreen> createState() => _MyAdvertisingScreenState();
}

class _MyAdvertisingScreenState extends State<MyAdvertisingScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAdvertisingBloc, AddAdvertisingState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            elevation: 0,
            automaticallyImplyLeading: false,
            centerTitle: true,
            title: textWidget(
              'آگهی های من',
              CustomColor.red,
              16,
              FontWeight.w500,
            ),
            actions: [
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Padding(
                  padding: EdgeInsets.symmetric(horizontal: 15),
                  child: Icon(
                    Icons.arrow_forward_ios_rounded,
                    size: 25,
                  ),
                ),
              ),
            ],
          ),
          body: SafeArea(
            child: RefreshIndicator(
              color: CustomColor.normalRed,
              onRefresh: () async {
                context
                    .read<AddAdvertisingBloc>()
                    .add(InitializedDisplayAdvertising());
              },
              child: CustomScrollView(
                shrinkWrap: true,
                slivers: [
                  if (state is AddAdvertisingLoading) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.normalRed,
                        ),
                      ),
                    ),
                  ],
                  if (state is DisplayInfoAdvertisingStateResponse) ...[
                    state.displayAdvertising.fold(
                      (error) => SliverFillRemaining(
                        child: DisplayReconnection(screen: 'آگهی های من'),
                      ),
                      (advertising) {
                        return state.displayAdvertisingFacilities.fold(
                          (error) => SliverFillRemaining(
                            child: DisplayReconnection(screen: 'آگهی های من'),
                          ),
                          (facilities) {
                            return advertising.isNotEmpty
                                ? ListMyAdvertising(
                                    advertising: advertising,
                                    advertisingFacilities: facilities,
                                  )
                                : SliverFillRemaining(
                                    child: Column(
                                      mainAxisAlignment:
                                          MainAxisAlignment.center,
                                      children: [
                                        textWidget(
                                          'اولین آگهیت رو بساز',
                                          CustomColor.grey500,
                                          18,
                                          FontWeight.w700,
                                        ),
                                        const SizedBox(
                                          height: 10,
                                        ),
                                        GestureDetector(
                                          onTap: () {
                                            Navigator.pushReplacement(
                                              context,
                                              MaterialPageRoute(
                                                builder: (context) =>
                                                    BottomNavigationScreen(
                                                  index: 1,
                                                ),
                                              ),
                                            );
                                          },
                                          child: Container(
                                            height: 40,
                                            width: 100,
                                            alignment: Alignment.center,
                                            decoration: BoxDecoration(
                                              color: CustomColor.red,
                                              borderRadius:
                                                  BorderRadius.circular(4),
                                              border: Border.all(
                                                color: CustomColor.red,
                                              ),
                                            ),
                                            child: textWidget(
                                              'ساخت آگهی',
                                              CustomColor.white,
                                              15,
                                              FontWeight.w700,
                                            ),
                                          ),
                                        ),
                                      ],
                                    ),
                                  );
                          },
                        );
                      },
                    ),
                  ],
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}

// ignore: must_be_immutable
class ListMyAdvertising extends StatefulWidget {
  ListMyAdvertising({
    super.key,
    required this.advertising,
    required this.advertisingFacilities,
  });

  List<RegisterFutureAd> advertising;
  List<AdvertisingFacilities> advertisingFacilities;

  @override
  State<ListMyAdvertising> createState() => _ListMyAdvertisingState();
}

class _ListMyAdvertisingState extends State<ListMyAdvertising> {
  @override
  Widget build(BuildContext context) {
    return SliverList.builder(
      itemCount: widget.advertising.length,
      itemBuilder: (context, index) {
        var advertisingAd = widget.advertising.toList()[index];

        var advertisingFacilities = widget.advertisingFacilities
            .where((item) => item.id == advertisingAd.idFacilities)
            .toList();

        return AdvertisingWidget(
          advertising: advertisingAd,
          advertisingImages: advertisingAd.images[0],
          advertisingFacilities: advertisingFacilities[0],
          screen: InformatioMyAdvertising(
            isDelete: true,
            advertisingHome: advertisingAd,
          ),
        );
      },
    );
  }
}
