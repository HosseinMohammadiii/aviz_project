import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/advertising_widget.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

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
            BlocBuilder<AddAdvertisingBloc, AddAdvertisingState>(
              builder: (context, state) {
                return SliverToBoxAdapter(
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
                      BlocProvider.of<AddAdvertisingBloc>(context)
                          .add(AddInfoAdvertising(
                        '4m44z8mrvvmqmrb',
                        'location',
                        [],
                        'titlehome',
                        'description',
                        1200000000,
                      ));
                      if (state is AddInfoAdvertisingStateResponse) {
                        Text widgett = Text('');
                        state.registerInfoAdvertising.fold(
                          (l) {
                            widgett = Text(l);
                          },
                          (r) {
                            widgett = Text(r);
                          },
                        );
                        widgett;
                      }
                    },
                    child: Container(
                      width: 100,
                      height: 50,
                      color: Colors.amber,
                    ),
                  ),
                );
              },
            ),
            SliverToBoxAdapter(
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
