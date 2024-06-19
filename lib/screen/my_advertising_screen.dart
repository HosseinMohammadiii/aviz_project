import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:dio/dio.dart';
import 'package:flutter/material.dart';

class MyAdvertisingScreen extends StatefulWidget {
  const MyAdvertisingScreen({super.key});

  @override
  State<MyAdvertisingScreen> createState() => _MyAdvertisingScreenState();
}

class _MyAdvertisingScreenState extends State<MyAdvertisingScreen> {
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
                onTap: () async {
                  // final Dio dio = Dio();

                  // var response = await dio.get(
                  //     'https://aviz.chbk.run/api/collections/home_screen/records');

                  // List<AdvertisingHome> dt = response.data['items']
                  //     .map<AdvertisingHome>(
                  //         (jsonObject) => AdvertisingHome.fromJson(jsonObject))
                  //     .toList();
                  // dt
                  //     .map(
                  //       (e) => print(e.images),
                  //     )
                  //     .toList();

                  // final Dio _dio = Dio();
                  // final response = await _dio.post(
                  //   'https://aviz.chbk.run/api/collections/home_screen/records',
                  //   data: {
                  //     'home_name': 'خانه در شهید کشوری',
                  //     'home_description': 'یک خانه 120 متری در شهرک شهید کشوری',
                  //     'home_price': 12345678910,
                  //     'is_hot': true,
                  //     'metr': 120,
                  //     'room': 2,
                  //     'floor': 2,
                  //     'year_build': 1320,
                  //   },
                  // );
                  // print(response.data);
                },
                child: Container(
                  width: 100,
                  height: 50,
                  color: Colors.amber,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}
