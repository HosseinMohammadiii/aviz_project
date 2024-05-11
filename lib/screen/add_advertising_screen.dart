import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/screen/register_feature_screen.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/item_category_type.dart';
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
      body: BlocBuilder<PageNumberBloc, PageNumberState>(
        builder: (context, state) {
          switch (state.pageNumber) {
            case 1:
              return const itemsCategoryType();
            case 2:
              return ItemSelectCategory();
            case 3:
              return const RegisterFeatureScreen();
            case 4:
              return LocatioUpload();
            case 5:
              return const RegisterAdvertising();

            default:
              return const itemsCategoryType();
          }
        },
      ),
    );
  }
}
