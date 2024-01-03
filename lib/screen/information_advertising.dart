import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/widgets/button_widget.dart';
import 'package:aviz_project/widgets/item_category_type.dart';
import 'package:aviz_project/widgets/items_information_advertising.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/uploadlocation.dart';
import 'package:flutter/material.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:intl/intl.dart';
import 'dart:ui' as ui;

class InformationAdvertising extends StatefulWidget {
  InformationAdvertising({
    super.key,
    required this.advertising,
    required this.advertisingData,
  });
  Advertising advertising;
  AdvertisingData advertisingData;

  @override
  State<InformationAdvertising> createState() => _InformationAdvertisingState();
}

class _InformationAdvertisingState extends State<InformationAdvertising> {
  //List for display information horizontal category
  List<ContainerInfo> listText = [
    ContainerInfo('مشخصات', true, 0),
    ContainerInfo('قیمت', false, 1),
    ContainerInfo('ویژگی ها و امکانات', false, 2),
    ContainerInfo('توضیحات', false, 3),
  ];

  int indexContainer = 0;

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          elevation: 0,
          backgroundColor: Colors.transparent,
          automaticallyImplyLeading: false,
          flexibleSpace: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
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
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                SizedBox(
                  height: 160,
                  width: double.infinity,
                  child: ClipRRect(
                    borderRadius: BorderRadius.circular(8),
                    child: Image.file(
                      widget.advertisingData.img!,
                      fit: BoxFit.fill,
                    ),
                  ),
                ),
                const SizedBox(
                  height: 30,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.spaceBetween,
                  children: [
                    textWidget(
                      '۱۶ دقیقه پیش در گرگان',
                      Colors.grey[500]!,
                      14,
                      FontWeight.w400,
                    ),
                    Container(
                      height: 29,
                      width: 59,
                      alignment: Alignment.center,
                      decoration: BoxDecoration(
                        borderRadius: BorderRadius.circular(4),
                        color: Colors.grey[200]!,
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
                  widget.advertisingData.title ?? 'Null',
                  Colors.black,
                  16,
                  FontWeight.w700,
                ),
                const SizedBox(
                  height: 25,
                ),
                DottedLine(
                  dashColor: Colors.grey[200]!,
                  lineThickness: 1.5,
                  dashLength: 6,
                ),
                const SizedBox(
                  height: 25,
                ),
                itemsCategoryType(
                  txt: 'هشدار های قبل از معامله!',
                  color: Colors.grey[350]!,
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
                                    : Colors.grey[350]!,
                              ),
                              color: listText[index].selected
                                  ? Colors.red
                                  : Colors.white,
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
                  widget.advertising,
                  widget.advertisingData,
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

  _changeBoxContainer(
    int index,
    Advertising advertising,
    AdvertisingData advertisingData,
  ) {
    switch (index) {
      case 0:
        return SpecificationBox(
          advertising: advertising,
        );

      case 1:
        return PriceInfoWidget(
          advertisingData: advertisingData,
          advertising: advertising,
        );
      case 2:
        return FeatureWidget();
      case 3:
        return DescriptionWidget(
          advertisingData: advertisingData,
        );

      default:
        return SpecificationBox(
          advertising: advertising,
        );
    }
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
    required this.advertising,
  });
  Advertising advertising;

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
            border: Border.all(color: Colors.grey[350]!),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Stack(
            children: [
              ItemInformation(advertising: widget.advertising),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < 3; i++) ...[
                    Padding(
                      padding:
                          const EdgeInsets.only(top: 10, bottom: 10, left: 5.5),
                      child: DottedLine(
                        direction: Axis.vertical,
                        dashColor: Colors.grey[350]!,
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
              Colors.black,
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
        const UploadLocation(),
      ],
    );
  }
}

class PriceInfoWidget extends StatefulWidget {
  PriceInfoWidget({
    super.key,
    required this.advertisingData,
    required this.advertising,
  });
  AdvertisingData advertisingData;
  Advertising advertising;

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
        border: Border.all(color: Colors.grey[350]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Column(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(
                priceChanged(widget.advertisingData.price.toString()),
                Colors.black,
                16,
                FontWeight.w700,
              ),
              textWidget(
                'قیمت هر متر:',
                Colors.black,
                16,
                FontWeight.w700,
              ),
            ],
          ),
          DottedLine(
            dashColor: Colors.grey[350]!,
            lineThickness: 1.5,
            dashLength: 6,
          ),
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              textWidget(
                currencyFormat.format(widget.advertisingData.price ?? 'Null'),
                Colors.black,
                16,
                FontWeight.w700,
              ),
              textWidget(
                'قیمت کل:',
                Colors.black,
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
  priceChanged(String price) {
    var priceChange = currencyFormat
        .format(widget.advertisingData.price! / widget.advertising.metr!);
    return price = priceChange;
  }
}

class FeatureWidget extends StatelessWidget {
  FeatureWidget({super.key});

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
              Colors.black,
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
            border: Border.all(color: Colors.grey[350]!),
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
                    Colors.grey[500]!,
                    16,
                    FontWeight.w700,
                  ),
                  textWidget(
                    'سند',
                    Colors.grey[500]!,
                    16,
                    FontWeight.w700,
                  ),
                ],
              ),
              DottedLine(
                dashColor: Colors.grey[350]!,
                lineThickness: 1.5,
                dashLength: 6,
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  textWidget(
                    'شمالی',
                    Colors.grey[500]!,
                    16,
                    FontWeight.w700,
                  ),
                  textWidget(
                    'جهت ساختمان',
                    Colors.grey[500]!,
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
              Colors.black,
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
            border: Border.all(color: Colors.grey[350]!),
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
                            Colors.grey[500]!,
                            16,
                            FontWeight.w400,
                          ),
                        ),
                        Padding(
                          padding: const EdgeInsets.only(left: 15, right: 15),
                          child: DottedLine(
                            dashColor: index == 6
                                ? Colors.transparent
                                : Colors.grey[350]!,
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
    required this.advertisingData,
  });
  AdvertisingData advertisingData;
  @override
  Widget build(BuildContext context) {
    return Text(
      advertisingData.description!,
      textAlign: TextAlign.justify,
      textDirection: ui.TextDirection.rtl,
      style: TextStyle(
        color: Colors.grey[500],
        fontSize: 16,
        fontWeight: FontWeight.w400,
      ),
    );
  }
}
