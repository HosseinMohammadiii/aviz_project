import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_bloc.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_event.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_state.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_bloc.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_event.dart';

import 'package:aviz_project/class/colors.dart';

import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Data/model/ad_gallery.dart';
import '../DataFuture/add_advertising/Data/model/register_future_ad.dart';
import '../DataFuture/advertising_save/model/advertising_save.dart';
import '../widgets/cached_network_image.dart';
import '../widgets/container_search.dart';
import '../widgets/display_error.dart';
import '../widgets/price_widget.dart';
import 'info_myad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  get ui => null;

  FocusNode focusNode = FocusNode();

  final TextEditingController textEditingController = TextEditingController();
  @override
  void initState() {
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/aviz.png'),
            Image.asset('images/icon_home_active.png'),
          ],
        ),
      ),
      body: BlocBuilder<HomeBloc, HomeState>(
        builder: (context, state) {
          return SafeArea(
            child: RefreshIndicator(
              onRefresh: () async {
                context.read<HomeBloc>().add(HomeGetInitializeData());
              },
              child: CustomScrollView(
                slivers: [
                  SliverPadding(
                    padding: const EdgeInsets.symmetric(
                        horizontal: 15, vertical: 10),
                    sliver: SliverToBoxAdapter(
                      child: GestureDetector(
                        onTap: () {
                          Navigator.push(
                              context,
                              MaterialPageRoute(
                                builder: (context) => ContainerSearch(
                                  textEditingController: textEditingController,
                                  focusNode: focusNode,
                                ),
                              ));
                        },
                        child: Container(
                          alignment: Alignment.centerRight,
                          margin: const EdgeInsets.only(bottom: 18),
                          padding: const EdgeInsets.symmetric(horizontal: 8),
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                            border: Border.all(
                              color: CustomColor.grey350,
                            ),
                          ),
                          child: Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              Text(
                                textDirection: TextDirection.rtl,
                                'جستوجو...',
                                style: TextStyle(
                                  fontFamily: 'SN',
                                  fontSize: 16,
                                  fontWeight: FontWeight.w400,
                                  color: CustomColor.grey500,
                                ),
                              ),
                              const SizedBox(
                                width: 8,
                              ),
                              Image.asset('images/search-normal.png'),
                            ],
                          ),
                        ),
                      ),
                    ),
                  ),
                  if (state is HomeLoadingState) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                  // SliverPadding(
                  //   padding: const EdgeInsets.symmetric(horizontal: 15),
                  //   sliver: SliverToBoxAdapter(
                  //     child: Column(
                  //       children: [
                  //         Row(
                  //           mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //           children: [
                  //             Text(
                  //               'مشاهده همه',
                  //               style: Theme.of(context).textTheme.titleMedium,
                  //             ),
                  //             const Spacer(),
                  //             Text(
                  //               'آویز های داغ',
                  //               style: Theme.of(context).textTheme.titleLarge,
                  //             ),
                  //           ],
                  //         ),
                  //         const SizedBox(height: 10),
                  //       ],
                  //     ),
                  //   ),
                  // ),
                  // if (state is HomeRequestSuccessState) ...[
                  //   state.hotAdvertising.fold(
                  //     (error) => DisplayError(error: error),
                  //     (hotAdvertising) {
                  //       return state.advertisingGalleryDetails.fold(
                  //         (l) => SliverToBoxAdapter(
                  //           child: Center(
                  //             child: textWidget(
                  //               l,
                  //               CustomColor.black,
                  //               16,
                  //               FontWeight.w500,
                  //             ),
                  //           ),
                  //         ),
                  //         (gallery) {
                  //           return state.advertisingFacilities.fold(
                  //             (error) => DisplayError(error: error),
                  //             (facilities) => state.advertisingSave.fold(
                  //               (error) => DisplayError(error: error),
                  //               (saveAd) => hotestAdvertisingBox(
                  //                 adHome: hotAdvertising,
                  //                 advertisingGallery: gallery,
                  //                 adFacilities: facilities,
                  //                 advertisingSave: saveAd,
                  //               ),
                  //             ),
                  //           );
                  //         },
                  //       );
                  //     },
                  //   ),
                  // ],
                  // const SliverToBoxAdapter(
                  //   child: SizedBox(
                  //     height: 20,
                  //   ),
                  // ),
                  // SliverToBoxAdapter(
                  //   child: Row(
                  //     mainAxisAlignment: MainAxisAlignment.spaceAround,
                  //     children: [
                  //       Text(
                  //         'مشاهده همه',
                  //         style: Theme.of(context).textTheme.titleMedium,
                  //       ),
                  //       const SizedBox(
                  //         width: 130,
                  //       ),
                  //       Text(
                  //         'آویز های اخیر',
                  //         style: Theme.of(context).textTheme.titleLarge,
                  //       ),
                  //     ],
                  //   ),
                  // ),
                  if (state is HomeRequestSuccessState) ...[
                    state.getAdvertising.fold(
                      (error) => DisplayError(error: error),
                      (ad) => state.advertisingFacilities.fold(
                        (error) => DisplayError(error: error),
                        (facilities) => state.advertisingSave.fold(
                          (error) => SliverToBoxAdapter(
                            child: Center(
                              child: textWidget(
                                error,
                                CustomColor.black,
                                16,
                                FontWeight.w500,
                              ),
                            ),
                          ),
                          (saveAd) => recentlyAdvertisingBox(
                            adHome: ad,
                            adFacilities: facilities,
                            advertisingSave: saveAd,
                          ),
                        ),
                      ),
                    ),
                  ],
                ],
              ),
            ),
          );
        },
      ),
    );
  }

