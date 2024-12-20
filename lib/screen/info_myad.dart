import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';

import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_bloc.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_event.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_state.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_event.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_state.dart';
import 'package:aviz_project/Hive/Advertising/register_id.dart';
import 'package:aviz_project/class/scaffoldmessage.dart';
import 'package:aviz_project/extension/price_extension.dart';
import 'package:aviz_project/screen/warning.dart';
import 'package:aviz_project/widgets/displayreconnection.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';
import 'package:url_launcher/url_launcher.dart';

import '../DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import '../DataFuture/ad_details/Bloc/detail_ad_event.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import '../DataFuture/search/Bloc/search_bloc.dart';
import '../class/colors.dart';

import '../extension/constraintboxsize.dart';
import '../main.dart';
import '../widgets/advertising_facilities_features.dart';
import '../widgets/interactiveimage.dart';
import '../widgets/text_widget.dart';
import 'dart:ui' as ui;

// ignore: must_be_immutable
class InformatioMyAdvertising extends StatefulWidget with RouteAware {
  InformatioMyAdvertising({
    super.key,
    required this.advertisingHome,
    required this.isDelete,
  });
  RegisterFutureAd advertisingHome;
  final bool isDelete;
  @override
  State<InformatioMyAdvertising> createState() =>
      _InformatioMyAdvertisingState();
}

