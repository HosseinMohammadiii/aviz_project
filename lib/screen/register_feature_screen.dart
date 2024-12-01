import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/city.dart';
import 'package:aviz_project/widgets/items_switchbox.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/foundation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:persian_number_utility/persian_number_utility.dart';
import 'package:shamsi_date/shamsi_date.dart';

import '../class/checkconnection.dart';
import '../class/scaffoldmessage.dart';
import '../widgets/text_title_section.dart';
import 'province.dart';

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

  final focusNode1 = FocusNode();

  final controllerCounRoom = TextEditingController();
  final controllerMetr = TextEditingController();
  final controllerBuildingMetr = TextEditingController();
  final controllerYearBuild = TextEditingController();
  final controllerFloor = TextEditingController();
  final controllerView = TextEditingController();
  final controllerDocument = TextEditingController();

  OverlayEntry? entry;

  String? txtTitle;
  String title = '';
  String province = '';
  String city = '';

  Jalali currentYear = Jalali(1340);
  Jalali endYear = Jalali.now();

  int metr = 0;

  int year = 0;
  int yearLength = 0;
  int indexDocument = 0;
  int indexView = 0;

  List itemYear = [];
  List<String> view = [
    'شمالی',
    'جنوبی',
    'شرقی',
    'غربی',
  ];
  List<String> document = [
    'وقفی',
    'شش دانگ',
    'تک برگ',
    'ندارد',
  ];

  var _scrollYearController = FixedExtentScrollController();
  var _scrollDocumentController = FixedExtentScrollController();
  var _scrollViewController = FixedExtentScrollController();

  ValueNotifier<int>? metrValueNotifier;
  ValueNotifier<int>? buildingMetrValueNotifier;
  ValueNotifier<int>? countRoomValueNotifier;
  ValueNotifier<int>? floorValueNotifier;

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
    year = currentYear.year;
    itemYear = List.generate(yearLength, (index) {});

    final stateAd = context.read<RegisterInfoAdCubit>().state;

    province = stateAd.province;
    city = stateAd.city;
    controllerCounRoom.text = stateAd.countRoom.toString();
    controllerMetr.text = stateAd.metr.toString();
    controllerBuildingMetr.text = stateAd.buildingMetr.toString();
    controllerYearBuild.text = stateAd.yearBuild.toString();
    controllerFloor.text = stateAd.floor.toString();
    controllerDocument.text = stateAd.document;
    controllerView.text = stateAd.view;
    metrValueNotifier =
        ValueNotifier<int>(int.tryParse(controllerMetr.text) ?? 0);
    buildingMetrValueNotifier =
        ValueNotifier<int>(int.tryParse(controllerBuildingMetr.text) ?? 0);
    countRoomValueNotifier =
        ValueNotifier<int>(int.tryParse(controllerCounRoom.text) ?? 0);
    floorValueNotifier =
        ValueNotifier<int>(int.tryParse(controllerFloor.text) ?? 0);

    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    final stateAd = context.read<RegisterInfoAdCubit>().state;

    bool result =
        !['اجاره خانه', 'اجاره ویلا', 'فروش خانه', 'فروش ویلا'].contains(title);

    return Scaffold(
      bottomNavigationBar: BlocBuilder<AddAdvertisingBloc, AddAdvertisingState>(
        builder: (context, state) {
          return GestureDetector(
            onTap: () async {
              //Function For Display Id Facilities Item at Collections inforegisteredhomes in DataBase
              String idCt() {
                String idCt = '';

                if (txtTitle == 'اجاره آپارتمان') {
                  idCt = '04lqfn5b7bpiwdm';
                } else if (txtTitle == 'اجاره خانه') {
                  idCt = 'awbiuhrki02leje';
                } else if (txtTitle == 'اجاره ویلا') {
                  idCt = '4m44z8mrvvmqmrb';
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

              //Function For Set idFeatures
              String idFeature() {
                String idFeature = '';
                if (controllerDocument.text == 'وقفی' &&
                    controllerView.text == 'شرقی') {
                  idFeature = '6prs9whayez5ndc';
                } else if (controllerDocument.text == 'شش دانگ' &&
                    controllerView.text == 'شرقی') {
                  idFeature = 'y4nt0dvixr4xcna';
                } else if (controllerDocument.text == 'تک برگ' &&
                    controllerView.text == 'شرقی') {
                  idFeature = 'c756fp5htkh2gno';
                } else if (controllerDocument.text == 'وقفی' &&
                    controllerView.text == 'غربی') {
                  idFeature = 'urmnw7g2c4zegf1';
                } else if (controllerDocument.text == 'شش دانگ' &&
                    controllerView.text == 'غربی') {
                  idFeature = 'xw0low6fmir8sgo';
                } else if (controllerDocument.text == 'تک برگ' &&
                    controllerView.text == 'غربی') {
                  idFeature = 'mj34tvx7hhsm27u';
                } else if (controllerDocument.text == 'وقفی' &&
                    controllerView.text == 'جنوبی') {
                  idFeature = 'jvnz5pbmul5s6oi';
                } else if (controllerDocument.text == 'شش دانگ' &&
                    controllerView.text == 'جنوبی') {
                  idFeature = 'adgv0zg79giyxni';
                } else if (controllerDocument.text == 'تک برگ' &&
                    controllerView.text == 'جنوبی') {
                  idFeature = 'v6ixmhzhqziudho';
                } else if (controllerDocument.text == 'وقفی' &&
                    controllerView.text == 'شمالی') {
                  idFeature = 'io5oqwlgulcgehk';
                } else if (controllerDocument.text == 'شش دانگ' &&
                    controllerView.text == 'شمالی') {
                  idFeature = 'hnrty8b2u4uu2zo';
                } else if (controllerDocument.text == 'تک برگ' &&
                    controllerView.text == 'شمالی') {
                  idFeature = 'nish48ruq5zsisv';
                } else if (controllerDocument.text == 'ندارد' &&
                    controllerView.text == 'شمالی') {
                  idFeature = 'gmxzv044ugckigz';
                } else if (controllerDocument.text == 'ندارد' &&
                    controllerView.text == 'جنوبی') {
                  idFeature = '65ym07y7mwlmy2a';
                } else if (controllerDocument.text == 'ندارد' &&
                    controllerView.text == 'غربی') {
                  idFeature = '01zb7u52n31fi8m';
                } else if (controllerDocument.text == 'ندارد' &&
                    controllerView.text == 'شرقی') {
                  idFeature = '761f4u4nm3qpuzp';
                } else if (controllerDocument.text == 'تک برگ' &&
                    controllerView.text == '') {
                  idFeature = 'oj9ecj5tleyczx8';
                } else if (controllerDocument.text == 'شش دانگ' &&
                    controllerView.text == '') {
                  idFeature = 'oqha6d4la84cy8c';
                } else if (controllerDocument.text == 'وقفی' &&
                    controllerView.text == '') {
                  idFeature = 'gdhpz7funqv0rkf';
                } else if (controllerDocument.text == 'ندارد' &&
                    controllerView.text == '') {
                  idFeature = 'ti012w7mmoyhmw2';
                }
                return idFeature;
              }

              //Check Internet Connection Befor Register Information Ad in the Database
              if (!await checkInternetConnection(context)) {
                return;
              }

              if (title != 'فروش زمین'
                  ? province.isEmpty ||
                      city.isEmpty ||
                      controllerCounRoom.text.isEmpty ||
                      controllerMetr.text.isEmpty ||
                      controllerBuildingMetr.text.isEmpty ||
                      controllerYearBuild.text.isEmpty ||
                      controllerFloor.text.isEmpty ||
                      controllerDocument.text.isEmpty ||
                      controllerView.text.isEmpty
                  : province.isEmpty ||
                      city.isEmpty ||
                      controllerMetr.text.isEmpty ||
                      controllerBuildingMetr.text.isEmpty ||
                      controllerYearBuild.text.isEmpty ||
                      controllerDocument.text.isEmpty) {
                // Display a dialog prompting the user to fill in all fields
                showMessage(
                  MessageSnackBar.compeletFields,
                  context,
                  2,
                );
                return;
              }
              try {
                num metr = num.tryParse(controllerMetr.text) ?? 0;
                num buildingMetr =
                    num.tryParse(controllerBuildingMetr.text) ?? 0;
                num countRoom = num.tryParse(controllerCounRoom.text) ?? 0;
                num floor = num.tryParse(controllerFloor.text) ?? 0;
                num yearBuild = num.tryParse(controllerYearBuild.text) ?? 0;

                context.read<RegisterInfoAdCubit>().setParametrInfoAd(
                      metr: metr,
                      buildingMetr: buildingMetr,
                      countRoom: countRoom,
                      floor: floor,
                      yearBuild: yearBuild,
                      idCt: idCt(),
                      province: province,
                      city: city,
                      idFeature: idFeature(),
                      document: controllerDocument.text,
                      view: controllerView.text,
                    );
                final boolState = context.read<BoolStateCubit>().state;

                if (boolState.isUpdate) {
                  BlocProvider.of<AddAdvertisingBloc>(context).add(
                    UpdateFacilitiesData(
                      boolState.elevator,
                      boolState.parking,
                      boolState.storeroom,
                      boolState.balcony,
                      boolState.penthouse,
                      boolState.duplex,
                      boolState.water,
                      boolState.electricity,
                      boolState.gas,
                      title != 'فروش زمین' ? boolState.floorMaterial : '',
                      title != 'فروش زمین' ? boolState.wc : '',
                    ),
                  );
                } else {
                  BlocProvider.of<AddAdvertisingBloc>(context).add(
                    AddFacilitiesAdvertising(
                      boolState.elevator,
                      boolState.parking,
                      boolState.storeroom,
                      boolState.balcony,
                      boolState.penthouse,
                      boolState.duplex,
                      boolState.water,
                      boolState.electricity,
                      boolState.gas,
                      title != 'فروش زمین' ? boolState.floorMaterial : '',
                      title != 'فروش زمین' ? boolState.wc : '',
                    ),
                  );
                }
                if (state is AddAdvertisingHandleErrorState) {
                  // Display a dialog prompting the user to try again
                  showMessage(
                    MessageSnackBar.tryAgain,
                    context,
                    2,
                  );
                }
                if (title == 'اجاره آپارتمان' ||
                    title == 'اجاره خانه' ||
                    title == 'اجاره ویلا') {
                  BlocProvider.of<NavigationPage>(context)
                      .getNavItems(ViewPage.registerRentHomeAdvertising);
                } else {
                  BlocProvider.of<NavigationPage>(context)
                      .getNavItems(ViewPage.registerHomeAdvertising);
                }
              } catch (e) {
                // Display a dialog prompting the user to if input number invaldi
                showMessage(
                  MessageSnackBar.validNumber,
                  context,
                  2,
                );
              }
            },
            child: Container(
              height: 40,
              margin: const EdgeInsets.only(
                  bottom: 20, top: 15, right: 15, left: 15),
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CustomColor.red,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Text(
                'بعدی',
                textAlign: TextAlign.center,
                style: TextStyle(
                  color: CustomColor.white,
                  fontSize: 16,
                  fontWeight: FontWeight.w600,
                ),
              ),
            ),
          );
        },
      ),
      body: SafeArea(
        child: Center(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: CustomScrollView(
              slivers: [
                SliverToBoxAdapter(
                  child: Column(
                    children: [
                      textTitleSections(
                          txt: 'مشخصات کلی', img: 'images/category-2.png'),
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
                              // Reset the information stored in RegisterInfoAdCubit
                              context
                                  .read<RegisterInfoAdCubit>()
                                  .resetInfoAdSet();
                              // Reset the state of BoolStateCubit
                              context.read<BoolStateCubit>().reset();
                              // Navigate back to the first page
                              context.read<NavigationPage>().backFirstPAge();
                            },
                            child: Column(
                              crossAxisAlignment: CrossAxisAlignment.end,
                              children: [
                                textWidget(
                                  'دسته بندی',
                                  CustomColor.grey500,
                                  14,
                                  FontWeight.w600,
                                ),
                                Container(
                                  width: double.infinity,
                                  height: 48,
                                  margin:
                                      const EdgeInsets.symmetric(vertical: 5),
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
                                      const Icon(
                                        Icons.arrow_back_ios_new_rounded,
                                        size: 28,
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
                              ],
                            ),
                          );
                        },
                      ),
                      Column(
                        crossAxisAlignment: CrossAxisAlignment.end,
                        children: [
                          textWidget(
                            title == 'فروش زمین' ? 'محدوده زمین' : 'محدوده ملک',
                            CustomColor.grey500,
                            14,
                            FontWeight.w600,
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              _selectProvonceAndCity(
                                city.isEmpty ? 'انتخاب شهر' : city,
                                () {
                                  if (province.isNotEmpty) {
                                    final cityName = context
                                        .read<RegisterInfoAdCubit>()
                                        .state;
                                    cityName.city = '';
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) => CityScreen(
                                          isAllCities: false,
                                          province: province,
                                          onChanged: () {
                                            setState(() {
                                              city = cityName.city;
                                            });
                                            if (city.isNotEmpty) {
                                              Navigator.pop(context);
                                            }
                                          },
                                        ),
                                      ),
                                    );
                                  } else {
                                    showMessage(
                                      MessageSnackBar.checkInputProvince,
                                      context,
                                      1,
                                    );
                                  }
                                },
                                city.isEmpty
                                    ? CustomColor.grey500
                                    : CustomColor.black,
                              ),
                              _selectProvonceAndCity(
                                  province.isEmpty ? 'انتخاب استان' : province,
                                  () async {
                                if (!await checkInternetConnection(context)) {
                                  return;
                                }
                                stateAd.province = '';
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) => ScreenProvince(
                                      onChanged: () {
                                        setState(() {
                                          province = stateAd.province;
                                        });
                                        if (province.isNotEmpty) {
                                          Navigator.pop(context);
                                        }
                                      },
                                    ),
                                  ),
                                );
                              },
                                  province.isEmpty
                                      ? CustomColor.grey500
                                      : CustomColor.black),
                            ],
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
                      textTitleSections(
                          txt: 'ویژگی ها', img: 'images/clipboard.png'),
                      Visibility(
                        visible: title == 'فروش زمین',
                        replacement: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceAround,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectBox(
                                  title: 'تعداد اتاق',
                                  color: controllerCounRoom.text != 'null' &&
                                          controllerCounRoom.text != '0'
                                      ? CustomColor.black
                                      : CustomColor.grey500,
                                  onTap: () {
                                    countRoomValueNotifier!.value =
                                        int.tryParse(controllerCounRoom.text) ??
                                            0;
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: CustomColor.grey350,
                                          alignment: Alignment.center,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              const SizedBox(height: 5),
                                              widgetSliderMeterFeature(
                                                listenable:
                                                    countRoomValueNotifier!,
                                                onchanged: (newValue) {
                                                  countRoomValueNotifier!
                                                      .value = newValue.toInt();
                                                },
                                                max: 8,
                                              ),
                                              ValueListenableBuilder<int>(
                                                valueListenable:
                                                    countRoomValueNotifier!,
                                                builder: (context, value, _) {
                                                  return Text(
                                                    '(${value.toString()})اتاق',
                                                    textDirection:
                                                        TextDirection.rtl,
                                                    style: Theme.of(context)
                                                        .textTheme
                                                        .apply(
                                                          fontSizeDelta: 4,
                                                          bodyColor: CustomColor
                                                              .bluegrey,
                                                        )
                                                        .titleMedium,
                                                  );
                                                },
                                              ),
                                              const SizedBox(height: 5),
                                              GestureDetector(
                                                onTap: () {
                                                  Navigator.pop(context, 'OK');
                                                  controllerCounRoom.text =
                                                      countRoomValueNotifier!
                                                          .value
                                                          .toString();
                                                  stateAd.countRoom =
                                                      countRoomValueNotifier!
                                                          .value;
                                                  setState(
                                                    () {},
                                                  );
                                                },
                                                child: Container(
                                                  width: 60,
                                                  height: 35,
                                                  alignment: Alignment.center,
                                                  decoration: BoxDecoration(
                                                    color: CustomColor.white,
                                                    borderRadius:
                                                        BorderRadius.circular(
                                                            5),
                                                  ),
                                                  child: textWidget(
                                                    'تایید',
                                                    CustomColor.bluegrey,
                                                    18,
                                                    FontWeight.w700,
                                                  ),
                                                ),
                                              ),
                                            ],
                                          ),
                                        );
                                      },
                                    );
                                  },
                                  onTapPlus: () {
                                    int count =
                                        int.tryParse(controllerCounRoom.text) ??
                                            0;
                                    setState(() {
                                      if (count >= 8) {
                                        return;
                                      }
                                      count++;
                                      controllerCounRoom.text =
                                          count.toString();
                                      countRoomValueNotifier!.value = count;
                                      stateAd.countRoom =
                                          countRoomValueNotifier!.value;
                                    });
                                  },
                                  onTapMinus: () {
                                    int count =
                                        int.tryParse(controllerCounRoom.text) ??
                                            0;

                                    if (count <= 0) {
                                      return;
                                    }
                                    setState(() {
                                      count--;

                                      controllerCounRoom.text =
                                          count.toString();
                                      countRoomValueNotifier!.value = count;
                                      stateAd.countRoom =
                                          countRoomValueNotifier!.value;
                                    });
                                  },
                                  valueSelected:
                                      controllerCounRoom.text != 'null' &&
                                              controllerCounRoom.text != '0'
                                          ? controllerCounRoom.text
                                          : 'تعیین',
                                ),
                                selectMetrAndDisplay(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectYearBuildAndDisplay(),
                                Visibility(
                                  visible: result,
                                  replacement: selectBuildingMetrAndDisplay(),
                                  child: selectBox(
                                    title: 'طبقه',
                                    color: controllerFloor.text != 'null' &&
                                            controllerFloor.text != '0'
                                        ? CustomColor.black
                                        : CustomColor.grey500,
                                    onTap: () {
                                      showDialog(
                                        context: context,
                                        builder: (context) {
                                          floorValueNotifier!.value =
                                              int.tryParse(
                                                      controllerFloor.text) ??
                                                  0;
                                          return AlertDialog(
                                            backgroundColor:
                                                CustomColor.grey350,
                                            alignment: Alignment.center,
                                            content: Column(
                                              mainAxisSize: MainAxisSize.min,
                                              crossAxisAlignment:
                                                  CrossAxisAlignment.center,
                                              children: [
                                                const SizedBox(height: 5),
                                                widgetSliderMeterFeature(
                                                  listenable:
                                                      floorValueNotifier!,
                                                  onchanged: (newValue) {
                                                    floorValueNotifier!.value =
                                                        newValue.toInt();
                                                  },
                                                  max: 30,
                                                ),
                                                ValueListenableBuilder<int>(
                                                  valueListenable:
                                                      floorValueNotifier!,
                                                  builder: (context, value, _) {
                                                    return Text(
                                                      '(${value.toString()})طبقه',
                                                      textDirection:
                                                          TextDirection.ltr,
                                                      style: Theme.of(context)
                                                          .textTheme
                                                          .apply(
                                                            fontSizeDelta: 4,
                                                            bodyColor:
                                                                CustomColor
                                                                    .bluegrey,
                                                          )
                                                          .titleMedium,
                                                    );
                                                  },
                                                ),
                                                const SizedBox(height: 5),
                                                GestureDetector(
                                                  onTap: () {
                                                    Navigator.pop(
                                                        context, 'OK');
                                                    controllerFloor.text =
                                                        floorValueNotifier!
                                                            .value
                                                            .toString();
                                                    setState(
                                                      () {},
                                                    );
                                                  },
                                                  child: Container(
                                                    width: 60,
                                                    height: 35,
                                                    alignment: Alignment.center,
                                                    decoration: BoxDecoration(
                                                      color: CustomColor.white,
                                                      borderRadius:
                                                          BorderRadius.circular(
                                                              5),
                                                    ),
                                                    child: textWidget(
                                                      'تایید',
                                                      CustomColor.bluegrey,
                                                      18,
                                                      FontWeight.w700,
                                                    ),
                                                  ),
                                                ),
                                              ],
                                            ),
                                          );
                                        },
                                      );
                                    },
                                    onTapPlus: () {
                                      int floor =
                                          int.tryParse(controllerFloor.text) ??
                                              0;
                                      setState(() {
                                        if (floor >= 30) {
                                          return;
                                        }
                                        floor++;
                                        controllerFloor.text = floor.toString();
                                        floorValueNotifier!.value = floor;
                                      });
                                    },
                                    onTapMinus: () {
                                      int floor =
                                          int.tryParse(controllerFloor.text) ??
                                              0;

                                      if (floor <= 0) {
                                        return;
                                      }
                                      setState(() {
                                        floor--;

                                        controllerFloor.text = floor.toString();
                                        floorValueNotifier!.value = floor;
                                      });
                                    },
                                    valueSelected:
                                        controllerFloor.text != 'null' &&
                                                controllerFloor.text != '0'
                                            ? controllerFloor.text
                                            : 'تعیین',
                                  ),
                                ),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectBox(
                                  title: 'جهت ساختمان',
                                  color: controllerView.text.isNotEmpty
                                      ? CustomColor.black
                                      : CustomColor.grey500,
                                  isIconShow: false,
                                  onTap: () async {
                                    await showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          backgroundColor: CustomColor.grey350,
                                          alignment: Alignment.center,
                                          content: Column(
                                            mainAxisSize: MainAxisSize.min,
                                            crossAxisAlignment:
                                                CrossAxisAlignment.center,
                                            children: [
                                              Text(
                                                'جهت ساختمان را انتخاب کنید',
                                                style: TextStyle(
                                                  color: CustomColor.bluegrey,
                                                  fontSize: 15,
                                                ),
                                              ),
                                              const SizedBox(
                                                height: 5,
                                              ),
                                              SizedBox(
                                                height: 150,
                                                child: ListWheelScrollView
                                                    .useDelegate(
                                                  controller:
                                                      _scrollViewController,
                                                  itemExtent: 50,
                                                  squeeze: 0.7,
                                                  childDelegate:
                                                      ListWheelChildBuilderDelegate(
                                                    childCount: view.length,
                                                    builder: (context, index) {
                                                      return GestureDetector(
                                                        onTap: () {
                                                          setState(() {
                                                            controllerView
                                                                    .text =
                                                                view[index];
                                                            stateAd.view =
                                                                controllerView
                                                                    .text;

                                                            //Display Scroll Item last Value selected
                                                            _scrollViewController =
                                                                FixedExtentScrollController(
                                                                    initialItem:
                                                                        index);

                                                            //Navigator Pop For When Selected Item
                                                            Navigator.pop(
                                                                context);
                                                          });
                                                        },
                                                        child: Container(
                                                          width: 100,
                                                          decoration:
                                                              BoxDecoration(
                                                            color: controllerView
                                                                        .text ==
                                                                    view[index]
                                                                ? CustomColor
                                                                    .red
                                                                : CustomColor
                                                                    .white,
                                                            borderRadius:
                                                                BorderRadius
                                                                    .circular(
                                                                        5),
                                                          ),
                                                          alignment:
                                                              Alignment.center,
                                                          child: Text(
                                                            view[index],
                                                            style: Theme.of(
                                                                    context)
                                                                .textTheme
                                                                .apply(
                                                                  fontSizeDelta:
                                                                      10,
                                                                  bodyColor: controllerView
                                                                              .text ==
                                                                          view[
                                                                              index]
                                                                      ? CustomColor
                                                                          .white
                                                                      : CustomColor
                                                                          .bluegrey,
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
                                    ).then(
                                      (value) {
                                        setState(() {});
                                      },
                                    );
                                  },
                                  onTapPlus: () {
                                    setState(() {
                                      if (indexView != 3) {
                                        indexView++;
                                        controllerView.text = view[indexView];
                                      }
                                    });
                                  },
                                  onTapMinus: () {
                                    setState(() {
                                      if (indexView != 0) {
                                        indexView--;
                                        controllerView.text = view[indexView];
                                      }
                                    });
                                  },
                                  valueSelected: controllerView.text.isEmpty
                                      ? 'انتخاب'
                                      : controllerView.text,
                                ),
                                selectDocumnetAndDisplay(),
                              ],
                            ),
                          ],
                        ),
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.spaceBetween,
                          children: [
                            Row(
                              mainAxisAlignment: MainAxisAlignment.spaceBetween,
                              children: [
                                selectYearBuildAndDisplay(),
                                selectMetrAndDisplay(),
                              ],
                            ),
                            Row(
                              mainAxisAlignment: MainAxisAlignment.end,
                              children: [
                                selectDocumnetAndDisplay(),
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
                      textTitleSections(
                          txt: 'امکانات', img: 'images/magicpen.png'),
                    ],
                  ),
                ),
                ItemsSwitchbox(
                  title: title,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Widget For Select Province and City Advertising
  Widget _selectProvonceAndCity(String txt, Function onChanged, Color color) {
    return GestureDetector(
      onTap: () => onChanged(),
      child: Container(
        width: 159,
        height: 48,
        padding: const EdgeInsets.only(right: 5),
        margin: const EdgeInsets.symmetric(vertical: 5),
        decoration: BoxDecoration(
          color: CustomColor.grey350,
          borderRadius: BorderRadius.circular(4),
        ),
        alignment: Alignment.centerRight,
        child: textWidget(
          txt,
          color,
          16,
          FontWeight.w700,
        ),
      ),
    );
  }

//Widget For Display Slider Input Meter Number
  Widget widgetSliderMeterFeature({
    required Function(int newValue) onchanged,
    required double max,
    required ValueListenable<int> listenable,
  }) {
    return ValueListenableBuilder<int>(
      valueListenable: listenable,
      builder: (context, value, _) {
        return Slider(
          value: listenable.value.toDouble(),
          min: 0,
          max: max,
          divisions: max.toInt(),
          thumbColor: CustomColor.red,
          activeColor: CustomColor.pink,
          label: listenable.value.toString(),
          onChanged: (newValue) {
            onchanged(newValue.toInt());
          },
        );
      },
    );
  }

//Widget For Display ListWheel Years Build
  Widget _boxListWheelYears() {
    final stateAd = context.read<RegisterInfoAdCubit>().state;

    return SizedBox(
      height: 150,
      child: ListWheelScrollView.useDelegate(
        controller: _scrollYearController,
        itemExtent: 50,
        squeeze: 0.7,
        childDelegate: ListWheelChildBuilderDelegate(
          childCount: Jalali.now().year - 1340 + 1,
          builder: (context, index) {
            int itemYear = 1340 + index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  year = itemYear;
                  controllerYearBuild.text = year.toString();
                  stateAd.yearBuild = year;
                  _scrollYearController =
                      FixedExtentScrollController(initialItem: index);

                  Navigator.pop(context);
                });
              },
              child: Container(
                width: 100,
                decoration: BoxDecoration(
                  color: controllerYearBuild.text == itemYear.toString()
                      ? CustomColor.red
                      : CustomColor.white,
                  borderRadius: BorderRadius.circular(5),
                ),
                alignment: Alignment.center,
                child: Text(
                  '$itemYear'.toPersianDigit(),
                  style: Theme.of(context)
                      .textTheme
                      .apply(
                        fontSizeDelta: 10,
                        bodyColor:
                            controllerYearBuild.text == itemYear.toString()
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

//Widget For Select RoomCount , Floor & Building Direction
  Widget selectBox({
    required String title,
    required Function() onTap,
    required Function() onTapPlus,
    required Function() onTapMinus,
    required String valueSelected,
    bool? isIconShow,
    required Color color,
  }) {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        textWidget(
          title,
          CustomColor.grey500,
          14,
          FontWeight.w600,
        ),
        GestureDetector(
          onTap: () => onTap(),
          child: Container(
            width: 159,
            height: 48,
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: CustomColor.grey350,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Visibility(
                  visible: isIconShow ?? true,
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      GestureDetector(
                        onTap: () => onTapPlus(),
                        child: const Icon(
                          Icons.arrow_drop_up_rounded,
                          color: CustomColor.red,
                        ),
                      ),
                      GestureDetector(
                        onTap: () => onTapMinus(),
                        child: const Icon(
                          Icons.arrow_drop_down_rounded,
                          color: CustomColor.red,
                        ),
                      ),
                    ],
                  ),
                ),
                const Spacer(),
                Text(
                  valueSelected,
                  style: TextStyle(
                    fontFamily: 'SN',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: color,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//Widget For Select And Display Metr
  Widget selectMetrAndDisplay() {
    final stateAd = context.read<RegisterInfoAdCubit>().state;

    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        textWidget(
          'متراژ زمین',
          CustomColor.grey500,
          14,
          FontWeight.w600,
        ),
        GestureDetector(
          onTap: () {
            metrValueNotifier!.value = int.tryParse(controllerMetr.text) ?? 0;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: CustomColor.grey350,
                alignment: Alignment.center,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    widgetSliderMeterFeature(
                      listenable: metrValueNotifier!,
                      onchanged: (newValue) {
                        metrValueNotifier!.value = newValue.toInt();
                      },
                      max: 1000,
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: metrValueNotifier!,
                      builder: (context, value, _) {
                        return Text(
                          '(${value.toString()})متر',
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context)
                              .textTheme
                              .apply(
                                fontSizeDelta: 4,
                                bodyColor: CustomColor.bluegrey,
                              )
                              .titleMedium,
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'OK');
                        controllerMetr.text =
                            metrValueNotifier!.value.toString();
                        stateAd.metr = metrValueNotifier!.value;
                        setState(
                          () {},
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: textWidget(
                          'تایید',
                          CustomColor.bluegrey,
                          18,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            width: 159,
            height: 48,
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: CustomColor.grey350,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        int metr = int.tryParse(controllerMetr.text) ?? 0;
                        setState(() {
                          if (metr >= 1000) {
                            return;
                          }
                          metr++;
                          controllerMetr.text = metr.toString();
                          metrValueNotifier!.value = metr;
                          stateAd.metr = metrValueNotifier!.value;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_up_rounded,
                        color: CustomColor.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        int metr = int.tryParse(controllerMetr.text) ?? 0;

                        if (metr <= 0) {
                          return;
                        }
                        setState(() {
                          metr--;

                          controllerMetr.text = metr.toString();
                          metrValueNotifier!.value = metr;
                          stateAd.metr = metrValueNotifier!.value;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: CustomColor.red,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  controllerMetr.text != 'null' && controllerMetr.text != '0'
                      ? controllerMetr.text
                      : 'تعیین',
                  style: TextStyle(
                    fontFamily: 'SN',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: controllerMetr.text != 'null' &&
                            controllerMetr.text != '0'
                        ? CustomColor.black
                        : CustomColor.grey500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//Widget For Select And Display BuildingMetr
  Widget selectBuildingMetrAndDisplay() {
    final stateAd = context.read<RegisterInfoAdCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        textWidget(
          'متراژ بنا',
          CustomColor.grey500,
          14,
          FontWeight.w600,
        ),
        GestureDetector(
          onTap: () {
            buildingMetrValueNotifier!.value =
                int.tryParse(controllerBuildingMetr.text) ?? 0;
            showDialog(
              context: context,
              builder: (context) => AlertDialog(
                backgroundColor: CustomColor.grey350,
                alignment: Alignment.center,
                content: Column(
                  mainAxisSize: MainAxisSize.min,
                  crossAxisAlignment: CrossAxisAlignment.center,
                  children: [
                    const SizedBox(height: 5),
                    widgetSliderMeterFeature(
                      listenable: buildingMetrValueNotifier!,
                      onchanged: (newValue) {
                        buildingMetrValueNotifier!.value = newValue.toInt();
                      },
                      max: 1000,
                    ),
                    ValueListenableBuilder<int>(
                      valueListenable: buildingMetrValueNotifier!,
                      builder: (context, value, _) {
                        return Text(
                          '(${value.toString()})متر',
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context)
                              .textTheme
                              .apply(
                                fontSizeDelta: 4,
                                bodyColor: CustomColor.bluegrey,
                              )
                              .titleMedium,
                        );
                      },
                    ),
                    const SizedBox(height: 5),
                    GestureDetector(
                      onTap: () {
                        Navigator.pop(context, 'OK');
                        controllerBuildingMetr.text =
                            buildingMetrValueNotifier!.value.toString();
                        stateAd.buildingMetr = buildingMetrValueNotifier!.value;
                        setState(
                          () {},
                        );
                      },
                      child: Container(
                        width: 60,
                        height: 35,
                        alignment: Alignment.center,
                        decoration: BoxDecoration(
                          color: CustomColor.white,
                          borderRadius: BorderRadius.circular(5),
                        ),
                        child: textWidget(
                          'تایید',
                          CustomColor.bluegrey,
                          18,
                          FontWeight.w700,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
            );
          },
          child: Container(
            width: 159,
            height: 48,
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: CustomColor.grey350,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Column(
                  crossAxisAlignment: CrossAxisAlignment.start,
                  children: [
                    GestureDetector(
                      onTap: () {
                        int buildingMetr =
                            int.tryParse(controllerBuildingMetr.text) ?? 0;
                        setState(() {
                          if (buildingMetr >= 1000) {
                            return;
                          }
                          buildingMetr++;
                          controllerBuildingMetr.text = buildingMetr.toString();
                          buildingMetrValueNotifier!.value = buildingMetr;
                          stateAd.buildingMetr =
                              buildingMetrValueNotifier!.value;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_up_rounded,
                        color: CustomColor.red,
                      ),
                    ),
                    GestureDetector(
                      onTap: () {
                        int buildingMetr =
                            int.tryParse(controllerBuildingMetr.text) ?? 0;

                        if (buildingMetr <= 0) {
                          return;
                        }
                        setState(() {
                          buildingMetr--;

                          controllerBuildingMetr.text = buildingMetr.toString();
                          buildingMetrValueNotifier!.value = buildingMetr;
                          stateAd.buildingMetr =
                              buildingMetrValueNotifier!.value;
                        });
                      },
                      child: const Icon(
                        Icons.arrow_drop_down_rounded,
                        color: CustomColor.red,
                      ),
                    ),
                  ],
                ),
                const Spacer(),
                Text(
                  controllerBuildingMetr.text != 'null' &&
                          controllerBuildingMetr.text != '0'
                      ? controllerBuildingMetr.text
                      : 'تعیین',
                  style: TextStyle(
                    fontFamily: 'SN',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: controllerBuildingMetr.text != 'null' &&
                            controllerBuildingMetr.text != '0'
                        ? CustomColor.black
                        : CustomColor.grey500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//Widget For Select And Display Document
  Widget selectDocumnetAndDisplay() {
    final stateAd = context.read<RegisterInfoAdCubit>().state;
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        textWidget(
          'سند',
          CustomColor.grey500,
          14,
          FontWeight.w600,
        ),
        GestureDetector(
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
                        'سند',
                        style: TextStyle(
                          color: CustomColor.bluegrey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      SizedBox(
                        height: 150,
                        child: ListWheelScrollView.useDelegate(
                          controller: _scrollDocumentController,
                          itemExtent: 50,
                          squeeze: 0.7,
                          childDelegate: ListWheelChildBuilderDelegate(
                            childCount: document.length,
                            builder: (context, index) {
                              return GestureDetector(
                                onTap: () {
                                  setState(() {
                                    controllerDocument.text = document[index];
                                    stateAd.document = controllerDocument.text;

                                    //Display Scroll Item last Value selected
                                    _scrollDocumentController =
                                        FixedExtentScrollController(
                                            initialItem: index);

                                    //Navigator Pop For When Selected Item
                                    Navigator.pop(context);
                                  });
                                },
                                child: Container(
                                  width: 100,
                                  decoration: BoxDecoration(
                                    color: controllerDocument.text ==
                                            document[index]
                                        ? CustomColor.red
                                        : CustomColor.white,
                                    borderRadius: BorderRadius.circular(5),
                                  ),
                                  alignment: Alignment.center,
                                  child: Text(
                                    document[index],
                                    style: Theme.of(context)
                                        .textTheme
                                        .apply(
                                          fontSizeDelta: 8,
                                          bodyColor: controllerDocument.text ==
                                                  document[index]
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
                      ),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            width: 159,
            height: 48,
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: CustomColor.grey350,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  controllerDocument.text.isNotEmpty
                      ? controllerDocument.text
                      : 'انتخاب',
                  style: TextStyle(
                    fontFamily: 'SN',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: controllerDocument.text.isNotEmpty
                        ? CustomColor.black
                        : CustomColor.grey500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }

//Widget For Select And Display YearBuild
  Widget selectYearBuildAndDisplay() {
    return Column(
      crossAxisAlignment: CrossAxisAlignment.end,
      children: [
        textWidget(
          'سال ساخت',
          CustomColor.grey500,
          14,
          FontWeight.w600,
        ),
        GestureDetector(
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
                        'سال ساخت را انتخاب کنید',
                        style: TextStyle(
                          color: CustomColor.bluegrey,
                          fontSize: 15,
                        ),
                      ),
                      const SizedBox(
                        height: 5,
                      ),
                      _boxListWheelYears(),
                    ],
                  ),
                );
              },
            );
          },
          child: Container(
            width: 159,
            height: 48,
            padding: const EdgeInsets.only(right: 10),
            margin: const EdgeInsets.symmetric(vertical: 5),
            decoration: BoxDecoration(
              color: CustomColor.grey350,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              children: [
                Text(
                  controllerYearBuild.text != 'null'
                      ? controllerYearBuild.text
                      : 'انتخاب',
                  style: TextStyle(
                    fontFamily: 'SN',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: controllerYearBuild.text != 'null'
                        ? CustomColor.black
                        : CustomColor.grey500,
                    overflow: TextOverflow.ellipsis,
                  ),
                ),
              ],
            ),
          ),
        ),
      ],
    );
  }
}
