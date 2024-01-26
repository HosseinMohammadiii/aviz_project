import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/register_feature_screen.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class itemsCategoryType extends StatelessWidget {
  itemsCategoryType({
    super.key,
    required this.txt,
    required this.color,
  });

  final String txt;
  Color color;

  @override
  Widget build(BuildContext context) {
    return Container(
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
          Icon(
            Icons.arrow_back_ios_rounded,
            color: color,
          ),
          const Spacer(),
          textWidget(
            txt,
            CustomColor.black,
            16,
            FontWeight.w500,
          ),
          const SizedBox(
            width: 10,
          ),
        ],
      ),
    );
  }
}

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
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: double.maxFinite,
        leading: AppBarWidget(
          stepScreen: 2,
          screen: const RegisterFeatureScreen(),
        ),
      ),
      body: SafeArea(
        child: ListView.builder(
          itemCount: txt2.length,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          itemBuilder: (context, index) => GestureDetector(
            onTap: () {
              Navigator.push(
                context,
                MaterialPageRoute(
                  builder: (context) => const RegisterFeatureScreen(),
                ),
              );
            },
            child: itemsCategoryType(
              txt: txt2[index],
              color: CustomColor.red,
            ),
          ),
        ),
      ),
    );
  }
}
