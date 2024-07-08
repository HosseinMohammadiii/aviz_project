import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:aviz_project/class/scroll_behavior.dart';
import 'package:aviz_project/class/switch_classs.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_feature_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';

class RegisterHomeFeatureScreen extends StatefulWidget {
  RegisterHomeFeatureScreen({
    super.key,
    required this.title,
  });
  final String title;
  @override
  State<RegisterHomeFeatureScreen> createState() =>
      _RegisterHomeFeatureScreenState();
}

class _RegisterHomeFeatureScreenState extends State<RegisterHomeFeatureScreen> {
  bool changeIcon = false;
  bool isEmpty = true;

  int selectedIndex = 0;

  final layerLink = LayerLink();

  FocusNode focusNode1 = FocusNode();

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  OverlayEntry? entry;

  String address = '';
  String dialog = '';
  String? txtTitle;

  Jalali currentYear = Jalali(1340);
  Jalali endYear = Jalali.now();
  int yearLength = 0;
  List itemYear = [];

  var _scrollController = FixedExtentScrollController();

  @override
  void initState() {
    yearLength = endYear.year - currentYear.year + 1;
    itemYear = List.generate(yearLength, (index) {});

    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => hideOverlay(),
    );
  }

  List<ClassSwitchBox> propertiesTxt = [
    ClassSwitchBox('آسانسور', false),
    ClassSwitchBox('پارکینگ', false),
    ClassSwitchBox('انباری', false),
    ClassSwitchBox('بالکن', false),
    ClassSwitchBox('پنت هاوس', false),
  ];

  //Function for display Overlay
  void showOverlay() {
    List txt = [
      '${widget.title} آپارتمان',
      '${widget.title} خانه',
      '${widget.title} ویلا',
    ];
    final overLay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) => Positioned(
          width: 159,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height / 35),
            child: SizedBox(
              height: 110,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  itemCount: txt.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
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
                        setState(() {
                          hideOverlay();
                          changeIcon = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.symmetric(
                            vertical: 4, horizontal: 6),
                        color: CustomColor.grey300,
                        child: textWidget(
                          txt[index],
                          CustomColor.black,
                          15,
                          FontWeight.w500,
                        ),
                      ),
                    );
                  },
                ),
              ),
            ),
          )),
    );
    overLay.insert(entry!);
  }

