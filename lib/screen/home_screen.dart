import 'package:aviz_project/DataFuture/ad_details/Data/model/ad_facilities.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_bloc.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_event.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_state.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_bloc.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_event.dart';
import 'package:aviz_project/Hive/Advertising/register_id.dart';

import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/city.dart';
import 'package:aviz_project/screen/province.dart';

import 'package:aviz_project/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:shimmer/shimmer.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Data/model/register_future_ad.dart';
import '../class/checkconnection.dart';
import '../widgets/container_search.dart';
import '../widgets/displayreconnection.dart';
import '../widgets/price_widget.dart';
import 'info_myad.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
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
          if (state is HomeLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColor.normalRed,
              ),
            );
          } else if (state is HomeRequestSuccessState) {
            return state.getAdvertising.fold(
              (error) {
                return DisplayReconnection(screen: 'آگهی ها');
              },
              (ad) {
                return state.advertisingFacilities.fold(
                  (error) => DisplayReconnection(screen: ''),
                  (facilities) => SafeArea(
                    child: RefreshIndicator(
                      color: CustomColor.normalRed,
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
                                onTap: () async {
                                  if (!await checkInternetConnection(context)) {
                                    return;
                                  }
                                  Navigator.push(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          const ContainerSearch(),
                                    ),
                                  );
                                },
                                child: Container(
                                  alignment: Alignment.centerRight,
                                  margin: const EdgeInsets.only(bottom: 18),
                                  padding:
                                      const EdgeInsets.symmetric(horizontal: 8),
                                  height: 45,
                                  decoration: BoxDecoration(
                                    borderRadius: BorderRadius.circular(4),
                                    border: Border.all(
                                      color: CustomColor.grey350,
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    children: [
                                      GestureDetector(
                                        onTap: () async {
                                          if (!await checkInternetConnection(
                                              context)) {
                                            return;
                                          }
                                          final provinceAndCity = context
                                              .read<RegisterInfoAdCubit>()
                                              .state;
                                          Navigator.push(
                                            context,
                                            MaterialPageRoute(
                                              builder: (context) =>
                                                  ScreenProvince(
                                                isCity: true,
                                                onChanged: () {},
                                                onChangedCity: () {
                                                  if (provinceAndCity
                                                          .province !=
                                                      '') {
                                                    Navigator.push(
                                                        context,
                                                        MaterialPageRoute(
                                                          builder: (context) =>
                                                              CityScreen(
                                                            onChanged: () {
                                                              RegisterId().setCity(
                                                                  provinceAndCity
                                                                      .city);
                                                              context
                                                                  .read<
                                                                      HomeBloc>()
                                                                  .add(
                                                                      HomeGetInitializeData());
                                                              provinceAndCity
                                                                  .city = '';
                                                              Navigator.pop(
                                                                  context);
                                                              Navigator.pop(
                                                                  context);
                                                            },
                                                            province: RegisterId()
                                                                .getProvince(),
                                                          ),
                                                        ));
                                                  }
                                                  RegisterId().setProvince(
                                                      provinceAndCity.province);
                                                  provinceAndCity.province = '';
                                                },
                                              ),
                                            ),
                                          );
                                        },
                                        child: Row(
                                          children: [
                                            Icon(
                                              Icons.location_on_outlined,
                                              color: CustomColor.grey500,
                                            ),
                                            Text(
                                              RegisterId().getCity().isNotEmpty
                                                  ? RegisterId().getCity()
                                                  : RegisterId().getProvince(),
                                              style: const TextStyle(
                                                fontFamily: 'SN',
                                                fontSize: 16,
                                                fontWeight: FontWeight.w400,
                                                color: CustomColor.black,
                                              ),
                                              textDirection: TextDirection.rtl,
                                              overflow: TextOverflow.ellipsis,
                                            ),
                                            const SizedBox(
                                              width: 3,
                                            ),
                                            Text(
                                              '|',
                                              style: TextStyle(
                                                fontFamily: 'SN',
                                                fontSize: 22,
                                                fontWeight: FontWeight.w400,
                                                color: CustomColor.grey500,
                                              ),
                                            ),
                                          ],
                                        ),
                                      ),
                                      const Spacer(),
                                      Text(
                                        textDirection: TextDirection.rtl,
                                        'جستوجو در آگهی ها',
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
                                      Image.asset(
                                        'images/search_icon.png',
                                        scale: 2.5,
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            ),
                          ),
                          recentlyAdvertisingBox(
                            adHome: ad,
                            adFacilities: facilities,
                          ),
                        ],
                      ),
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
    );
  }

  //Widget for Display Advertising Image
  Widget _displayAdvertisingImage({
    required final String imgUrl,
  }) {
    return ClipRRect(
      borderRadius: BorderRadius.circular(8),
      child: CachedNetworkImage(
        height: 110,
        width: double.infinity,
        fit: BoxFit.cover,
        imageUrl: imgUrl,
        errorWidget: (context, url, error) => const Center(
          child: CircularProgressIndicator(
            color: CustomColor.normalRed,
          ),
        ),
        placeholder: (context, url) => Center(
          child: Shimmer.fromColors(
            baseColor: const Color(0xffE1E1E1),
            highlightColor: const Color(0xffF3F3F2),
            child: Container(
              height: 110,
              width: double.infinity,
              color: CustomColor.grey350,
            ),
          ),
        ),
      ),
    );
  }

  Widget recentlyAdvertisingBox({
    required List<RegisterFutureAd> adHome,
    required List<AdvertisingFacilities> adFacilities,
  }) {
    return SliverList.builder(
      itemCount: adHome.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () async {
            if (!await checkInternetConnection(context)) {
              return;
            }
            BlocProvider.of<RecentBloc>(context)
                .add(PostRecentEvent(adHome[index].id));

            Navigator.push(
              context,
              MaterialPageRoute(
                builder: (context) => InformatioMyAdvertising(
                  advertisingHome: adHome[index],
                  isDelete: false,
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
              children: [
                SizedBox(
                  width: 111,
                  child: _displayAdvertisingImage(
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
                      PriceWidget(context: context, adPrice: adHome[index]),
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
}
