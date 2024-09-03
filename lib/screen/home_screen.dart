import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_bloc.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_event.dart';
import 'package:aviz_project/DataFuture/home/Bloc/home_state.dart';
import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';

import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/information_recentlyAdvertising.dart';

import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../Hive/UsersLogin/user_login.dart';
import '../widgets/cached_network_image.dart';
import '../widgets/container_search.dart';
import '../widgets/price_widget.dart';

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
    BlocProvider.of<HomeBloc>(context).add(HomeGetInitializeData());
    super.initState();
  }

  Future<String> loadToken() async {
    final Box<UserLogin> userLogin = Hive.box('user_login');
    // Wait for Hive to return the token
    return userLogin.get(1)?.token ?? '';
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
              child: FutureBuilder(
                future: loadToken(),
                builder: (context, snapshot) => CustomScrollView(
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
                                    textEditingController:
                                        textEditingController,
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
                    SliverPadding(
                      padding: const EdgeInsets.symmetric(horizontal: 15),
                      sliver: SliverToBoxAdapter(
                        child: Column(
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceAround,
                              children: [
                                Text(
                                  'مشاهده همه',
                                  style:
                                      Theme.of(context).textTheme.titleMedium,
                                ),
                                const Spacer(),
                                Text(
                                  'آویز های داغ',
                                  style: Theme.of(context).textTheme.titleLarge,
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
                        (hotAdvertising) {
                          return SliverToBoxAdapter(
                            child: hotestAdvertisingBox(adHome: hotAdvertising),
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
                          Text(
                            'مشاهده همه',
                            style: Theme.of(context).textTheme.titleMedium,
                          ),
                          const SizedBox(
                            width: 130,
                          ),
                          Text(
                            'آویز های اخیر',
                            style: Theme.of(context).textTheme.titleLarge,
                          ),
                        ],
                      ),
                    ),
                    if (state is HomeRequestSuccessState) ...[
                      state.recentAdvertising.fold(
                        (l) {
                          return SliverToBoxAdapter(
                            child: Center(
                              child: textWidget(
                                l,
                                CustomColor.black,
                                16,
                                FontWeight.w500,
                              ),
                            ),
                          );
                        },
                        (recentAdvertising) {
                          return recentlyAdvertisingBox(
                              adHome: recentAdvertising);
                        },
                      ),
                    ],
                  ],
                ),
              ),
            ),
          );
        },
      ),
    );
  }

//Widget For display recently Advertising
  Widget recentlyAdvertisingBox({
    required List<AdvertisingHome> adHome,
  }) {
    return SliverList.builder(
      itemCount: adHome.length,
      itemBuilder: (context, index) {
        return GestureDetector(
          onTap: () {
            Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => InformationRecentlyAdvertising(
                    advertisingHome: adHome[index],
                  ),
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
                  child: CachedNetworkImageWidget(
                    imgUrl: adHome[index].images[0],
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
                        adHome[index].title,
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
                      PriceWidget(context: context, adHome: adHome[index]),
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
          return GestureDetector(
            onTap: () {
              Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => InformationRecentlyAdvertising(
                      advertisingHome: adHome[index],
                    ),
                  ));
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
                    adHome[index].title,
                    style: Theme.of(context).textTheme.bodyLarge,
                  ),
                  Text(
                    adHome[index].description,
                    style: Theme.of(context).textTheme.bodyMedium,
                  ),
                  PriceWidget(context: context, adHome: adHome[index]),
                ],
              ),
            ),
          );
        },
      ),
    );
  }
}
