import 'package:aviz_project/DataFuture/home/Bloc/home_bloc.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_event.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_state.dart';
import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/information_recentlyAdvertising.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  FocusNode focusNode = FocusNode();

  get ui => null;
  @override
  void initState() {
    super.initState();
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitializeData());
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
            child: CustomScrollView(
              slivers: [
                SliverPadding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Container(
                          margin: const EdgeInsets.only(bottom: 18),
                          height: 45,
                          decoration: BoxDecoration(
                            borderRadius: BorderRadius.circular(4),
                          ),
                          child: TextField(
                            keyboardType: TextInputType.text,
                            textAlign: TextAlign.end,
                            textInputAction: TextInputAction.search,
                            textDirection: ui?.TextDirection.ltr,
                            textAlignVertical: TextAlignVertical.center,
                            focusNode: focusNode,
                            style: TextStyle(
                              fontFamily: 'SN',
                              fontSize: 18,
                              color: CustomColor.grey500,
                            ),
                            decoration: InputDecoration(
                              suffixIcon:
                                  Image.asset('images/search-normal.png'),
                              enabledBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomColor.grey350,
                                ),
                              ),
                              focusedBorder: OutlineInputBorder(
                                borderSide: BorderSide(
                                  color: CustomColor.grey350,
                                ),
                              ),
                              hintText: '...جستوجو',
                              hintStyle: TextStyle(
                                fontFamily: 'SN',
                                fontSize: 16,
                                fontWeight: FontWeight.w400,
                                color: CustomColor.grey500,
                              ),
                            ),
                            onTapOutside: (event) {
                              focusNode.unfocus();
                            },
                          ),
                        ),
                      ],
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
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  sliver: SliverToBoxAdapter(
                    child: Column(
                      children: [
                        Row(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            textWidget(
                              'مشاهده همه',
                              CustomColor.grey400,
                              14,
                              FontWeight.w400,
                            ),
                            const Spacer(),
                            textWidget(
                              'آویز های داغ',
                              CustomColor.black,
                              16,
                              FontWeight.w700,
                            ),
                          ],
                        ),
                        const SizedBox(height: 10),
                      ],
                    ),
                  ),
                ),
                if (state is HomeRequestSuccessState) ...[
                  state.hotAdvertising.fold(
                    (l) => SliverToBoxAdapter(
                      child: Center(
                        child: textWidget(
                          l,
                          CustomColor.black,
                          16,
                          FontWeight.w500,
                        ),
                      ),
                    ),
                    (r) {
                      return SliverToBoxAdapter(
                        child: hotestAdvertisingBox(adHome: r),
                      );
                    },
                  )
                ],
                const SliverToBoxAdapter(
                  child: SizedBox(
                    height: 20,
                  ),
                ),
                SliverToBoxAdapter(
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceAround,
                    children: [
                      textWidget(
                        'مشاهده همه',
                        CustomColor.grey400,
                        14,
                        FontWeight.w400,
                      ),
                      const SizedBox(
                        width: 130,
                      ),
                      textWidget(
                        'آویز های اخیر',
                        CustomColor.black,
                        16,
                        FontWeight.w700,
                      ),
                    ],
                  ),
                ),
                SliverList.builder(
                  itemCount: 5,
                  itemBuilder: (context, index) {
                    return recentlyAdvertisingBox();
                  },
                ),
              ],
            ),
          );
        },
      ),
    );
  }

//Widget For display recently Advertising
  Widget recentlyAdvertisingBox() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
            context,
            MaterialPageRoute(
              builder: (context) => const InformationRecentlyAdvertising(),
            ));
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
              child: Image.asset(
                'images/Image_home2.png',
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
                    'واحد دوبلکس فول امکانات',
                    CustomColor.black,
                    14,
                    FontWeight.w700,
                  ),
                  textWidget(
                    'سال ساخت ۱۳۹۸، سند تک برگ، دوبلکس تجهیزات کامل',
                    CustomColor.black,
                    12,
                    FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  // priceText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget For display hotest Advertising
  Widget hotestAdvertisingBox({
    required List<AdvertisingHome> adHome,
  }) {
    return SizedBox(
      height: 250,
      child: ListView.builder(
        scrollDirection: Axis.horizontal,
        reverse: true,
        padding: const EdgeInsets.only(right: 16),
        itemCount: adHome.length,
        itemBuilder: (context, index) {
          return Container(
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
                // SizedBox(
                //   height: 50,
                //   width: 60,
                //   child: ListView.builder(
                //     itemCount: adHome[index].images.length,
                //     itemBuilder: (context, indexx) {
                //       return CachedNetworkImage(
                //         height: 110,
                //         fit: BoxFit.cover,
                //         imageUrl: adHome[indexx].images[indexx = 0],
                //       );
                //     },
                //   ),
                // ),
                CachedNetworkImage(
                  height: 110,
                  width: double.infinity,
                  fit: BoxFit.cover,
                  imageUrl: adHome[index].images,
                ),
                //Image.asset('images/Image_home.png'),
                textWidget(
                  adHome[index].title,
                  CustomColor.black,
                  14,
                  FontWeight.w700,
                ),
                textWidget(
                  adHome[index].description,
                  CustomColor.grey500,
                  12,
                  FontWeight.w400,
                ),
                priceText(price: adHome[index].price),
              ],
            ),
          );
        },
      ),
    );
  }

//Widget For display Price Advertising
  Row priceText({
    required int price,
  }) {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'fa-IR', symbol: '');
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 91,
          height: 26,
          margin: const EdgeInsets.only(bottom: 10),
          padding: const EdgeInsets.symmetric(horizontal: 5),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: CustomColor.grey200,
          ),
          child: Text(
            currencyFormat.format(price),
            overflow: TextOverflow.ellipsis,
            style: const TextStyle(
              color: CustomColor.red,
              fontSize: 12,
              decoration: TextDecoration.none,
              fontFamily: 'SN',
              fontWeight: FontWeight.w500,
            ),
          ),
        ),
        textWidget(
          'قیمت:',
          CustomColor.black,
          12,
          FontWeight.w500,
        )
      ],
    );
  }
}
