import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc.dart';
import 'package:aviz_project/Bloc/bloc_page_number/page_n_bloc_state.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
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

import '../class/checkconnection.dart';

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

  final TextEditingController controllerCounRoom = TextEditingController();
  final TextEditingController controllerMetr = TextEditingController();
  final TextEditingController controllerYearBuild = TextEditingController();
  final TextEditingController controllerFloor = TextEditingController();
  final TextEditingController controllerAddress = TextEditingController();
  final TextEditingController controllerView = TextEditingController();
  final TextEditingController controllerDocument = TextEditingController();

  OverlayEntry? entry;

  String? txtTitle;
  String title = '';

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
    year = currentYear.year;
    itemYear = List.generate(yearLength, (index) {});
    final stateAd = context.read<RegisterInfoAdCubit>().state;

    controllerAddress.text = stateAd.address;
    controllerCounRoom.text = stateAd.countRoom.toString();
    controllerMetr.text = stateAd.metr.toString();
    controllerYearBuild.text = stateAd.yearBuild.toString();
    controllerFloor.text = stateAd.floor.toString();
    controllerDocument.text = stateAd.document;
    controllerView.text = stateAd.view;

    super.initState();

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
            offset: Offset(0, size.height / 12),
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
                    Row(
                      children: [
                        Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            textWidget(
                              title == 'فروش زمین'
                                  ? 'محدوده زمین'
                                  : 'محدوده ملک',
                              CustomColor.grey500,
                              14,
                              FontWeight.w600,
                            ),
                            Container(
                              width: 159,
                              height: 48,
                              padding: const EdgeInsets.only(right: 5),
                              margin: const EdgeInsets.symmetric(vertical: 5),
                              decoration: BoxDecoration(
                                color: CustomColor.grey350,
                                borderRadius: BorderRadius.circular(4),
                              ),
                              alignment: Alignment.center,
                              child: TextField(
                                controller: controllerAddress,
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
                                    controllerAddress.text = value;
                                  });
                                },
                                onTapOutside: (event) {
                                  focusNode1.unfocus();
                                },
                              ),
                            ),
                          ],
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
                                    entry?.remove();
                                    entry = null;
                                  }
                                });
                              },
                              child: CompositedTransformTarget(
                                link: layerLink,
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
                                      width: 159,
                                      height: 48,
                                      margin: const EdgeInsets.symmetric(
                                          vertical: 5),
                                      decoration: BoxDecoration(
                                        border: Border.all(
                                            color: CustomColor.grey350),
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
                                                ? Icons
                                                    .keyboard_arrow_down_rounded
                                                : Icons
                                                    .keyboard_arrow_up_rounded,
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
                                  ],
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
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              TextfieldFeature(
                                controller: controllerCounRoom,
                                title: 'تعداد اتاق',
                                value:
                                    num.tryParse(controllerCounRoom.text) ?? 0,
                                textInputAction: TextInputAction.done,
                              ),
                              selectDocument(
                                title: 'متراژ',
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: CustomColor.grey350,
                                      alignment: Alignment.center,
                                      content: StatefulBuilder(
                                        builder: (context, setState) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'متراژ را وارد کنید',
                                              style: TextStyle(
                                                color: CustomColor.bluegrey,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            widgetSliderMeterFeature(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                onTapPlus: () {
                                  int metr =
                                      int.tryParse(controllerMetr.text) ?? 0;
                                  setState(() {
                                    if (metr >= 1000) {
                                      return;
                                    }
                                    metr++;
                                    controllerMetr.text = metr.toString();
                                  });
                                },
                                onTapMinus: () {
                                  int metr =
                                      int.tryParse(controllerMetr.text) ?? 0;
                                  if (metr <= 0) {
                                    return;
                                  }
                                  setState(() {
                                    metr--;

                                    controllerMetr.text = metr.toString();
                                  });
                                },
                                valueSelected: controllerMetr.text != 'null'
                                    ? controllerMetr.text
                                    : '',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectDocument(
                                title: 'سال ساخت',
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
                                onTapPlus: () {
                                  setState(() {
                                    if (year == Jalali.now().year) {
                                      return;
                                    }
                                    year++;
                                    controllerYearBuild.text = year.toString();
                                  });
                                },
                                onTapMinus: () {
                                  if (year <= 1340) {
                                    return;
                                  }
                                  setState(() {
                                    year--;

                                    controllerYearBuild.text = year.toString();
                                  });
                                },
                                valueSelected:
                                    controllerYearBuild.text != 'null'
                                        ? controllerYearBuild.text
                                        : '',
                              ),
                              TextfieldFeature(
                                controller: controllerFloor,
                                title: 'طبقه',
                                value: num.tryParse(controllerFloor.text) ?? 0,
                                textInputAction: TextInputAction.done,
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.spaceBetween,
                            children: [
                              selectDocument(
                                title: 'جهت ساختمان',
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
                                                controller: _scrollController,
                                                itemExtent: 50,
                                                squeeze: 0.7,
                                                childDelegate:
                                                    ListWheelChildBuilderDelegate(
                                                  childCount: view.length,
                                                  builder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        final stateAd = context
                                                            .read<
                                                                RegisterInfoAdCubit>()
                                                            .state;
                                                        setState(() {
                                                          controllerView.text =
                                                              view[index];
                                                          stateAd.view =
                                                              controllerView
                                                                  .text;

                                                          //Display Scroll Item last Value selected
                                                          _scrollController =
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
                                                              ? CustomColor.red
                                                              : CustomColor
                                                                  .white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          view[index],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .apply(
                                                                    fontSizeDelta:
                                                                        10,
                                                                    bodyColor: controllerView.text ==
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
                                valueSelected: controllerView.text,
                              ),
                              selectDocument(
                                title: 'سند',
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
                                              child: ListWheelScrollView
                                                  .useDelegate(
                                                controller: _scrollController,
                                                itemExtent: 50,
                                                squeeze: 0.7,
                                                childDelegate:
                                                    ListWheelChildBuilderDelegate(
                                                  childCount: document.length,
                                                  builder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        final stateAd = context
                                                            .read<
                                                                RegisterInfoAdCubit>()
                                                            .state;
                                                        setState(() {
                                                          controllerDocument
                                                                  .text =
                                                              document[index];
                                                          stateAd.document =
                                                              controllerDocument
                                                                  .text;

                                                          //Display Scroll Item last Value selected
                                                          _scrollController =
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
                                                          color:
                                                              controllerDocument
                                                                          .text ==
                                                                      document[
                                                                          index]
                                                                  ? CustomColor
                                                                      .red
                                                                  : CustomColor
                                                                      .white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          document[index],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .apply(
                                                                    fontSizeDelta:
                                                                        8,
                                                                    bodyColor: controllerDocument.text ==
                                                                            document[
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
                                  );
                                },
                                onTapPlus: () {
                                  setState(() {
                                    if (indexDocument != 2) {
                                      indexDocument++;
                                      controllerDocument.text =
                                          document[indexDocument];
                                    }
                                  });
                                },
                                onTapMinus: () {
                                  setState(() {
                                    if (indexDocument != 0) {
                                      indexDocument--;
                                      controllerDocument.text =
                                          document[indexDocument];
                                    }
                                  });
                                },
                                valueSelected: controllerDocument.text,
                              ),
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
                              selectDocument(
                                title: 'سال ساخت',
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
                                onTapPlus: () {
                                  setState(() {
                                    if (year == Jalali.now().year) {
                                      return;
                                    }
                                    year++;
                                    controllerYearBuild.text = year.toString();
                                  });
                                },
                                onTapMinus: () {
                                  if (year <= 1340) {
                                    return;
                                  }
                                  setState(() {
                                    year--;

                                    controllerYearBuild.text = year.toString();
                                  });
                                },
                                valueSelected:
                                    controllerYearBuild.text != 'null'
                                        ? controllerYearBuild.text
                                        : '',
                              ),
                              selectDocument(
                                title: 'متراژ',
                                onTap: () {
                                  showDialog(
                                    context: context,
                                    builder: (context) => AlertDialog(
                                      backgroundColor: CustomColor.grey350,
                                      alignment: Alignment.center,
                                      content: StatefulBuilder(
                                        builder: (context, setState) => Column(
                                          mainAxisSize: MainAxisSize.min,
                                          crossAxisAlignment:
                                              CrossAxisAlignment.center,
                                          children: [
                                            Text(
                                              'متراژ را وارد کنید',
                                              style: TextStyle(
                                                color: CustomColor.bluegrey,
                                                fontSize: 15,
                                              ),
                                            ),
                                            const SizedBox(height: 5),
                                            widgetSliderMeterFeature(),
                                          ],
                                        ),
                                      ),
                                    ),
                                  ).then(
                                    (value) {
                                      setState(() {});
                                    },
                                  );
                                },
                                onTapPlus: () {
                                  int metr =
                                      int.tryParse(controllerMetr.text) ?? 0;
                                  setState(() {
                                    if (metr >= 1000) {
                                      return;
                                    }
                                    metr++;
                                    controllerMetr.text = metr.toString();
                                  });
                                },
                                onTapMinus: () {
                                  int metr =
                                      int.tryParse(controllerMetr.text) ?? 0;
                                  if (metr <= 0) {
                                    return;
                                  }
                                  setState(() {
                                    metr--;

                                    controllerMetr.text = metr.toString();
                                  });
                                },
                                valueSelected: controllerMetr.text != 'null'
                                    ? controllerMetr.text
                                    : '',
                              ),
                            ],
                          ),
                          Row(
                            mainAxisAlignment: MainAxisAlignment.end,
                            children: [
                              selectDocument(
                                title: 'سند',
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
                                              child: ListWheelScrollView
                                                  .useDelegate(
                                                controller: _scrollController,
                                                itemExtent: 50,
                                                squeeze: 0.7,
                                                childDelegate:
                                                    ListWheelChildBuilderDelegate(
                                                  childCount: document.length,
                                                  builder: (context, index) {
                                                    return GestureDetector(
                                                      onTap: () {
                                                        final stateAd = context
                                                            .read<
                                                                RegisterInfoAdCubit>()
                                                            .state;
                                                        setState(() {
                                                          controllerDocument
                                                                  .text =
                                                              document[index];
                                                          stateAd.document =
                                                              controllerDocument
                                                                  .text;

                                                          //Display Scroll Item last Value selected
                                                          _scrollController =
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
                                                          color:
                                                              controllerDocument
                                                                          .text ==
                                                                      document[
                                                                          index]
                                                                  ? CustomColor
                                                                      .red
                                                                  : CustomColor
                                                                      .white,
                                                          borderRadius:
                                                              BorderRadius
                                                                  .circular(5),
                                                        ),
                                                        alignment:
                                                            Alignment.center,
                                                        child: Text(
                                                          document[index],
                                                          style:
                                                              Theme.of(context)
                                                                  .textTheme
                                                                  .apply(
                                                                    fontSizeDelta:
                                                                        8,
                                                                    bodyColor: controllerDocument.text ==
                                                                            document[
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
                                  );
                                },
                                onTapPlus: () {
                                  setState(() {
                                    if (indexDocument != 3) {
                                      indexDocument++;
                                      controllerDocument.text =
                                          document[indexDocument];
                                    }
                                  });
                                },
                                onTapMinus: () {
                                  setState(() {
                                    if (indexDocument > 0) {
                                      indexDocument--;
                                      controllerDocument.text =
                                          document[indexDocument];
                                    }
                                  });
                                },
                                valueSelected: controllerDocument.text,
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
                    () async {
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
                          ? controllerAddress.text.isEmpty ||
                              controllerCounRoom.text.isEmpty ||
                              controllerMetr.text.isEmpty ||
                              controllerYearBuild.text.isEmpty ||
                              controllerFloor.text.isEmpty ||
                              controllerDocument.text.isEmpty ||
                              controllerView.text.isEmpty
                          : controllerAddress.text.isEmpty ||
                              controllerMetr.text.isEmpty ||
                              controllerYearBuild.text.isEmpty ||
                              controllerDocument.text.isEmpty) {
                        displayDialog(
                            'لطفا تمامی فیلد ها را کامل کنید', context);
                        return;
                      }
                      try {
                        num metr = num.tryParse(controllerMetr.text) ?? 0;
                        num countRoom =
                            num.tryParse(controllerCounRoom.text) ?? 0;
                        num floor = num.tryParse(controllerFloor.text) ?? 0;
                        num yearBuild =
                            num.tryParse(controllerYearBuild.text) ?? 0;

                        context.read<RegisterInfoAdCubit>().setParametrInfoAd(
                              metr: metr,
                              countRoom: countRoom,
                              floor: floor,
                              yearBuild: yearBuild,
                              idCt: idCt(),
                              address: controllerAddress.text,
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
                              title != 'فروش زمین'
                                  ? boolState.floorMaterial
                                  : '',
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
                              title != 'فروش زمین'
                                  ? boolState.floorMaterial
                                  : '',
                              title != 'فروش زمین' ? boolState.wc : '',
                            ),
                          );
                        }

                        BlocProvider.of<NavigationPage>(context)
                            .getNavItems(ViewPage.registerHomeAdvertising);
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

//Widget For Display Slider Input Meter Number
  Widget widgetSliderMeterFeature() {
    return StatefulBuilder(
      builder: (context, setState) => Slider(
        value: double.tryParse(controllerMetr.text) ?? 0.0,
        min: 0,
        max: 1000,
        divisions: 1000,
        thumbColor: CustomColor.red,
        activeColor: CustomColor.pink,
        label: controllerMetr.text,
        onChanged: (value) {
          setState(() {
            metr = value.toInt();
            controllerMetr.text = value.toInt().toString();
          });
        },
      ),
    );
  }

//Widget For Display Widget widgetSliderMeterFeature And Change Number
  Widget widgetBoxMetrFeature(
    BuildContext context,
    Widget widget,
    TextEditingController controller,
    String title,
  ) {
    int metr = int.tryParse(controllerMetr.text) ?? 0;
    if (controllerMetr.text == 'null') {
      controllerMetr.text = '';
    }

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
        setState(() {});
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: 159,
              height: 48,
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: CustomColor.grey350,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (metr >= 1000) {
                              return;
                            }
                            metr++;
                            controllerMetr.text = metr.toString();
                          });
                        },
                        child: const Icon(
                          Icons.arrow_drop_up_rounded,
                          color: CustomColor.red,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (metr <= 0) {
                            return;
                          }
                          setState(() {
                            metr--;

                            controllerMetr.text = metr.toString();
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
                  SizedBox(
                    width: 110,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controllerMetr,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'SN',
                        fontSize: 16,
                        color: CustomColor.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            metr = int.parse(val);
                            controllerMetr.text = val;
                          });
                        } else {
                          val = '';
                          metr = 0;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
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

//Widget For Display Widget widgetBoxYearBuildFeature And Change Number Year
  Widget widgetBoxYearBuildFeature(
    BuildContext context,
    Widget widget,
    TextEditingController controller,
    String title,
  ) {
    int year = int.tryParse(controllerYearBuild.text) ?? 1340;
    if (controllerYearBuild.text == 'null') {
      controllerYearBuild.text = '';
    }

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
      },
      child: Stack(
        alignment: Alignment.centerRight,
        children: [
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 10),
            child: Container(
              width: 159,
              height: 48,
              padding: const EdgeInsets.only(right: 10),
              decoration: BoxDecoration(
                color: CustomColor.grey350,
                borderRadius: BorderRadius.circular(4),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.spaceBetween,
                children: [
                  Column(
                    children: [
                      GestureDetector(
                        onTap: () {
                          setState(() {
                            if (year == Jalali.now().year) {
                              return;
                            }
                            year++;
                            controllerYearBuild.text = year.toString();
                          });
                        },
                        child: const Icon(
                          Icons.arrow_drop_up_rounded,
                          color: CustomColor.red,
                        ),
                      ),
                      GestureDetector(
                        onTap: () {
                          if (year <= 1340) {
                            return;
                          }
                          setState(() {
                            year--;

                            controllerYearBuild.text = year.toString();
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
                  SizedBox(
                    width: 110,
                    child: TextField(
                      keyboardType: TextInputType.number,
                      controller: controllerYearBuild,
                      textAlign: TextAlign.end,
                      style: const TextStyle(
                        fontFamily: 'SN',
                        fontSize: 16,
                        color: CustomColor.black,
                        overflow: TextOverflow.ellipsis,
                      ),
                      decoration: const InputDecoration(
                        enabledBorder: InputBorder.none,
                        focusedBorder: InputBorder.none,
                      ),
                      onChanged: (val) {
                        if (val.isNotEmpty) {
                          setState(() {
                            year = int.parse(val);
                            controllerYearBuild.text = val;
                          });
                        } else {
                          val = '';
                          year = 0;
                        }
                      },
                    ),
                  ),
                ],
              ),
            ),
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
          childCount: Jalali.now().year - 1340 + 1,
          builder: (context, index) {
            int itemYear = 1340 + index;

            return GestureDetector(
              onTap: () {
                setState(() {
                  year = itemYear;
                  controllerYearBuild.text = year.toString();

                  _scrollController =
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

//Widget For Select Document
  Widget selectDocument({
    required String title,
    required Function onTap,
    required Function onTapPlus,
    required Function onTapMinus,
    required String valueSelected,
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
                Column(
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
                const Spacer(),
                Text(
                  valueSelected,
                  style: const TextStyle(
                    fontFamily: 'SN',
                    fontSize: 16,
                    fontWeight: FontWeight.w700,
                    color: CustomColor.black,
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
