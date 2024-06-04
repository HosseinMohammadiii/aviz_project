import 'package:aviz_project/DataFuture/home/Data/model/advertising.dart';
import 'package:aviz_project/extension/price_extension.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

import '../class/colors.dart';
import '../widgets/advertisig_gallery_imaes_widget.dart';
import '../widgets/button_widget.dart';
import '../widgets/items_category_type.dart';
import '../widgets/text_widget.dart';
import '../widgets/uploadlocation.dart';
import 'dart:ui' as ui;

class InformationRecentlyAdvertising extends StatefulWidget {
  InformationRecentlyAdvertising({
    super.key,
    required this.advertisingHome,
  });
  AdvertisingHome advertisingHome;
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

  int indexContainer = 0;

  PageController controller =
      PageController(viewportFraction: 0.9, initialPage: 0);

//Function to display the difference between the time of the created ad and the current time
  String _createADTime(DateTime time) {
    DateTime dt = DateTime.parse(widget.advertisingHome.created);
    Duration dr = DateTime.now().difference(dt);
    if (dr.inSeconds < 60) {
      return ' چند لحظه پیش';
    } else if (dr.inMinutes < 60) {
      return '${dr.inMinutes} دقیقه پیش';
    } else if (dr.inHours < 24) {
      return '${dr.inHours} ساعت پیش';
    } else if (dr.inDays < 7) {
      return '${dr.inDays} روز پیش';
    } else if (dr.inDays < 30) {
      return '${dr.inDays ~/ 7} هفته پیش';
    } else if (dr.inDays < 365) {
      return '${dr.inDays ~/ 30} ماه پیش';
    } else {
      int years = dr.inDays ~/ 365;
      return '$years سال پیش';
    }
  }

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
              GestureDetector(
                onTap: () {},
                child: Image.asset('images/archive_icon.png'),
              ),
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
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: AdvertisingGalleryImages(
                  advertisingHome: widget.advertisingHome,
                  controller: controller,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      _createADTime(
                          DateTime.parse(widget.advertisingHome.created)),
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
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: textWidget(
                  widget.advertisingHome.title,
                  CustomColor.black,
                  16,
                  FontWeight.w700,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
              SliverToBoxAdapter(
                child: DottedLine(
                  dashColor: CustomColor.grey200,
                  lineThickness: 1.5,
                  dashLength: 6,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
              SliverToBoxAdapter(
                child: ItemCategoryType(
                  txt: 'هشدار های قبل از معامله!',
                  color: CustomColor.grey350,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 20,
                ),
              ),
              SliverToBoxAdapter(
                child: SizedBox(
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
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
              SliverToBoxAdapter(
                child: _changeBoxContainer(
                  indexContainer,
                  widget.advertisingHome,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 25,
                ),
              ),
              const SliverToBoxAdapter(
                child: ButtonWidget(),
              ),
            ],
          ),
        ),
      ),
    );
  }
}

//Function Switch For Display Widgets
_changeBoxContainer(
  int index,
  AdvertisingHome adHome,
) {
  switch (index) {
    case 0:
      return GestureDetector(
        onTap: () {
          DateTime dt = DateTime.parse(adHome.created);
          print(DateTime.now().difference(dt).inHours);
        },
        child: SpecificationBox(advertisingHome: adHome),
      );

    case 1:
      return PriceInfoWidget(advertisingHome: adHome);
    case 2:
      return const FeatureWidget();
    case 3:
      return DescriptionWidget(advertisingHome: adHome);

    default:
      return SpecificationBox(advertisingHome: adHome);
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
  SpecificationBox({
    super.key,
    required this.advertisingHome,
  });
  AdvertisingHome advertisingHome;
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
                    informationBoxItem('ساخت', widget.advertisingHome.yerbuild),
                    informationBoxItem('طبقه', widget.advertisingHome.floor),
                    informationBoxItem('اتاق', widget.advertisingHome.room),
                    informationBoxItem('متراژ', widget.advertisingHome.metr),
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
  PriceInfoWidget({
    super.key,
    required this.advertisingHome,
  });
  AdvertisingHome advertisingHome;
  @override
  State<PriceInfoWidget> createState() => _PriceInfoWidgetState();
}

class _PriceInfoWidgetState extends State<PriceInfoWidget> {
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
              SizedBox(
                width: 100,
                child: Text(
                  priceChanged(widget.advertisingHome),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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
              SizedBox(
                width: 150,
                child: Text(
                  widget.advertisingHome.price.formatter(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
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

  //Function to calculate the price per meter of the house
  priceChanged(AdvertisingHome adHome) {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'fa-IR', symbol: '');
    var priceChange = currencyFormat.format(adHome.price / adHome.metr);
    return priceChange;
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
  DescriptionWidget({
    super.key,
    required this.advertisingHome,
  });
  AdvertisingHome advertisingHome;
  @override
  Widget build(BuildContext context) {
    return Text(
      advertisingHome.description,
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
