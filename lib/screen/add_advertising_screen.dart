import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/item_category_type.dart';
import 'package:flutter/material.dart';

class AddAdvertisingScreen extends StatefulWidget {
  const AddAdvertisingScreen({super.key});

  @override
  State<AddAdvertisingScreen> createState() => _AddAdvertisingScreenState();
}

class _AddAdvertisingScreenState extends State<AddAdvertisingScreen> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
            backgroundColor: Colors.transparent,
            elevation: 0,
            automaticallyImplyLeading: false,
            flexibleSpace: AppBarWidget(stepScreen: 1)),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            children: [
              SizedBox(
                height: MediaQuery.of(context).size.height / 1.3,
                child: ListView.builder(
                  padding: const EdgeInsets.symmetric(vertical: 12),
                  itemCount: 6,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) =>
                                ItemSelectCategory(txt: 'فروش آپارتمان'),
                          ),
                        );
                      },
                      child: itemsCategoryType(
                          txt: 'فروش مسکونی', color: CustomColor.red),
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
