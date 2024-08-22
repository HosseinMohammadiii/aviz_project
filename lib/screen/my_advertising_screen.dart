import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/ad_details/Data/model/ad_facilities.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';

class MyAdvertisingScreen extends StatefulWidget {
  const MyAdvertisingScreen({super.key});

  @override
  State<MyAdvertisingScreen> createState() => _MyAdvertisingScreenState();
}

class _MyAdvertisingScreenState extends State<MyAdvertisingScreen> {
  TextEditingController controller = TextEditingController();

  @override
  Widget build(BuildContext context) {
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
        body: CustomScrollView(
          slivers: [
            SliverList.builder(
              itemCount: advertisingDataBox.length,
              itemBuilder: (context, index) {
                var advertisingData = advertisingDataBox.toList()[index];
                var advertising = advertisingBox.toList()[index];

                return AdvertisingWidget(
                  advertisingData: advertisingData,
                  advertising: advertising,
                );
              },
            ),
            SliverToBoxAdapter(
              child: GestureDetector(
                onTap: () {
                  final stateAd = context.read<RegisterInfoAdCubit>().state;
                  final boolState = context.read<BoolStateCubit>().state;

                  BlocProvider.of<AddAdvertisingBloc>(context).add(
                    AddInfoAdvertising(
                      stateAd.idCt,
                      stateAd.address,
                      stateAd.metr!.toInt(),
                      stateAd.countRoom!.toInt(),
                      stateAd.floor!.toInt(),
                      stateAd.yearBuild!.toInt(),
                    ),
                  );
                  BlocProvider.of<AddAdvertisingBloc>(context).add(
                    AddFacilitiesAdvertising(
                      boolState.elevator,
                      boolState.parking,
                      boolState.storeroom,
                      boolState.balcony,
                      boolState.penthouse,
                      boolState.duplex,
                      boolState.water,
                      boolState.electricity,
                      boolState.gas,
                      boolState.floorMaterial,
                      boolState.wc,
                    ),
                  );
                  context.read<BoolStateCubit>().reset();
                },
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.amber,
                ),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