class _InformatioMyAdvertisingState extends State<InformatioMyAdvertising>
    with RouteAware {
  @override
  void didChangeDependencies() {
    super.didChangeDependencies();
    final route = ModalRoute.of(context);
    if (route is PageRoute) {
      routeObserver.subscribe(this, route);
    }
  }

  @override
  void dispose() {
    routeObserver.unsubscribe(this);
    super.dispose();
  }

  @override
  void didPop() {
    context.read<SaveAdBloc>().add(GetInitializedSaveDataEvent());
  }

  //List for display information horizontal category
  List<ContainerInfo> listText = [
    ContainerInfo('مشخصات', true, 0),
    ContainerInfo('قیمت', false, 1),
    ContainerInfo('ویژگی ها و امکانات', false, 2),
    ContainerInfo('توضیحات', false, 3),
  ];

  String? saveId;
  int indexContainer = 0;

  bool isSaved = false;
  bool isError = true;

  PageController controller =
      PageController(viewportFraction: 0.9, initialPage: 0);

  // Function to calculate and display the time difference between the ad creation and the current time
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

  String categoryTitle = '';

  @override
  void initState() {
    context.read<AdExistsBloc>().add(
          SearchWithIdData(
            id: widget.advertisingHome.id,
          ),
        );
    context.read<SaveAdBloc>().add(
          ExistsSaveAdEvent(
            Authmanager().getId(),
            widget.advertisingHome.id,
          ),
        );
    context.read<SaveAdBloc>().add(
          GetInitializedExistsSaveDataEvent(),
        );

    super.initState();
    categoryType();
  }

  void _toggleSaveStatus() async {
    if (isSaved) {
      context
          .read<SaveAdBloc>()
          .add(DeleteSaveAdEvent(saveId ?? RegisterId().getSaveId()));
    } else {
      context
          .read<SaveAdBloc>()
          .add(PostSaveAdEvent(widget.advertisingHome.id));
    }
    context.read<SaveAdBloc>().add(
          ExistsSaveAdEvent(
            Authmanager().getId(),
            widget.advertisingHome.id,
          ),
        );
  }

  // Function to return category title based on categoryId
  String categoryType() {
    switch (widget.advertisingHome.categoryId) {
      case '04lqfn5b7bpiwdm':
        categoryTitle = 'اجاره آپارتمان';
        break;
      case 'awbiuhrki02leje':
        categoryTitle = 'اجاره خانه';
        break;
      case '4m44z8mrvvmqmrb':
        categoryTitle = 'اجاره ویلا';
        break;
      case 'daxmo7fipbo5xnc':
        categoryTitle = 'فروش آپارتمان';
        break;
      case 'zlbqbrywl9f0b92':
        categoryTitle = 'فروش خانه';
        break;
      case 'egylfeay2tn1hxn':
        categoryTitle = 'فروش ویلا';
        break;
      case '7ost8r7msw8lt0c':
        categoryTitle = 'فروش زمین';
        break;
    }
    return categoryTitle;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: Center(
        child: ConstrainedBox(
          constraints: const BoxConstraints().constrainstSize(),
          child: BlocConsumer<AdExistsBloc, SearchState>(
            listener: (context, state) {
              if (state is SearchExistsRequestSuccessState) {
                state.getExistAd.fold(
                  (l) {
                    setState(() {
                      isError = true;
                    });
                  },
                  (r) {
                    setState(() {
                      isError = false;
                    });
                  },
                );
              }
            },
            builder: (context, state) {
              if (state is SearchHandleErrorState) {
                return DisplayReconnection(screen: 'وجود آگهی');
              } else if (state is SearchLoadingState) {
                return const Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.normalRed,
                    strokeWidth: 3,
                  ),
                );
              } else if (state is SearchExistsRequestSuccessState) {
                return state.getExistAd.fold(
                  (l) {
                    return Scaffold(
                      appBar: AppBar(
                        automaticallyImplyLeading: false,
                        actions: [
                          Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            child: GestureDetector(
                              onTap: () {
                                Navigator.pop(context);
                              },
                              child: const Icon(
                                Icons.arrow_forward_ios_rounded,
                              ),
                            ),
                          ),
                        ],
                      ),
                      body: SafeArea(
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            Center(
                              child: Image.asset(
                                'images/bad_result.png',
                                scale: 2,
                              ),
                            ),
                            const SizedBox(
                              height: 8,
                            ),
                            textWidget(
                              'آگهی مورد نظر پاک شده است',
                              CustomColor.black,
                              18,
                              FontWeight.normal,
                            ),
                          ],
                        ),
                      ),
                    );
                  },
                  (r) {
                    return Scaffold(
                      bottomNavigationBar: buttonCallAndSmsUser(
                        context: context,
                        advertising: widget.advertisingHome,
                      ),
                      appBar: AppBar(
                        elevation: 0,
                        scrolledUnderElevation: 0,
                        automaticallyImplyLeading: false,
                        leadingWidth: double.maxFinite,
                        leading: Padding(
                          padding: const EdgeInsets.symmetric(horizontal: 15),
                          child: Row(
                            children: [
                              BlocConsumer<SaveAdBloc, SaveAdState>(
                                listener: (context, state) {
                                  if (state is GetExistsSaveState) {
                                    state.getSaveAd.fold(
                                      (l) {},
                                      (r) {
                                        bool isSavedAd = r.any((item) =>
                                            item.idAd ==
                                            widget.advertisingHome.id);
                                        saveId = isSavedAd
                                            ? r
                                                .firstWhere((item) =>
                                                    item.idAd ==
                                                    widget.advertisingHome.id)
                                                .id
                                            : null;
                                      },
                                    );
                                  }
                                  if (state is ExistsSaveAdState) {
                                    state.existsSaveAd.fold(
                                      (l) {
                                        setState(() {
                                          isSaved = false;
                                        });
                                      },
                                      (r) {
                                        setState(() {
                                          if (r.isNotEmpty) {
                                            isSaved = true;
                                          }
                                        });
                                      },
                                    );
                                  } else if (state is PostSaveAdState) {
                                    state.postSaveAd.fold(
                                      (l) => showMessage(
                                          MessageSnackBar.tryAgain, context, 1),
                                      (r) {
                                        showMessage(
                                            MessageSnackBar.saveAd, context, 1);
                                        setState(() {
                                          isSaved = true;
                                        });
                                      },
                                    );
                                  } else if (state is DeleteSaveAdState) {
                                    state.deleteSaveAd.fold(
                                      (l) => showMessage(
                                          MessageSnackBar.tryAgain, context, 1),
                                      (r) {
                                        showMessage(
                                            MessageSnackBar.deleteSaveAd,
                                            context,
                                            1);
                                        setState(() {
                                          isSaved = false;
                                        });
                                      },
                                    );
                                  }
                                },
                                builder: (context, state) => GestureDetector(
                                  onTap: _toggleSaveStatus,
                                  child: isError
                                      ? const SizedBox.shrink()
                                      : state is SaveLoadingState
                                          ? const SizedBox(
                                              height: 20,
                                              width: 20,
                                              child: CircularProgressIndicator(
                                                color: CustomColor.normalRed,
                                                strokeWidth: 3,
                                              ),
                                            )
                                          : Image.asset(
                                              isSaved
                                                  ? 'images/save_full.png'
                                                  : 'images/save_vacant.png',
                                              scale: 5,
                                            ),
                                ),
                              ),
                              const SizedBox(
                                width: 6,
                              ),
                              Visibility(
                                visible: widget.isDelete,
                                child: GestureDetector(
                                  onTap: () async {
                                    showDialog(
                                      context: context,
                                      builder: (context) {
                                        return AlertDialog(
                                          alignment: Alignment.center,
                                          actionsAlignment:
                                              MainAxisAlignment.center,
                                          backgroundColor:
                                              CustomColor.bluegrey50,
                                          title: const Text(
                                            'آیا آگهی مورد نظر حذف شود؟',
                                            textAlign: TextAlign.center,
                                            style: TextStyle(
                                              fontWeight: FontWeight.w700,
                                              fontFamily: 'SM',
                                              fontSize: 20,
                                              color: CustomColor.black,
                                            ),
                                          ),
                                          actions: [
                                            TextButton(
                                              onPressed: () {
                                                Navigator.pop(context, 'OK');
                                              },
                                              style: ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        CustomColor.grey500),
                                              ),
                                              child: Text(
                                                'خیر',
                                                style: TextStyle(
                                                  color: CustomColor.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'SM',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                            TextButton(
                                              onPressed: () {
                                                context
                                                    .read<AddAdvertisingBloc>()
                                                    .add(DeleteAdvertisingData(
                                                      idAd: widget
                                                          .advertisingHome.id,
                                                      idAdFacilities: widget
                                                          .advertisingHome
                                                          .idFacilities,
                                                      idAdGallery: widget
                                                          .advertisingHome
                                                          .idGallery,
                                                    ));
                                                Navigator.pop(context);
                                                Navigator.pop(context);
                                              },
                                              style: const ButtonStyle(
                                                backgroundColor:
                                                    WidgetStatePropertyAll(
                                                        CustomColor.red),
                                              ),
                                              child: Text(
                                                'بله',
                                                style: TextStyle(
                                                  color: CustomColor.white,
                                                  fontWeight: FontWeight.bold,
                                                  fontFamily: 'SM',
                                                  fontSize: 18,
                                                ),
                                              ),
                                            ),
                                          ],
                                        );
                                      },
                                    );
                                  },
                                  child: Image.asset(
                                    'images/delete.png',
                                    scale: 4.5,
                                  ),
                                ),
                              ),
                              const Spacer(),
                              GestureDetector(
                                onTap: () {
                                  Navigator.pop(context);
                                },
                                child: const Icon(
                                  Icons.arrow_forward_ios_rounded,
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
                                  mainAxisAlignment:
                                      MainAxisAlignment.spaceBetween,
                                  children: [
                                    textWidget(
                                      '${_createADTime(DateTime.parse(widget.advertisingHome.created))} در ${widget.advertisingHome.province}،${widget.advertisingHome.city}',
                                      CustomColor.grey500,
                                      14,
                                      FontWeight.w400,
                                    ),
                                    Container(
                                      height: 29,
                                      padding: const EdgeInsets.symmetric(
                                          horizontal: 6),
                                      alignment: Alignment.center,
                                      decoration: BoxDecoration(
                                        borderRadius: BorderRadius.circular(4),
                                        color: CustomColor.grey200,
                                      ),
                                      child: textWidget(
                                        categoryType(),
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
                                  widget.advertisingHome.titlehome,
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
                                child: GestureDetector(
                                  onTap: () {
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const WarningScreen(),
                                      ),
                                    );
                                  },
                                  child: Container(
                                    height: 40,
                                    margin:
                                        const EdgeInsets.symmetric(vertical: 8),
                                    padding: const EdgeInsets.symmetric(
                                        horizontal: 8),
                                    alignment: Alignment.center,
                                    decoration: BoxDecoration(
                                      border: Border.all(
                                          color: CustomColor.grey350),
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Row(
                                      mainAxisAlignment:
                                          MainAxisAlignment.spaceBetween,
                                      children: [
                                        Icon(
                                          Icons.arrow_back_ios_rounded,
                                          color: CustomColor.grey350,
                                        ),
                                        const Spacer(),
                                        textWidget(
                                          'هشدار های قبل از معامله!',
                                          CustomColor.black,
                                          16,
                                          FontWeight.w500,
                                        ),
                                        const SizedBox(
                                          width: 10,
                                        ),
                                      ],
                                    ),
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 20,
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: LayoutBuilder(
                                  builder: (context, constraints) {
                                    return SizedBox(
                                      height: 30,
                                      child: ListView.builder(
                                        scrollDirection: Axis.horizontal,
                                        reverse: true,
                                        itemCount: listText.length,
                                        itemBuilder: (context, index) {
                                          double horizontalMargin =
                                              constraints.maxWidth <= 1200
                                                  ? 8.0
                                                  : 16.0;

                                          return GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                for (int i = 0;
                                                    i < listText.length;
                                                    i++) {
                                                  listText[i].selected =
                                                      (i == index);
                                                  indexContainer = index;
                                                }
                                              });
                                            },
                                            child: Container(
                                              height: 29,
                                              constraints: const BoxConstraints(
                                                maxWidth: 135,
                                              ),
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 12),
                                              margin: EdgeInsets.only(
                                                left: index == 0
                                                    ? horizontalMargin
                                                    : 8.0,
                                              ),
                                              alignment: Alignment.center,
                                              decoration: BoxDecoration(
                                                borderRadius:
                                                    BorderRadius.circular(4),
                                                border: Border.all(
                                                  color:
                                                      listText[index].selected
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
                                          );
                                        },
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(
                                  height: 25,
                                ),
                              ),
                              _changeBoxContainer(
                                indexContainer,
                                widget.advertisingHome,
                                categoryTitle,
                              ),
                            ],
                          ),
                        ),
                      ),
                    );
                  },
                );
              } else {
                return const SizedBox.shrink();
              }
            },
          ),
        ),
      ),
    );
  }

  //Button for Call Or SMS to User Created Advertising
  Widget buttonCallAndSmsUser({
    required BuildContext context,
    required RegisterFutureAd advertising,
  }) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30,
                      height: 6,
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        color: CustomColor.grey300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Text(
                      'اطلاعات تماس',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.grey500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    callInformation(
                      onTap: () {
                        callAction(advertising.phoneNumber, context);
                      },
                      callInfo: '${advertising.phoneNumber} :تماس تلفنی با ',
                      icon: Icons.phone_enabled_outlined,
                    ),
                    callInformation(
                      onTap: () {
                        smsAction(advertising.phoneNumber, context);
                      },
                      callInfo: '${advertising.phoneNumber} :ارسال پیامک به',
                      icon: Icons.message_rounded,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 40,
        transformAlignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 15, top: 25, right: 15, left: 15),
        decoration: BoxDecoration(
          color: CustomColor.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget(
              'اطلاعات تماس',
              CustomColor.grey,
              16,
              FontWeight.w500,
            ),
            const SizedBox(
              width: 12,
            ),
            Image.asset('images/call_icon.png')
          ],
        ),
      ),
    );
  }

