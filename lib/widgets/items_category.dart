import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/bloc_page_number/page_n_bloc.dart';
import '../class/colors.dart';
import 'text_widget.dart';

class ItemSelectCategory extends StatefulWidget {
  const ItemSelectCategory({
    super.key,
    required this.title,
  });

  final String title;
  @override
  State<ItemSelectCategory> createState() => _ItemSelectCategoryState();
}

class _ItemSelectCategoryState extends State<ItemSelectCategory> {
  @override
  Widget build(BuildContext context) {
    List<String> txtRent = [
      '${widget.title} آپارتمان',
      '${widget.title} خانه',
      '${widget.title} ویلا',
    ];
    List<String> txtBuy = [
      '${widget.title} آپارتمان',
      '${widget.title} خانه',
      '${widget.title} ویلا',
      '${widget.title} زمین',
    ];
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: widget.title == 'فروش' ? txtBuy.length : txtRent.length,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                if (widget.title == 'فروش') {
                  BlocProvider.of<NavigationPage>(context)
                      .getNavItems(ViewPage.registerDetialsBuyHomeAdvertising);
                  if (index == 0) {
                    BlocProvider.of<StatusModeBloc>(context)
                        .getStatusMode(StatusMode.apartment);
                  } else if (index == 1) {
                    BlocProvider.of<StatusModeBloc>(context)
                        .getStatusMode(StatusMode.home);
                  } else if (index == 2) {
                    BlocProvider.of<StatusModeBloc>(context)
                        .getStatusMode(StatusMode.villa);
                  } else {
                    BlocProvider.of<StatusModeBloc>(context)
                        .getStatusMode(StatusMode.buyLand);
                  }
                } else {
                  BlocProvider.of<NavigationPage>(context)
                      .getNavItems(ViewPage.registerDetialsRentHomeAdvertising);
                  if (index == 0) {
                    BlocProvider.of<StatusModeBloc>(context)
                        .getStatusMode(StatusMode.apartment);
                  } else if (index == 1) {
                    BlocProvider.of<StatusModeBloc>(context)
                        .getStatusMode(StatusMode.home);
                  } else {
                    BlocProvider.of<StatusModeBloc>(context)
                        .getStatusMode(StatusMode.villa);
                  }
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
                      widget.title == 'فروش' ? txtBuy[index] : txtRent[index],
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
    );
  }
}
