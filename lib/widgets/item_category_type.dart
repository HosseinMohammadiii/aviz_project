import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_event.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

class itemsCategoryType extends StatefulWidget {
  const itemsCategoryType({
    super.key,
  });

  @override
  State<itemsCategoryType> createState() => _itemsCategoryTypeState();
}

class _itemsCategoryTypeState extends State<itemsCategoryType> {
  @override
  Widget build(BuildContext context) {
    List txt1 = [
      'اجاره مسکونی',
      'فروش مسکونی',
      'فروش دفاتر اداری و تجاری',
      'اجاره دفاتر اداری و تجاری',
      'اجاره کوتاه مدت',
      'پروژه های ساخت و ساز',
    ];
    return SizedBox(
      height: MediaQuery.of(context).size.height / 1.3,
      child: ListView.builder(
        padding: const EdgeInsets.symmetric(horizontal: 15),
        itemCount: txt1.length,
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
    );
  }
}