//Method for Call Advertising User
  Future<void> callAction(
    String pNumber,
    BuildContext context,
  ) async {
    var url = Uri.parse('tel:$pNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showMessage(MessageSnackBar.tryAgain, context, 1);
    }
  }

//Method for Send SMS Advertising User
  Future<void> smsAction(
    String pNumber,
    BuildContext context,
  ) async {
    var url = Uri.parse('sms:$pNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showMessage(MessageSnackBar.tryAgain, context, 1);
    }
  }

//Widget for Display User Call Information
  Widget callInformation({
    required Function() onTap,
    required String callInfo,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.centerRight,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.normalRed,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              callInfo,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              icon,
              color: CustomColor.white,
            ),
          ],
        ),
      ),
    );
  }
}

// Function to switch and display different widgets based on selected category
_changeBoxContainer(
  int index,
  RegisterFutureAd adHome,
  String categoryType,
) {
  switch (index) {
    case 0:
      return SliverToBoxAdapter(
          child: SpecificationBox(advertisingHome: adHome));

    case 1:
      return SliverToBoxAdapter(
          child: PriceInfoWidget(
        advertisingHome: adHome,
        categoryType: categoryType,
      ));
    case 2:
      return SliverToBoxAdapter(
        child: AdvertisingFacilitiesWidget(
          advertisingHome: adHome,
        ),
      );
    case 3:
      return SliverToBoxAdapter(
          child: _advertisingDescription(advertisingHome: adHome));

    default:
      return SliverToBoxAdapter(
          child: SpecificationBox(advertisingHome: adHome));
  }
}

