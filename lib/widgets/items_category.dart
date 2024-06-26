import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_event.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/bloc_page_number/page_n_bloc.dart';
import '../class/colors.dart';
import 'text_widget.dart';

class ItemSelectCategory extends StatefulWidget {
  ItemSelectCategory({super.key});

  @override
  State<ItemSelectCategory> createState() => _ItemSelectCategoryState();
}

class _ItemSelectCategoryState extends State<ItemSelectCategory> {
  List txt2 = [
    'فروش آپارتمان',
    'فروش خانه و ویلا',
    'فروش زمین و کلنگی',
  ];
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: ListView.builder(
          itemCount: txt2.length,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) {
            return GestureDetector(
              onTap: () {
                BlocProvider.of<PageNumberBloc>(context).add(addPageNumber());
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
                      txt2[index],
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
