import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/screen/locatin_upload_screen.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class RegisterFeatureScreen extends StatefulWidget {
  const RegisterFeatureScreen({super.key});

  @override
  State<RegisterFeatureScreen> createState() => _RegisterFeatureScreenState();
}

class _RegisterFeatureScreenState extends State<RegisterFeatureScreen> {
  bool _switchBox = false;
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: AppBarWidget(stepScreen: 3),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                const TextTitleSection(
                    txt: 'انتخاب دسته بندی آویز', img: 'images/category-2.png'),
                const SizedBox(
                  height: 30,
                ),
                textCategory('محدوده ملک', 'دسته بندی'),
                Row(
                  children: [
                    Container(
                      width: 159,
                      height: 48,
                      margin: const EdgeInsets.only(right: 43),
                      decoration: BoxDecoration(
                        color: Colors.grey[350],
                        borderRadius: BorderRadius.circular(4),
                      ),
                      alignment: Alignment.center,
                      child: textWidget(
                        'خیابان صیاد شیرازی',
                        Colors.grey[500]!,
                        16,
                        FontWeight.w400,
                      ),
                    ),
                    const Spacer(),
                    Container(
                      width: 159,
                      height: 48,
                      decoration: BoxDecoration(
                        border: Border.all(color: Colors.grey[350]!),
                        borderRadius: BorderRadius.circular(4),
                      ),
                      child: Row(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          const Icon(
                            Icons.keyboard_arrow_down_rounded,
                            size: 34,
                          ),
                          textWidget(
                            'فروش آپارتمان',
                            Colors.black,
                            16,
                            FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 10,
                ),
                const Divider(
                  thickness: 1.2,
                ),
                const TextTitleSection(
                    txt: 'ویژگی ها', img: 'images/clipboard.png'),
                textCategory('تعداد اتاق', 'متراژ'),
                boxInfoFeature('6', '350'),
                textCategory('سال ساخت', 'طبقه'),
                boxInfoFeature('1402', '3'),
                const TextTitleSection(
                    txt: 'امکانات', img: 'images/magicpen.png'),
                switchBox('آسانسور'),
                GestureDetector().textButton(
                  () {
                    Navigator.push(
                      context,
                      MaterialPageRoute(
                        builder: (context) => const LocatioUpload(),
                      ),
                    );
                  },
                  'بعدی',
                  CustomColor.red,
                  CustomColor.grey,
                  false,
                ),
                const SizedBox(
                  height: 10,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Widget for display switch feature
  Widget switchBox(String txt) {
    return SizedBox(
      height: 300,
      child: ListView.builder(
        itemCount: 4,
        itemBuilder: (context, index) => Container(
          height: 40,
          margin: const EdgeInsets.symmetric(vertical: 10),
          padding: const EdgeInsets.symmetric(horizontal: 10),
          decoration: BoxDecoration(
            border: Border.all(color: Colors.grey[350]!),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              Switch(
                activeColor: CustomColor.red,
                value: _switchBox,
                onChanged: (value) {
                  setState(() {
                    _switchBox = !_switchBox;
                    value = _switchBox;
                  });
                },
              ),
              textWidget(
                txt,
                Colors.black,
                16,
                FontWeight.w400,
              ),
            ],
          ),
        ),
      ),
    );
  }

//Widget for display box sector feature
  Widget boxInfoFeature(String txt1, String txt2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceEvenly,
        children: [
          Container(
            width: 159,
            height: 48,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    Icon(
                      Icons.arrow_drop_up_rounded,
                      color: CustomColor.red,
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      color: CustomColor.red,
                    ),
                  ],
                ),
                textWidget(
                  txt1,
                  Colors.black,
                  16,
                  FontWeight.w400,
                ),
              ],
            ),
          ),
          const Spacer(),
          Container(
            width: 159,
            height: 48,
            padding: const EdgeInsets.only(right: 10),
            decoration: BoxDecoration(
              color: Colors.grey[350],
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Column(
                  children: [
                    Icon(
                      Icons.arrow_drop_up_rounded,
                      color: CustomColor.red,
                    ),
                    Icon(
                      Icons.arrow_drop_down_rounded,
                      color: CustomColor.red,
                    ),
                  ],
                ),
                textWidget(
                  txt2,
                  Colors.black,
                  16,
                  FontWeight.w400,
                ),
              ],
            ),
          ),
        ],
      ),
    );
  }

//Widget for display title category top box
  Widget textCategory(String txt1, String txt2) {
    return Padding(
      padding: const EdgeInsets.symmetric(vertical: 10),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: MediaQuery.of(context).size.width / 5.8,
          ),
          textWidget(
            txt1,
            Colors.grey[500]!,
            14,
            FontWeight.w600,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
          ),
          textWidget(
            txt2,
            Colors.grey[500]!,
            14,
            FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