//Class for insert information horizontal list category
class ContainerInfo {
  String text;
  bool selected;
  int index;
  ContainerInfo(this.text, this.selected, this.index);
}

// ignore: must_be_immutable
class SpecificationBox extends StatefulWidget {
  SpecificationBox({
    super.key,
    required this.advertisingHome,
  });
  RegisterFutureAd advertisingHome;
  @override
  State<SpecificationBox> createState() => _SpecificationBoxState();
}

class _SpecificationBoxState extends State<SpecificationBox> {
  @override
  Widget build(BuildContext context) {
    int length = 1;
    widget.advertisingHome.categoryId == '7ost8r7msw8lt0c'
        ? length = 2
        : length = 4;
    return Column(
      children: [
        Container(
          height: 100,
          constraints: const BoxConstraints().constrainstSize(),
          decoration: BoxDecoration(
            border: Border.all(color: CustomColor.grey350),
            borderRadius: BorderRadius.circular(4),
          ),
          alignment: Alignment.center,
          child: Row(
            crossAxisAlignment: CrossAxisAlignment.center,
            children: [
              for (int i = 0; i < length; i++) ...[
                if (i == 1 &&
                    widget.advertisingHome.categoryId == '7ost8r7msw8lt0c') ...[
                  Expanded(
                    child: informationBoxItem(
                      i == 0
                          ? 'ساخت'
                          : i == 1
                              ? 'متراژ'
                              : '',
                      i == 0
                          ? widget.advertisingHome.yearBiuld
                          : i == 1
                              ? widget.advertisingHome.metr
                              : 0,
                    ),
                  ),
                ] else ...[
                  // نمایش هر متن
                  Expanded(
                    child: informationBoxItem(
                      i == 0
                          ? 'ساخت'
                          : i == 1
                              ? 'اتاق'
                              : i == 2
                                  ? (widget.advertisingHome.floor == 0
                                      ? 'متراژ'
                                      : 'طبقه')
                                  : i == 3
                                      ? 'متراژ زمین'
                                      : '',
                      i == 0
                          ? widget.advertisingHome.yearBiuld
                          : i == 1
                              ? widget.advertisingHome.countRoom
                              : i == 2
                                  ? (widget.advertisingHome.floor == 0
                                      ? widget.advertisingHome.buildingMetr
                                      : widget.advertisingHome.floor)
                                  : i == 3
                                      ? widget.advertisingHome.metr
                                      : 0,
                    ),
                  ),
                ],
                // خطوط بین متن‌ها
                if (i < length - 1)
                  Padding(
                    padding: const EdgeInsets.symmetric(vertical: 10),
                    child: DottedLine(
                      direction: Axis.vertical,
                      dashColor: CustomColor.grey350,
                      lineThickness: 1.5,
                      dashLength: 6,
                      lineLength: 50,
                    ),
                  ),
              ],
            ],
          ),
        ),
        const SizedBox(height: 20),
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
        Padding(
          padding: const EdgeInsets.symmetric(horizontal: 5),
          child: FittedBox(
            child: textWidget(
              title,
              CustomColor.grey500,
              15,
              FontWeight.w400,
            ),
          ),
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

// ignore: must_be_immutable
class PriceInfoWidget extends StatefulWidget {
  PriceInfoWidget({
    super.key,
    required this.advertisingHome,
    required this.categoryType,
  });
  RegisterFutureAd advertisingHome;
  final String categoryType;
  @override
  State<PriceInfoWidget> createState() => _PriceInfoWidgetState();
}

class _PriceInfoWidgetState extends State<PriceInfoWidget> {
  @override
  Widget build(BuildContext context) {
    bool result = ['اجاره خانه', 'اجاره ویلا', 'اجاره آپارتمان']
        .contains(widget.categoryType);
    return Container(
      height: 96,
      constraints: const BoxConstraints().constrainstSize(),
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
                  priceChanged(widget.advertisingHome, result),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: CustomColor.black,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FittedBox(
                child: textWidget(
                  result ? 'ودیعه:' : 'قیمت هر متر:',
                  CustomColor.black,
                  16,
                  FontWeight.w700,
                ),
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
                  widget.advertisingHome.homeprice.formatter(),
                  overflow: TextOverflow.ellipsis,
                  style: const TextStyle(
                    color: CustomColor.black,
                    fontSize: 16,
                    decoration: TextDecoration.none,
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              FittedBox(
                child: textWidget(
                  result ? 'اجاره ماهانه:' : 'قیمت کل:',
                  CustomColor.black,
                  16,
                  FontWeight.w700,
                ),
              ),
            ],
          ),
        ],
      ),
    );
  }

  //Function to calculate the price per meter of the house
  priceChanged(RegisterFutureAd adHome, bool result) {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'fa-IR', symbol: '');
    if (result) {
      var priceChange = currencyFormat.format(adHome.rentPrice);
      return priceChange;
    }

    var priceChange = currencyFormat.format(adHome.homeprice / adHome.metr);
    return priceChange;
  }
}

//Methode For display Advertising Description
Widget _advertisingDescription({
  required RegisterFutureAd advertisingHome,
}) {
  return Text(
    advertisingHome.description,
    textAlign: TextAlign.right,
    textDirection: ui.TextDirection.rtl,
    style: TextStyle(
      color: CustomColor.grey500,
      fontSize: 16,
      fontWeight: FontWeight.w400,
    ),
  );
}

class AdvertisingGalleryImages extends StatefulWidget {
  const AdvertisingGalleryImages({
    super.key,
    required this.advertisingHome,
    required this.controller,
  });
  final RegisterFutureAd advertisingHome;
  final PageController controller;

  @override
  State<AdvertisingGalleryImages> createState() =>
      _AdvertisingGalleryImagesState();
}

class _AdvertisingGalleryImagesState extends State<AdvertisingGalleryImages> {
  @override
  void initState() {
    BlocProvider.of<AdImagesHomeBloc>(context)
        .add(AdImageListHomeEvent(widget.advertisingHome.idGallery));
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AdImagesHomeBloc, AdImagesState>(
      builder: (context, state) {
        return Container(
          height: 160,
          width: double.infinity,
          color: Colors.transparent,
          child: Column(
            mainAxisAlignment: MainAxisAlignment.center,
            children: [
              if (state is AdImagesLoadingState) ...[
                const Center(
                  child: CircularProgressIndicator(
                    color: CustomColor.normalRed,
                  ),
                ),
              ],
              if (state is UserAdvertisingImageDataState) ...[
                state.displayImageAdvertising.fold(
                  (error) => Center(
                    child: textWidget(
                      error,
                      CustomColor.black,
                      16,
                      FontWeight.w500,
                    ),
                  ),
                  (r) {
                    // Combine all images into a single list from all items
                    List<String> allImages =
                        r.expand((item) => item.images).toList();

                    return Expanded(
                      child: PageView.builder(
                        itemCount: allImages.length,
                        controller: widget.controller,
                        itemBuilder: (context, index) {
                          return Padding(
                            padding: const EdgeInsets.symmetric(horizontal: 5),
                            child: ClipRRect(
                              borderRadius: BorderRadius.circular(8),
                              child: Stack(
                                fit: StackFit.expand,
                                alignment: Alignment.bottomCenter,
                                children: [
                                  InterActiveImageWidget(
                                    allImages: allImages,
                                    index: index,
                                  ),
                                  Positioned(
                                    bottom: 12,
                                    child: SmoothPageIndicator(
                                      controller: widget.controller,
                                      count: allImages.length,
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
                    );
                  },
                ),
              ],
            ],
          ),
        );
      },
    );
  }
}