//Widget For display recently Advertising
  Widget recentlyAdvertisingBox({
    required List<RegisterFutureAd> adHome,
    required List<AdvertisingFacilities> adFacilities,
    required List<AdvertisingSave> advertisingSave,
  }) {
    return SliverList.builder(
      itemCount: adHome.length,
      itemBuilder: (context, index) {
        bool isSaved =
            advertisingSave.any((item) => item.idAd == adHome[index].id);

        return GestureDetector(
          onTap: () {
            BlocProvider.of<RecentBloc>(context)
                .add(PostRecentEvent(adHome[index].id));
            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformatioMyAdvertising(
                  advertisingHome: adHome[index],
                  isDelete: false,
                  advertisingSave: isSaved
                      ? advertisingSave
                          .firstWhere((item) => item.idAd == adHome[index].id)
                      : null,
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
            child: Row(
              crossAxisAlignment: CrossAxisAlignment.center,
              children: [
                SizedBox(
                  width: 111,
                  child: CachedNetworkImageWidget(
                    imgUrl: adHome[index].images.isNotEmpty
                        ? adHome[index].images[0]
                        : '',
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
                        adHome[index].titlehome,
                        CustomColor.black,
                        14,
                        FontWeight.w700,
                      ),
                      textWidget(
                        adHome[index].description,
                        CustomColor.black,
                        12,
                        FontWeight.w400,
                      ),
                      const SizedBox(
                        height: 10,
                      ),
                      PriceWidget(
                          context: context, adPrice: adHome[index].homeprice),
                    ],
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }

//Widget For display hotest Advertising
  Widget hotestAdvertisingBox({
    required List<RegisterFutureAd> adHome,
    required List<AdvertisingFacilities> adFacilities,
    required List<RegisterFutureAdGallery> advertisingGallery,
    required List<AdvertisingSave> advertisingSave,
  }) {
    return SliverToBoxAdapter(
      child: SizedBox(
        height: 250,
        child: ListView.builder(
          scrollDirection: Axis.horizontal,
          reverse: true,
          padding: const EdgeInsets.only(right: 16),
          itemCount: adHome.length,
          itemBuilder: (context, index) {
            bool isSaved =
                advertisingSave.any((item) => item.idAd == adHome[index].id);

            return GestureDetector(
              onTap: () {
                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformatioMyAdvertising(
                      isDelete: false,
                      advertisingHome: adHome[index],
                      advertisingSave: isSaved
                          ? advertisingSave.firstWhere(
                              (item) => item.idAd == adHome[index].id)
                          : null,
                    ),
                  ),
                );
              },
              child: Container(
                width: 210,
                height: 240,
                padding: const EdgeInsets.all(16),
                margin: const EdgeInsets.only(left: 15),
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
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.end,
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    CachedNetworkImageWidget(
                      imgUrl: adHome[index].images[0],
                    ),
                    Text(
                      adHome[index].titlehome,
                      style: Theme.of(context).textTheme.bodyLarge,
                    ),
                    Text(
                      adHome[index].description,
                      style: Theme.of(context).textTheme.bodyMedium,
                    ),
                    PriceWidget(
                        context: context, adPrice: adHome[index].homeprice),
                  ],
                ),
              ),
            );
          },
        ),
      ),
    );
  }
}
