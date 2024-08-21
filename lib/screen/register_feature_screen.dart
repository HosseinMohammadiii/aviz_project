import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/widgets/items_switchbox.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_feature_screen.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';

class RegisterHomeFeatureScreen extends StatefulWidget {
  const RegisterHomeFeatureScreen({
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

  final layerLink = LayerLink();

  final FocusNode focusNode1 = FocusNode();

  final TextEditingController controller1 = TextEditingController();
  final TextEditingController controller2 = TextEditingController();
  final TextEditingController controller3 = TextEditingController();
  final TextEditingController controller4 = TextEditingController();

  OverlayEntry? entry;

  String address = '';
  String? txtTitle;
  String title = '';

  Jalali currentYear = Jalali(1340);
  Jalali endYear = Jalali.now();

  int _currentSliderPrimaryValue = 0;
  int yearLength = 0;

  List itemYear = [];

  var _scrollController = FixedExtentScrollController();

  @override
  void initState() {
    var state = context.read<StatusModeBloc>().state;
    switch (state.statusMode) {
      case StatusMode.apartment:
        title = '${widget.title} آپارتمان';
        break;
      case StatusMode.home:
        title = '${widget.title} خانه';
        break;
      case StatusMode.villa:
        title = '${widget.title} ویلا';
        break;
      case StatusMode.buyLand:
        title = '${widget.title} زمین';
        break;
      default:
        txtTitle = '${widget.title} آپارتمان';
        break;
    }
    yearLength = endYear.year - currentYear.year + 1;
    itemYear = List.generate(yearLength, (index) {});
    super.initState();
    BlocProvider.of<AddAdvertisingBloc>(context)
        .add(AddAdvertisingGetInitializeData());
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => hideOverlay(),
    );
  }

  //Function for display Overlay
  void showOverlay() {
    List txtRent = [
      '${widget.title} آپارتمان',
      '${widget.title} خانه',
      '${widget.title} ویلا',
    ];
    List txtBuy = [
      '${widget.title} آپارتمان',
      '${widget.title} خانه',
      '${widget.title} ویلا',
      '${widget.title} زمین',
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
            offset: Offset(0, size.height / 32),
            child: SizedBox(
              height: 140,
              child: ListView.builder(
                shrinkWrap: true,
                itemCount:
                    widget.title == 'اجاره' ? txtRent.length : txtBuy.length,
                itemBuilder: (context, index) {
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (index == 0) {
                          BlocProvider.of<StatusModeBloc>(context)
                              .getStatusMode(StatusMode.apartment);
                          title = '${widget.title} آپارتمان';
                        } else if (index == 1) {
                          BlocProvider.of<StatusModeBloc>(context)
                              .getStatusMode(StatusMode.home);
                          title = '${widget.title} خانه';
                        } else if (index == 2) {
                          BlocProvider.of<StatusModeBloc>(context)
                              .getStatusMode(StatusMode.villa);
                          title = '${widget.title} ویلا';
                        } else {
                          BlocProvider.of<StatusModeBloc>(context)
                              .getStatusMode(StatusMode.buyLand);
                          title = '${widget.title} زمین';
                        }
                      });
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
                        widget.title == 'اجاره'
                            ? txtRent[index]
                            : txtBuy[index],
                        CustomColor.black,
                        15,
                        FontWeight.w500,
                      ),
                    ),
                  );
                },
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
                  children: [
                    const TextTitleSection(
                        txt: 'انتخاب دسته بندی آویز',
                        img: 'images/category-2.png'),
                    textCategory(
                        title == 'فروش زمین' ? 'محدوده زمین' : 'محدوده ملک',
                        'دسته بندی'),
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
                                title = '${widget.title} آپارتمان';
                                break;
                              case StatusMode.home:
                                txtTitle = '${widget.title} خانه';
                                title = '${widget.title} خانه';
                                break;
                              case StatusMode.villa:
                                txtTitle = '${widget.title} ویلا';
                                title = '${widget.title} ویلا';
                                break;
                              case StatusMode.buyLand:
                                txtTitle = '${widget.title} زمین';
                                title = '${widget.title} زمین';
                                break;
                              default:
                                txtTitle = '${widget.title} آپارتمان';
                                break;
                            }
                            return GestureDetector(
                              onTap: () {
                                setState(() {
                                  changeIcon = !changeIcon;

                                  if (changeIcon) {
                                    showOverlay();
                                  } else {
                                    hideOverlay();
                                  }
                                });
                              },
                              child: CompositedTransformTarget(
                                link: layerLink,
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
                    Visibility(
                      visible: title == 'فروش زمین',
                      replacement: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          textCategory('تعداد اتاق', 'متراژ'),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextfieldFeature(
                                controller: controller1,
                                value: num.tryParse(controller1.text) ?? 0,
                                textInputAction: TextInputAction.done,
                              ),
                              widgetBoxFeatures(
                                context,
                                widgetSliderMeterFeature(),
                                controller2,
                                'متراژ را وارد کنید',
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
                              widgetBoxFeatures(
                                context,
                                _boxListWheelYears(),
                                controller3,
                                'سال ساخت را انتخاب کنید',
                              ),
                              TextfieldFeature(
                                controller: controller4,
                                value: num.tryParse(controller4.text) ?? 0,
                                textInputAction: TextInputAction.done,
                              ),
                            ],
                          ),
                        ],
                      ),
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.spaceAround,
                        children: [
                          textCategory(
                            'سال خرید',
                            'متراژ',
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              widgetBoxFeatures(
                                context,
                                _boxListWheelYears(),
                                controller3,
                                'سال خرید را انتخاب کنید',
                              ),
                              widgetBoxFeatures(
                                context,
                                widgetSliderMeterFeature(),
                                controller2,
                                'متراژ را وارد کنید',
                              ),
                            ],
                          ),
                        ],
                      ),
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
              ItemsSwitchbox(
                title: title,
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                  child: GestureDetector().textButton(
                    () {
                      //Function For Display Id Facilities Item at Collections inforegisteredhomes in DataBase
                      String idCt() {
                        String idCt = '';

                        if (txtTitle == 'اجاره آپارتمان') {
                          idCt = '4m44z8mrvvmqmrb';
                        } else if (txtTitle == 'اجاره خانه') {
                          idCt = 'awbiuhrki02leje';
                        } else if (txtTitle == 'اجاره ویلا') {
                          idCt = '04lqfn5b7bpiwdm';
                        }

                        if (txtTitle == 'فروش آپارتمان') {
                          idCt = 'daxmo7fipbo5xnc';
                        } else if (txtTitle == 'فروش خانه') {
                          idCt = 'zlbqbrywl9f0b92';
                        } else if (txtTitle == 'فروش ویلا') {
                          idCt = 'egylfeay2tn1hxn';
                        } else if (txtTitle == 'فروش زمین') {
                          idCt = '7ost8r7msw8lt0c';
                        }

                        return idCt;
                      }

                      if (title != 'فروش زمین'
                          ? address.isEmpty ||
                              controller1.text.isEmpty ||
                              controller2.text.isEmpty ||
                              controller3.text.isEmpty ||
                              controller4.text.isEmpty
                          : address.isEmpty ||
                              controller2.text.isEmpty ||
                              controller3.text.isEmpty) {
                        displayDialog(
                            'لطفا تمامی فیلد ها را کامل کنید', context);
                        return;
                      }
                      try {
                        num metr = num.tryParse(controller2.text) ?? 0;
                        num countRoom = num.tryParse(controller1.text) ?? 0;
                        num floor = num.tryParse(controller4.text) ?? 0;
                        num yearBuild = num.tryParse(controller3.text) ?? 0;

                        context.read<RegisterInfoAdCubit>().setParametrInfoAd(
                              metr: metr,
                              countRoom: countRoom,
                              floor: floor,
                              yearBuild: yearBuild,
                              idCt: idCt(),
                              address: address,
                            );

                        // addAdvertising(
                        //   metr,
                        //   countRoom,
                        //   floor,
                        //   yearBuild,
                        //   txtTitle!,
                        //   address,
                        // );

                        BlocProvider.of<NavigationPage>(context)
                            .getNavItems(ViewPage.registerHomeLocation);
                      } catch (e) {
                        displayDialog(
                            'لطفاً مقدار عددی معتبر وارد کنید', context);
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

//Function For Start Number TextfieldFeature Stateful Widget
  num numberBuild(String title, TextEditingController controller) {
    if (title == 'سال ساخت را انتخاب کنید' ||
        title == 'سال خرید را انتخاب کنید') {
      return num.tryParse(controller.text) ?? 1341;
    } else {
      return num.tryParse(controller.text) ?? 0;
    }
  }

//Widget For Display Slider Input Meter Number
  Widget widgetSliderMeterFeature() {
    return StatefulBuilder(
      builder: (context, setState) => Slider(
        value: double.tryParse(controller2.text) ?? 0.0,
        min: 0,
        max: 1000,
        divisions: 1000,
        thumbColor: CustomColor.red,
        activeColor: CustomColor.pink,
        label: _currentSliderPrimaryValue.toString(),
        onChanged: (value) {
          if (value > 0) {
            setState(() {
              _currentSliderPrimaryValue = value.toInt();

              controller2.text = _currentSliderPrimaryValue.toString();
            });
          } else {
            controller2.text = '';
          }
        },
      ),
    );
  }

//Widget For Display Widgets ListWheel Years Build And Slider Input Number
  Widget widgetBoxFeatures(
    BuildContext context,
    Widget widget,
    TextEditingController controller,
    String title,
  ) {
    return GestureDetector(
      onTap: () async {
        await showDialog(
            context: context,
            builder: (context) {
              return AlertDialog(
                backgroundColor: CustomColor.grey350,
                alignment: Alignment.center,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    Text(
                      title,
                      style: TextStyle(
                        color: CustomColor.bluegrey,
                        fontSize: 15,
                      ),
                    ),
                    const SizedBox(
                      height: 5,
                    ),
                    widget,
                  ],
                ),
              );
            });
        // setState(() {
        // });
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          TextfieldFeature(
            controller: controller,
            value: numberBuild(title, controller),
            textInputAction: TextInputAction.done,
          ),
          Container(
            width: 140,
            height: 48,
            color: Colors.transparent,
          ),
        ],
      ),
    );
  }

//Widget For Display ListWheel Years Build
  Widget _boxListWheelYears() {
    return SizedBox(
      height: 150,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollController,
        itemExtent: 50,
        squeeze: 0.7,
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
                  color: controller3.text == year.toString()
                      ? CustomColor.red
                      : CustomColor.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$year'.toPersianDigit(),
                  style: Theme.of(context)
                      .textTheme
                      .apply(
                        fontSizeDelta: 10,
                        bodyColor: controller3.text == year.toString()
                            ? CustomColor.white
                            : CustomColor.bluegrey,
                      )
                      .titleMedium,
                ),
              ),
            );
          },
        ),
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
