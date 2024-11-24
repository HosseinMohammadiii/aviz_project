import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/screen/register_feature_screen.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/item_category_type.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../widgets/items_category.dart';
import 'register_advertising_screen.dart';

class ManagementAddAdvertisingScreen extends StatefulWidget {
  const ManagementAddAdvertisingScreen({super.key});

  @override
  State<ManagementAddAdvertisingScreen> createState() =>
      _ManagementAddAdvertisingScreenState();
}

class _ManagementAddAdvertisingScreenState
    extends State<ManagementAddAdvertisingScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: double.maxFinite,
        leading: const AppBarWidget(),
      ),
      body: SafeArea(
        child: BlocBuilder<NavigationPage, NavigationState>(
          builder: (context, state) {
            switch (state.viewPage) {
              case ViewPage.category:
                return const ItemsCategoryType();

              case ViewPage.itemsRentHome:
                return const ItemSelectCategory(title: 'اجاره');

              case ViewPage.itemsBuyHome:
                return const ItemSelectCategory(title: 'فروش');

              case ViewPage.registerDetialsRentHomeAdvertising:
                return const RegisterHomeFeatureScreen(
                  title: 'اجاره',
                );

              case ViewPage.registerDetialsBuyHomeAdvertising:
                return const RegisterHomeFeatureScreen(
                  title: 'فروش',
                );

              case ViewPage.registerHomeAdvertising:
                return RegisterAdvertising(
                  title: 'فروش',
                );

              case ViewPage.registerRentHomeAdvertising:
                return RegisterAdvertising(title: 'اجاره');

              default:
                return const ItemsCategoryType();
            }
          },
        ),
        // child: Text('data'),
      ),
    );
  }
}
