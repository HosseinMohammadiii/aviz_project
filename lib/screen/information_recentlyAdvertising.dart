import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../class/colors.dart';
import '../widgets/button_widget.dart';
import '../widgets/item_category_type.dart';
import '../widgets/text_widget.dart';
import '../widgets/uploadlocation.dart';
import 'dart:ui' as ui;

class InformationRecentlyAdvertising extends StatefulWidget {
  const InformationRecentlyAdvertising({super.key});

  @override
  State<InformationRecentlyAdvertising> createState() =>
      _InformationRecentlyAdvertisingState();
}

class _InformationRecentlyAdvertisingState
    extends State<InformationRecentlyAdvertising> {
  //List for display information horizontal category
  List<ContainerInfo> listText = [
    ContainerInfo('مشخصات', true, 0),
    ContainerInfo('قیمت', false, 1),
    ContainerInfo('ویژگی ها و امکانات', false, 2),
    ContainerInfo('توضیحات', false, 3),
  ];
  List<Image> images = [
    Image.asset('images/Image_home.png'),
    Image.asset(
      'images/Image_home2.png',
    ),
  ];

  int indexContainer = 0;
  PageController controller =
      PageController(viewportFraction: 0.9, initialPage: 0);
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        scrolledUnderElevation: 0,
        automaticallyImplyLeading: false,
        leadingWidth: double.maxFinite,
        leading: Padding(
          padding: const EdgeInsets.only(left: 15, right: 2),
          child: Row(
            children: [
              Image.asset('images/archive_icon.png'),
              const SizedBox(
                width: 20,
              ),
              Image.asset('images/share_icon.png'),
              const SizedBox(
                width: 20,
              ),
              Image.asset('images/information_icon.png'),
              const Spacer(),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(
                  Icons.chevron_right_rounded,
                  size: 42,
                ),
              ),
            ],
          ),
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: PageView.builder(
                    itemCount: 2,
                    controller: controller,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.symmetric(horizontal: 5),
                        child: ClipRRect(
                          borderRadius: BorderRadius.circular(8),
                          child: Stack(
                            fit: StackFit.expand,
                            alignment: Alignment.bottomCenter,
                            children: [
                              Image.asset(
                                'images/Image_home.png',
                                fit: BoxFit.fill,
                              ),
                              Positioned(
                                bottom: 12,
                                child: SmoothPageIndicator(
                                  controller: controller,
                                  count: images.length,
                                  effect: const ExpandingDotsEffect(
                                    expansionFactor: 5,
                                    dotHeight: 8,
                                    dotWidth: 8,
                                    dotColor: Colors.white,
                                    activeDotColor: CustomColor.red,
                                  ),
                                ),
                              ),
                            ],
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      '16 دقیقه پیش در اصفهان',
                      CustomColor.grey500,
                      14,
                      FontWeight.w400,
                    ),
                    Container(
                      height: 29,
                      width: 59,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: CustomColor.grey200,
                      ),
                      child: textWidget(
                        'آپارتمان',
                        CustomColor.red,
                        14,
                        FontWeight.w400,
                      ),
                    ),
                  ],
                ),
                const SizedBox(
                  height: 20,
                ),
                textWidget(
                  'آپارتمان ۵۰۰ متری در اصفهان',
                  CustomColor.black,
                  16,
                  FontWeight.w700,
                ),
                const SizedBox(
                  height: 25,
                ),
                DottedLine(
                  dashColor: CustomColor.grey200,
                  lineThickness: 1.5,
                  dashLength: 6,
                ),
                const SizedBox(
                  height: 25,
                ),
                itemsCategoryType(
                  txt: 'هشدار های قبل از معامله!',
                  color: CustomColor.grey350,
                ),
                const SizedBox(
                  height: 20,
                ),
                SizedBox(
                  height: 30,
                  child: ListView.builder(
                    scrollDirection: Axis.horizontal,
                    reverse: true,
                    itemCount: listText.length,
                    itemBuilder: (context, index) {
                      return Padding(
                        padding: const EdgeInsets.only(left: 19),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              for (int i = 0; i < listText.length; i++) {
                                listText[i].selected = (i == index);
                                indexContainer = index;
                              }
                            });
                          },
                          child: Container(
                            height: 29,
                            padding: const EdgeInsets.symmetric(horizontal: 8),
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: listText[index].selected
                                    ? Colors.transparent
                                    : CustomColor.grey350,
                              ),
                              color: listText[index].selected
                                  ? CustomColor.red
                                  : CustomColor.white,
                            ),
                            child: textWidget(
                              listText[index].text,
                              listText[index].selected
                                  ? CustomColor.grey
                                  : CustomColor.red,
                              14,
                              FontWeight.w400,
                            ),
                          ),
                        ),
                      );
                    },
                  ),
                ),
                const SizedBox(
                  height: 25,
                ),
                _changeBoxContainer(
                  indexContainer,
                ),
                const SizedBox(
                  height: 25,
                ),
                const ButtonWidget(),
              ],
            ),
          ),
        ),
      ),
    );
  }
}

