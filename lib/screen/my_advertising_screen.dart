import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/ad_gallery.dart';
import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/info_myad.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:aviz_project/widgets/buttomnavigationbar.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';

import '../DataFuture/advertising_save/model/advertising_save.dart';
import '../widgets/display_error.dart';

class MyAdvertisingScreen extends StatefulWidget {
  const MyAdvertisingScreen({super.key});

  @override
  State<MyAdvertisingScreen> createState() => _MyAdvertisingScreenState();
}

class _MyAdvertisingScreenState extends State<MyAdvertisingScreen> {
  TextEditingController controller = TextEditingController();
  List<bool> isDelete = [];
  bool delete = false;

  List<RegisterFutureAd> registerFutureList = [];
  @override
  void initState() {
    // BlocProvider.of<AddAdvertisingBloc>(context)
    //     .add(InitializedDisplayAdvertising());

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AddAdvertisingBloc, AddAdvertisingState>(
      builder: (context, state) {
        return SafeArea(
          child: Scaffold(
            appBar: AppBar(
              scrolledUnderElevation: 0,
              elevation: 0,
              automaticallyImplyLeading: false,
              flexibleSpace: Padding(
                padding: const EdgeInsets.symmetric(vertical: 14),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    textWidget(
                      'آگهی های من',
                      CustomColor.red,
                      16,
                      FontWeight.w500,
                    ),
                    Image.asset('images/icon_home_active.png'),
                  ],
                ),
              ),
            ),
            body: RefreshIndicator(
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
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                  if (state is DisplayInfoAdvertisingStateResponse) ...[
                    state.displayAdvertising.fold(
                      (error) => DisplayError(error: error),
                      (advertising) {
                        return state.displayAdvertisingFacilities.fold(
                          (error) => DisplayError(error: error),
                          (facilities) {
                            return state.displayImagesAdvertising.fold(
                              (error) => DisplayError(error: error),
                              (gallery) {
                                return state.displayAdvertisingSave.fold(
                                  (error) => DisplayError(error: error),
                                  (saveAd) => advertising.isNotEmpty
                                      ? ListMyAdvertising(
                                          advertising: advertising,
                                          advertisingGallery: gallery,
                                          advertisingFacilities: facilities,
                                          advertisingSave: saveAd,
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
                                                  bottomNavigationKey
                                                      .currentState
                                                      ?.setPage(1);
                                                },
                                                child: Container(
                                                  height: 40,
                                                  width: 100,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColor.red,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            4),
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
                                        ),
                                );
                              },
                            );
                          },
                        );
                      },
                    )
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 50,
                    ),
                  ),
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
    required this.advertisingGallery,
    required this.advertisingFacilities,
    required this.advertisingSave,
  });

  List<RegisterFutureAd> advertising;
  List<RegisterFutureAdGallery> advertisingGallery;
  List<AdvertisingFacilities> advertisingFacilities;
  List<AdvertisingSave> advertisingSave;

  @override
  State<ListMyAdvertising> createState() => _ListMyAdvertisingState();
}

class _ListMyAdvertisingState extends State<ListMyAdvertising> {
  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<AddAdvertisingBloc, AddAdvertisingState>(
        builder: (context, state) {
          return Column(
            children: [
              ListView.builder(
                shrinkWrap: true,
                physics: const NeverScrollableScrollPhysics(),
                itemCount: widget.advertising.length,
                itemBuilder: (context, index) {
                  var advertisingAd = widget.advertising.toList()[index];

                  var advertisingFacilities = widget.advertisingFacilities
                      .where((item) => item.id == advertisingAd.idFacilities)
                      .toList();

                  bool isSaved = widget.advertisingSave
                      .any((item) => item.idAd == advertisingAd.id);

                  return AdvertisingWidget(
                    advertising: advertisingAd,
                    advertisingImages: advertisingAd.images[0],
                    advertisingFacilities: advertisingFacilities[0],
                    screen: InformatioMyAdvertising(
                      isDelete: true,
                      advertisingHome: advertisingAd,
                      advertisingFacilities: advertisingFacilities[0],
                      advertisingSave: isSaved
                          ? widget.advertisingSave.firstWhere(
                              (item) => item.idAd == advertisingAd.id)
                          : null,
                    ),
                  );
                },
              ),
            ],
          );
        },
      ),
    );
  }
}