//Function for hide Ovelay
  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: CustomScrollView(
            slivers: [
              SliverToBoxAdapter(
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.spaceAround,
                  children: [
                    const TextTitleSection(
                        txt: 'انتخاب دسته بندی آویز',
                        img: 'images/category-2.png'),
                    textCategory('محدوده ملک', 'دسته بندی'),
                    Row(
                      children: [
                        Container(
                          width: 159,
                          height: 48,
                          padding: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: CustomColor.grey350,
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.streetAddress,
                            focusNode: focusNode1,
                            textInputAction: TextInputAction.done,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'SN',
                              fontSize: 16,
                              color: CustomColor.grey500,
                              overflow: TextOverflow.ellipsis,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'محدوده را وارد کنید',
                              hintStyle: TextStyle(
                                fontFamily: 'SN',
                                fontSize: 16,
                                color: CustomColor.grey500,
                              ),
                            ),
                            onChanged: (value) {
                              setState(() {
                                address = value;
                              });
                            },
                            onTapOutside: (event) {
                              focusNode1.unfocus();
                            },
                          ),
                        ),
                        const Spacer(),
                        BlocBuilder<StatusModeBloc, StatusModeState>(
                          builder: (context, state) {
                            switch (state.statusMode) {
                              case StatusMode.apartment:
                                txtTitle = '${widget.title} آپارتمان';
                                break;
                              case StatusMode.home:
                                txtTitle = '${widget.title} خانه';
                                break;
                              case StatusMode.villa:
                                txtTitle = '${widget.title} ویلا';
                                break;
                              default:
                                txtTitle = '${widget.title} آپارتمان';
                                break;
                            }
                            return CompositedTransformTarget(
                              link: layerLink,
                              child: GestureDetector(
                                onTap: () {
                                  setState(() {
                                    changeIcon == true
                                        ? changeIcon = false
                                        : changeIcon = true;

                                    if (changeIcon == true) {
                                      showOverlay();
                                    } else {
                                      hideOverlay();
                                    }
                                  });
                                },
                                child: Container(
                                  width: 159,
                                  height: 48,
                                  decoration: BoxDecoration(
                                    border:
                                        Border.all(color: CustomColor.grey350),
                                    borderRadius: BorderRadius.only(
                                      topLeft: const Radius.circular(4),
                                      topRight: const Radius.circular(4),
                                      bottomLeft: changeIcon == false
                                          ? const Radius.circular(4)
                                          : const Radius.circular(0),
                                      bottomRight: changeIcon == false
                                          ? const Radius.circular(4)
                                          : const Radius.circular(0),
                                    ),
                                  ),
                                  child: Row(
                                    mainAxisAlignment:
                                        MainAxisAlignment.spaceBetween,
                                    crossAxisAlignment:
                                        CrossAxisAlignment.center,
                                    children: [
                                      Icon(
                                        changeIcon == false
                                            ? Icons.keyboard_arrow_down_rounded
                                            : Icons.keyboard_arrow_up_rounded,
                                        size: 34,
                                      ),
                                      Padding(
                                        padding:
                                            const EdgeInsets.only(right: 6),
                                        child: textWidget(
                                          txtTitle ?? '',
                                          CustomColor.black,
                                          16,
                                          FontWeight.w400,
                                        ),
                                      ),
                                    ],
                                  ),
                                ),
                              ),
                            );
                          },
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    const Divider(
                      thickness: 1.2,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const TextTitleSection(
                        txt: 'ویژگی ها', img: 'images/clipboard.png'),
                    textCategory('تعداد اتاق', 'متراژ'),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextfieldFeature(
                          controller: controller1,
                          textInputAction: TextInputAction.done,
                        ),
                        TextfieldFeature(
                          controller: controller2,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                    textCategory(
                      'سال ساخت',
                      'طبقه',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        widgetListWheelSelectYear(context),
                        TextfieldFeature(
                          controller: controller4,
                          textInputAction: TextInputAction.done,
                        ),
                      ],
                    ),
                    const SizedBox(
                      height: 15,
                    ),
                    const Divider(
                      thickness: 1.2,
                    ),
                    const SizedBox(
                      height: 14,
                    ),
                    const TextTitleSection(
                        txt: 'امکانات', img: 'images/magicpen.png'),
                  ],
                ),
              ),
              // SliverToBoxAdapter(
              //   child: BlocBuilder<AdFeaturesBloc, AdFeaturesState>(
              //     builder: (context, state) {
              //       return CustomScrollView(
              //         shrinkWrap: true,
              //         slivers: [
              //           if (state is AdDetailRequestSuccessState) ...[
              //             state.advertisingFacilitiesList.fold(
              //               (error) => SliverToBoxAdapter(
              //                 child: Center(
              //                   child: textWidget(
              //                     error,
              //                     CustomColor.black,
              //                     16,
              //                     FontWeight.w500,
              //                   ),
              //                 ),
              //               ),
              //               (facilities) => SliverList.builder(
              //                 itemCount: facilities.length,
              //                 itemBuilder: (context, index) {
              //                   return AdvertisingFacilitiesWidget(
              //                     adFacilities: facilities[index],
              //                   );
              //                 },
              //               ),
              //             ),
              //           ],
              //         ],
              //       );
              //     },
              //   ),
              // ),
              SliverList.builder(
                itemCount: propertiesTxt.length,
                itemBuilder: (context, index) => switchBox(index),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                  child: GestureDetector().textButton(
                    () {
                      if (address.isEmpty ||
                          controller1.text.isEmpty ||
                          controller2.text.isEmpty ||
                          controller3.text.isEmpty ||
                          controller4.text.isEmpty) {
                        displayDialog(
                            'لطفا تمامی فیلد ها را کامل کنید', context);
                      } else {
                        try {
                          num metr = num.parse(controller2.text);
                          num countRoom = num.parse(controller1.text);
                          num floor = num.parse(controller4.text);
                          num yearBuild = num.parse(controller3.text);
                          addAdvertising(
                            metr,
                            countRoom,
                            floor,
                            yearBuild,
                            txtTitle!,
                            address,
                          );
                          setState(() {
                            isEmpty = false;
                          });

                          BlocProvider.of<NavigationPage>(context)
                              .getNavItems(ViewPage.registerHomeLocation);
                        } catch (e) {
                          displayDialog(
                              'لطفاً مقدار عددی معتبر وارد کنید', context);
                        }
                      }
                    },
                    'بعدی',
                    CustomColor.red,
                    CustomColor.grey,
                    false,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Widget For Display List Years to Select Build Year
  Widget widgetListWheelSelectYear(BuildContext context) {
    return GestureDetector(
      onTap: () {
        showDialog(
          context: context,
          builder: (context) => Column(
            mainAxisAlignment: MainAxisAlignment.center,
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              Container(
                height: 150,
                width: 270,
                alignment: Alignment.center,
                decoration: BoxDecoration(
                  color: CustomColor.grey350,
                  borderRadius: BorderRadius.circular(8),
                ),
                child: ListWheelScrollView.useDelegate(
                  controller: _scrollController,
                  itemExtent: 50,
                  squeeze: 0.7,
                  renderChildrenOutsideViewport: false,
                  onSelectedItemChanged: (index) {
                    int selectYear = currentYear.year + index;

                    setState(() {
                      controller3.text = selectYear.toString();

                      //Display Scroll Item last Value selected
                      _scrollController =
                          FixedExtentScrollController(initialItem: index);
                    });
                  },
                  childDelegate: ListWheelChildBuilderDelegate(
                    childCount: itemYear.length,
                    builder: (context, index) {
                      int year = currentYear.year + index;

                      return GestureDetector(
                        onTap: () {
                          setState(() {
                            controller3.text = year.toString();

                            //Display Scroll Item last Value selected
                            _scrollController =
                                FixedExtentScrollController(initialItem: index);

                            //Navigator Pop For When Selected Item
                            Navigator.pop(context);
                          });
                        },
                        child: Container(
                          width: 100,
                          decoration: BoxDecoration(
                            color: CustomColor.white,
                            borderRadius: BorderRadius.circular(5),
                          ),
                          alignment: Alignment.center,
                          child: Text(
                            '$year'.toPersianDigit(),
                            style: Theme.of(context)
                                .textTheme
                                .apply(
                                  fontSizeDelta: 10,
                                  bodyColor: CustomColor.bluegrey,
                                )
                                .titleMedium,
                          ),
                        ),
                      );
                    },
                  ),
                ),
              ),
            ],
          ),
        );
      },
      child: Stack(
        alignment: Alignment.center,
        children: [
          TextfieldFeature(
            controller: controller3,
            textInputAction: TextInputAction.done,
          ),
          Container(
            width: 159,
            height: 48,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

//Widget For Add Advertising
  void addAdvertising(
    num metr,
    num countRoom,
    num floor,
    num yearBuild,
    String title,
    String address,
  ) {
    Advertising advertising = Advertising(
      metr: metr,
      countRom: countRoom,
      floor: floor,
      yearBuild: yearBuild,
      title: title,
      address: address,
    );
    advertisingBox.add(advertising);
  }

//Widget for display switch feature
  Widget switchBox(
    int index,
  ) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: CustomColor.grey350),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            activeColor: CustomColor.red,
            activeTrackColor: CustomColor.red,
            thumbColor: const MaterialStatePropertyAll(CustomColor.grey),
            trackOutlineColor:
                const MaterialStatePropertyAll(Colors.transparent),
            value: propertiesTxt[index].switchBool,
            onChanged: (value) {
              setState(() {
                propertiesTxt[index].switchBool = value;
              });
            },
          ),
          textWidget(
            propertiesTxt[index].txt,
            CustomColor.black,
            16,
            FontWeight.w400,
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
            width: MediaQuery.of(context).size.width / 7,
          ),
          textWidget(
            txt1,
            CustomColor.grey500,
            14,
            FontWeight.w600,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
          ),
          textWidget(
            txt2,
            CustomColor.grey500,
            14,
            FontWeight.w600,
          ),
        ],
      ),
    );
  }
}