//Function Switch For Display Widgets
_changeBoxContainer(
  int index,
) {
  switch (index) {
    case 0:
      return const SpecificationBox();

    case 1:
      return const PriceInfoWidget();
    case 2:
      return const FeatureWidget();
    case 3:
      return const DescriptionWidget();

    default:
      return const SpecificationBox();
  }
}

//Class for insert information horizontal list category
class ContainerInfo {
  String text;
  bool selected;
  int index;
  ContainerInfo(this.text, this.selected, this.index);
}

class SpecificationBox extends StatefulWidget {
  const SpecificationBox({
    super.key,
  });

  @override
  State<SpecificationBox> createState() => _SpecificationBoxState();
}

class _SpecificationBoxState extends State<SpecificationBox> {
  List listTextTitle = [
    'متراژ',
    'اتاق',
    'طبقه',
    'ساخت',
  ];

  @override
  Widget build(BuildContext context) {
    return Column(
      children: [
        Container(
          height: 100,
          decoration: BoxDecoration(
            border: Border.all(
              color: CustomColor.grey350,
            ),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              Padding(
                padding: const EdgeInsets.symmetric(horizontal: 30),
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    informationBoxItem('ساخت', 1402),
                    informationBoxItem('طبقه', 2),
                    informationBoxItem('اتاق', 6),
                    informationBoxItem('متراژ', 500),
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    Padding(
                      padding: const EdgeInsets.only(top: 10, bottom: 10),
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashColor: CustomColor.grey350,
                        lineThickness: 1.5,
                        dashLength: 6,
                      ),
                    ),
                  ],
                ],
              ),
            ],
          ),
        ),
        const SizedBox(
          height: 20,
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textWidget(
              'موقعیت مکانی',
              CustomColor.black,
              16,
              FontWeight.w700,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/map_icon.png'),
          ],
        ),
        const SizedBox(
          height: 20,
        ),
        UploadLocation(address: 'اصفهان، خواجو'),
      ],
    );
  }

  Column informationBoxItem(
    String title,
    num advertising,
  ) {
    return Column(
      mainAxisAlignment: MainAxisAlignment.spaceEvenly,
      crossAxisAlignment: CrossAxisAlignment.center,
      children: [
        const SizedBox(
          height: 14,
        ),
        textWidget(
          title,
          CustomColor.grey500,
          15,
          FontWeight.w400,
        ),
        Container(
          width: 40,
          alignment: Alignment.center,
          margin: const EdgeInsets.only(top: 12),
          child: SizedBox(
            height: 40,
            child: Text(
              advertising.toString(),
              textAlign: TextAlign.center,
              style: const TextStyle(
                fontFamily: 'SN',
                color: CustomColor.black,
                fontSize: 15,
                fontWeight: FontWeight.w400,
              ),
            ),
          ),
        ),
      ],
    );
  }
}

class PriceInfoWidget extends StatefulWidget {
  const PriceInfoWidget({
    super.key,
  });

  @override
  State<PriceInfoWidget> createState() => _PriceInfoWidgetState();
}

