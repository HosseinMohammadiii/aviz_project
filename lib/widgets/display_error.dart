import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_bloc.dart';
import 'package:aviz_project/DataFuture/province/Bloc/province_bloc.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_bloc.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_bloc.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_event.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import '../DataFuture/advertising_save/bloc/advertising_save_event.dart';

import '../DataFuture/province/Bloc/province_event.dart';
import '../DataFuture/recent/bloc/recent_event.dart';
import '../DataFuture/search/Bloc/search_event.dart';
import '../class/colors.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class DisplayError extends StatelessWidget {
  DisplayError({
    super.key,
    required this.screen,
  });
  String screen;

  @override
  Widget build(BuildContext context) {
    return SliverFillRemaining(
      child: Column(
        mainAxisAlignment: MainAxisAlignment.center,
        children: [
          textWidget(
            'ارتباط برقرار نشد',
            CustomColor.black,
            18,
            FontWeight.w700,
          ),
          const SizedBox(
            height: 15,
          ),
          textWidget(
            'لطفا از وصل بودن اینترنت مطمئن شوید.',
            CustomColor.grey500,
            15,
            FontWeight.normal,
          ),
          const SizedBox(
            height: 15,
          ),
          ElevatedButton(
            style: const ButtonStyle(
              elevation: WidgetStatePropertyAll(0),
              fixedSize: WidgetStatePropertyAll(
                Size(150, 45),
              ),
              backgroundColor: WidgetStatePropertyAll(
                CustomColor.red,
              ),
            ),
            onPressed: () {
              switch (screen) {
                case 'آگهی های من':
                  print('آگهی های من');
                  context
                      .read<AddAdvertisingBloc>()
                      .add(InitializedDisplayAdvertising());
                  break;
                case 'بازدید های اخیر':
                  print('بازدید های اخیر');
                  context.read<RecentBloc>().add(GetInitializedDataEvent());
                  break;
                case 'ذخیره شده ها':
                  print('ذخیره شده ها');
                  context.read<SaveAdBloc>().add(GetInitializedSaveDataEvent());
                  break;
                case 'شهر ها و استانها':
                  print('شهر ها و استانها');
                  context.read<ProvinceBloc>().add(ProvinceInitializedData());
                  break;
                case 'جستوجو':
                  print('جستوجو');
                  context
                      .read<SearchBloc>()
                      .add(SearchWithQueryData(query: ''));
                  break;
                case 'حساب کاربری':
                  print('حساب کاربری');
                  context
                      .read<AuthAccountBloc>()
                      .add(DisplayInformationEvent());
                  break;
                default:
              }
            },
            child: Text(
              'تلاش دوباره',
              style: TextStyle(
                color: CustomColor.white,
                fontWeight: FontWeight.w800,
                fontSize: 18,
              ),
            ),
          ),
        ],
      ),
    );
  }
}
