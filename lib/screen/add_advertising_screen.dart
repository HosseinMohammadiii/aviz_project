import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/screen/register_feature_screen.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/item_category_type.dart';
import 'package:aviz_project/widgets/register_details_business.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/items_category.dart';
import 'locatin_upload_screen.dart';
import 'register_advertising_screen.dart';

class AddAdvertisingScreen extends StatefulWidget {
  const AddAdvertisingScreen({super.key});

  @override
  State<AddAdvertisingScreen> createState() => _AddAdvertisingScreenState();
}

class _AddAdvertisingScreenState extends State<AddAdvertisingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: double.maxFinite,
        leading: AppBarWidget(),
      ),
      body: BlocBuilder<NavigationPage, NavigationState>(
        builder: (context, state) {
          switch (state.viewPage) {
            case ViewPage.category:
              return const itemsCategoryType();

            case ViewPage.itemsRentHome:
              return ItemSelectCategory(title: 'اجاره');

            case ViewPage.itemsRentBusinessPlace:
              return RegisterDetailsBusiness(
                title: 'اجاره',
              );

            case ViewPage.itemsBuyHome:
              return ItemSelectCategory(title: 'فروش');

            case ViewPage.itemsBuyBusinessPlace:
              return RegisterDetailsBusiness(title: 'فروش');

            case ViewPage.registerDetialsRentHomeAdvertising:
              return RegisterHomeFeatureScreen(
                title: 'اجاره',
              );

            case ViewPage.registerDetialsBuyHomeAdvertising:
              return RegisterHomeFeatureScreen(
                title: 'فروش',
              );

            case ViewPage.registerHomeLocation:
              return LocatioUpload();

            case ViewPage.registerBusinessLocation:
              return RegisterDetailsBusiness(title: 'موقعیت مکانی');

            case ViewPage.registerHomeAdvertising:
            case ViewPage.registerBusinessAdvertising:
              return const RegisterAdvertising();

            default:
              return const itemsCategoryType();
          }
        },
      ),
    );
  }
}
