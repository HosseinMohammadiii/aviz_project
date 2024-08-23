import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';

class MyAdvertisingScreen extends StatefulWidget {
  const MyAdvertisingScreen({super.key});

  @override
  State<MyAdvertisingScreen> createState() => _MyAdvertisingScreenState();
}

class _MyAdvertisingScreenState extends State<MyAdvertisingScreen> {
  TextEditingController controller = TextEditingController();

  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddAdvertisingBloc>(context)
        .add(InitializedDisplayAdvertising());
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
                slivers: [
                  if (state is AddAdvertisingLoading) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                  if (state is DisplayInfoAdvertisingStateResponse) ...[
                    SliverToBoxAdapter(
                      child: Visibility(
                          child: Row(
                        children: [
                          Icon(Icons.crop_square_rounded),
                          Text('انتخاب همه'),
                        ],
                      )),
                    ),
                    state.displayAdvertising.fold(
                      (error) {
                        return SliverToBoxAdapter(
                          child: Center(
                            child: textWidget(
                              error,
                              CustomColor.black,
                              16,
                              FontWeight.w500,
                            ),
                          ),
                        );
                      },
                      (advertising) {
                        return state.displayAdvertisingFacilities.fold(
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
                          (facilities) {
                            return state.displayImagesAdvertising.fold(
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
                              (gallery) {
                                return SliverList.builder(
                                  itemCount: advertising.length,
                                  itemBuilder: (context, index) {
                                    var advertisingAd =
                                        advertising.toList()[index];
                                    var advertisingImagesAd =
                                        gallery.toList()[index];
                                    var advertisingFacilities =
                                        facilities.toList()[index];

                                    return GestureDetector(
                                      onLongPress: () async {
                                        await Future.delayed(
                                          const Duration(milliseconds: 500),
                                          () {
                                            print('object');
                                          },
                                        );
                                      },
                                      child: AdvertisingWidget(
                                        advertising: advertisingAd,
                                        advertisingImages: advertisingImagesAd,
                                        advertisingFacilities:
                                            advertisingFacilities,
                                      ),
                                    );
                                  },
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
