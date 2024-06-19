import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';

import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import '../class/colors.dart';
import 'text_widget.dart';

class itemsCategoryType extends StatefulWidget {
  const itemsCategoryType({
    super.key,
  });

  @override
  State<itemsCategoryType> createState() => _itemsCategoryTypeState();
}

class _itemsCategoryTypeState extends State<itemsCategoryType> {
  @override
  void initState() {
    super.initState();
    BlocProvider.of<AddAdvertisingBloc>(context)
        .add(AddAdvertisingGetInitializeData());
  }

  @override
  Widget build(BuildContext context) {
    List txt1 = [
      'اجاره مسکونی',
      'فروش مسکونی',
      'اجاره دفاتر اداری و تجاری',
      'فروش دفاتر اداری و تجاری',
    ];
    return BlocBuilder<AddAdvertisingBloc, AddAdvertisingState>(
      builder: (context, state) {
        return Column(
          children: [
            SizedBox(
              height: MediaQuery.of(context).size.height / 1.3,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                itemCount: txt1.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      if (index == 0) {
                        BlocProvider.of<NavigationPage>(context)
                            .getNavItems(ViewPage.itemsRentHome);
                      } else if (index == 1) {
                        BlocProvider.of<NavigationPage>(context)
                            .getNavItems(ViewPage.itemsBuyHome);
                      } else if (index == 2) {
                        //Should Changed viewpage***************************
                        BlocProvider.of<NavigationPage>(context)
                            .getNavItems(ViewPage.itemsRentBusinessPlace);
                      } else if (index == 3) {
                        //Should Changed viewpage***************************
                        BlocProvider.of<NavigationPage>(context)
                            .getNavItems(ViewPage.itemsBuyBusinessPlace);
                      }
                    },
                    child: Container(
                      height: 40,
                      margin: const EdgeInsets.symmetric(vertical: 8),
                      padding: const EdgeInsets.symmetric(horizontal: 8),
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        border: Border.all(color: CustomColor.grey350),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceBetween,
                        children: [
                          const Icon(
                            Icons.arrow_back_ios_rounded,
                            color: CustomColor.red,
                          ),
                          const Spacer(),
                          textWidget(
                            txt1[index],
                            CustomColor.black,
                            16,
                            FontWeight.w500,
                          ),
                          const SizedBox(
                            width: 10,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
            ),
          ],
        );
      },
    );
  }
}