class _PriceInfoWidgetState extends State<PriceInfoWidget> {
  NumberFormat currencyFormat =
      NumberFormat.currency(locale: 'fa-IR', symbol: '');
  @override
  Widget build(BuildContext context) {
    return Container(
      height: 96,
      padding: const EdgeInsets.symmetric(horizontal: 15),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey350),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 100,
                child: Text(
                  '46,460,000',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CustomColor.black,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontFamily: 'SN',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              textWidget(
                'قیمت هر متر:',
                CustomColor.black,
                16,
                FontWeight.w700,
              ),
            ],
          ),
          DottedLine(
            dashColor: CustomColor.grey350,
            lineThickness: 1.5,
            dashLength: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const SizedBox(
                width: 150,
                child: Text(
                  '23,230,000,000',
                  overflow: TextOverflow.ellipsis,
                  style: TextStyle(
                    color: CustomColor.black,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontFamily: 'SN',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              textWidget(
                'قیمت کل:',
                CustomColor.black,
                16,
                FontWeight.w700,
              ),
            ],
          ),
        ],
      ),
    );
  }
}

class FeatureWidget extends StatelessWidget {
  const FeatureWidget({super.key});

  @override
  Widget build(BuildContext context) {
    List textFeature = [
      'آسانسور',
      'پارکینگ',
      'انباری',
      'بالکن',
      'پنت هاوس',
      'جنس کف سرامیک',
      'سرویس بهداشتی ایرانی و فرنگی',
    ];
    return Column(
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textWidget(
              'ویژگی ها',
              CustomColor.black,
              16,
              FontWeight.w700,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/clipboard.png'),
          ],
        ),
        Container(
          height: 112,
          padding: const EdgeInsets.symmetric(horizontal: 15),
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColor.grey350),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            mainAxisAlignment: MainAxisAlignment.spaceAround,
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    'تک برگ',
                    CustomColor.grey500,
                    16,
                    FontWeight.w700,
                  ),
                  textWidget(
                    'سند',
                    CustomColor.grey500,
                    16,
                    FontWeight.w700,
                  ),
                ],
              ),
              DottedLine(
                dashColor: CustomColor.grey350,
                lineThickness: 1.5,
                dashLength: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    'شمالی',
                    CustomColor.grey500,
                    16,
                    FontWeight.w700,
                  ),
                  textWidget(
                    'جهت ساختمان',
                    CustomColor.grey500,
                    16,
                    FontWeight.w700,
                  ),
                ],
              ),
            ],
          ),
        ),
        Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            textWidget(
              'امکانات',
              CustomColor.black,
              16,
              FontWeight.w700,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset('images/magicpen.png'),
          ],
        ),
        Container(
          margin: const EdgeInsets.symmetric(vertical: 20),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColor.grey350),
            borderRadius: BorderRadius.circular(4),
          ),
          child: Column(
            children: [
              SizedBox(
                height: 392,
                child: ListView.builder(
                  itemCount: textFeature.length,
                  physics: const NeverScrollableScrollPhysics(),
                  itemBuilder: (context, index) {
                    return Column(
                      mainAxisAlignment: MainAxisAlignment.spaceAround,
                      crossAxisAlignment: CrossAxisAlignment.end,
                      children: [
                        Padding(
                          padding: const EdgeInsets.symmetric(
                              vertical: 15, horizontal: 15),
                          child: textWidget(
                            textFeature[index],
                            CustomColor.grey500,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: DottedLine(
                            dashColor: index == 6
                                ? Colors.transparent
                                : CustomColor.grey350,
                            lineThickness: 1.5,
                            dashLength: 6,
                          ),
                        ),
                      ],
                    );
                  },
                ),
              ),
            ],
          ),
        ),
      ],
    );
  }
}

class DescriptionWidget extends StatelessWidget {
  const DescriptionWidget({
    super.key,
  });

  @override
  Widget build(BuildContext context) {
    return Text(
      'ویلا ۵۰۰ متری در خیابان صیاد شیرازی ویو عالی وسط جنگل قیمت فوق العاده  گذاشتم فروش فوری  خریدار باشی تخفیف پای معامله میدم.',
      textAlign: TextAlign.justify,
      textDirection: ui.TextDirection.rtl,
      style: TextStyle(
        color: CustomColor.grey500,
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
