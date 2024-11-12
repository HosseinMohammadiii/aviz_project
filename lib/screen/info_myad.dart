import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/ad_details/Bloc/detail_ad_state.dart';

import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_bloc.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_event.dart';
import 'package:aviz_project/DataFuture/advertising_save/bloc/advertising_save_state.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_event.dart';
import 'package:aviz_project/DataFuture/search/Bloc/search_state.dart';
import 'package:aviz_project/Hive/Advertising/register_id.dart';
import 'package:aviz_project/extension/price_extension.dart';
import 'package:dotted_line/dotted_line.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:intl/intl.dart';
import 'package:smooth_page_indicator/smooth_page_indicator.dart';

import '../DataFuture/ad_details/Bloc/detail_ad_bloc.dart';
import '../DataFuture/ad_details/Bloc/detail_ad_event.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import '../DataFuture/search/Bloc/search_bloc.dart';
import '../class/colors.dart';

import '../widgets/advertising_facilities_features.dart';
import '../widgets/button_widget.dart';
import '../widgets/box_attention.dart';
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
//   @override
//   void didChangeDependencies() {
//     super.didChangeDependencies();
//     final route = ModalRoute.of(context);
//     if (route is PageRoute) {
//       routeObserver.subscribe(this, route);
//     }
//   }

//   @override
//   void dispose() {
//     routeObserver.unsubscribe(this);
//     super.dispose();
//   }

//   @override
//   void didPush() {
//     print('صفحه جدید به جلو هل داده شد');
//   }

//   @override
//   void didPop() {
// //    context.read<SaveAdBloc>().add(GetInitializedSaveDataEvent());

//     print('صفحه قبلی بسته شد');
//   }

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
    void showMessage(String message) {
      ScaffoldMessenger.of(context).showSnackBar(SnackBar(
        content: Text(message),
        duration: const Duration(milliseconds: 700),
      ));
    }

    return BlocConsumer<AdExistsBloc, SearchState>(
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
                  BlocConsumer<SaveAdBloc, SaveAdState>(
                    listener: (context, state) {
                      if (state is GetExistsSaveState) {
                        state.getSaveAd.fold(
                          (l) {},
                          (r) {
                            bool isSavedAd = r.any((item) =>
                                item.idAd == widget.advertisingHome.id);
                            saveId = isSavedAd
                                ? r
                                    .firstWhere((item) =>
                                        item.idAd == widget.advertisingHome.id)
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
                          (l) => showMessage('مجدد تلاش کنید'),
                          (r) {
                            showMessage(r);
                            setState(() {
                              isSaved = true;
                            });
                          },
                        );
                      } else if (state is DeleteSaveAdState) {
                        state.deleteSaveAd.fold(
                          (l) => showMessage('مجدد تلاش کنید'),
                          (r) {
                            showMessage(r);
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
                              actionsAlignment: MainAxisAlignment.center,
                              backgroundColor: CustomColor.bluegrey50,
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
                                    backgroundColor: WidgetStatePropertyAll(
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
                                          idAd: widget.advertisingHome.id,
                                          idAdFacilities: widget
                                              .advertisingHome.idFacilities,
                                          idAdGallery:
                                              widget.advertisingHome.idGallery,
                                        ));
                                    Navigator.pop(context);
                                    Navigator.pop(context);
                                  },
                                  style: const ButtonStyle(
                                    backgroundColor:
                                        WidgetStatePropertyAll(CustomColor.red),
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
                      Icons.chevron_right_rounded,
                      size: 42,
                    ),
                  ),
                ],
              ),
            ),
          ),
          body: SafeArea(
            child: RefreshIndicator(
              color: CustomColor.normalRed,
              onRefresh: () async {
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
              },
              child: Padding(
                padding: const EdgeInsets.symmetric(horizontal: 15),
                child: state is SearchLoadingState
                    ? const Center(
                        child: CircularProgressIndicator(
                          color: CustomColor.normalRed,
                        ),
                      )
                    : state is SearchExistsRequestSuccessState
                        ? state.getExistAd.fold(
                            (l) => Column(
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
                            (r) => CustomScrollView(
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
                                          borderRadius:
                                              BorderRadius.circular(4),
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
                                  child: BoxAttention(
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
                                          padding:
                                              const EdgeInsets.only(left: 19),
                                          child: GestureDetector(
                                            onTap: () {
                                              setState(() {
                                                // Update selected state of each category
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
                                              padding:
                                                  const EdgeInsets.symmetric(
                                                      horizontal: 8),
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
                                _changeBoxContainer(
                                  indexContainer,
                                  widget.advertisingHome,
                                  categoryTitle,
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
                          )
                        : const SizedBox.shrink(),
              ),
            ),
          ),
        );
      },
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
          child: DescriptionWidget(advertisingHome: adHome));

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
    int length = 0;
    widget.advertisingHome.categoryId == '7ost8r7msw8lt0c'
        ? length = 1
        : length = 3;
    return Column(
      children: [
        Container(
          height: 100,
          width: length == 1 ? 200 : double.infinity,
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
                    if (length == 1) ...[
                      informationBoxItem(
                          'خرید', widget.advertisingHome.yearBiuld),
                      informationBoxItem('متراژ', widget.advertisingHome.metr),
                    ] else ...[
                      informationBoxItem(
                          'ساخت', widget.advertisingHome.yearBiuld),
                      informationBoxItem('طبقه', widget.advertisingHome.floor),
                      informationBoxItem(
                          'اتاق', widget.advertisingHome.countRoom),
                      informationBoxItem('متراژ', widget.advertisingHome.metr),
                    ],
                  ],
                ),
              ),
              Row(
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  for (var i = 0; i < length; i++) ...[
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
                    fontFamily: 'SN',
                    fontWeight: FontWeight.w700,
                  ),
                ),
              ),
              textWidget(
                result ? 'ودیعه:' : 'قیمت هر متر:',
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
                  widget.advertisingHome.homeprice.formatter(),
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
                result ? 'اجاره ماهانه:' : 'قیمت کل:',
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

// ignore: must_be_immutable
class DescriptionWidget extends StatelessWidget {
  DescriptionWidget({
    super.key,
    required this.advertisingHome,
  });
  RegisterFutureAd advertisingHome;
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
