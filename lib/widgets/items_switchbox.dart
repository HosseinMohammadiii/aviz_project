import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../class/colors.dart';
import '../class/switch_classs.dart';
import 'text_widget.dart';

// ignore: must_be_immutable
class ItemsSwitchbox extends StatefulWidget {
  ItemsSwitchbox({
    super.key,
    required this.title,
  });
  String title;
  @override
  State<ItemsSwitchbox> createState() => _ItemsSwitchboxState();
}

class _ItemsSwitchboxState extends State<ItemsSwitchbox> {
  PageController pageControllerWC = PageController(initialPage: 1);
  PageController pageControllerFM = PageController(initialPage: 1);

  int pageIndexFM = 1;
  int pageIndexWC = 1;

  String titleFM = '';
  String titleWC = '';

  List<ClassSwitchBox> propertiesTxt = [
    ClassSwitchBox('آسانسور', false),
    ClassSwitchBox('پارکینگ', false),
    ClassSwitchBox('انباری', false),
    ClassSwitchBox('بالکن', false),
    ClassSwitchBox('پنت هاوس', false),
    ClassSwitchBox('دوبلکس', false),
  ];
  List<ClassSwitchBox> propertiesLandTxt = [
    ClassSwitchBox('آب', false),
    ClassSwitchBox('برق', false),
    ClassSwitchBox('گاز', false),
  ];
  @override
  void initState() {
    final state = context.read<BoolStateCubit>().state;

    ClassSwitchBox('آسانسور', state.elevator);
    ClassSwitchBox('پارکینگ', state.parking);
    ClassSwitchBox('انباری', state.storeroom);
    ClassSwitchBox('بالکن', state.balcony);
    ClassSwitchBox('پنت هاوس', state.penthouse);
    ClassSwitchBox('دوبلکس', state.duplex);
    super.initState();
  }

  @override
  Widget build(BuildContext context) {
    return SliverToBoxAdapter(
      child: BlocBuilder<BoolStateCubit, BoolState>(
        builder: (context, state) {
          return CustomScrollView(
            shrinkWrap: true,
            physics: const NeverScrollableScrollPhysics(),
            slivers: [
              SliverList.builder(
                itemCount: widget.title == 'فروش زمین'
                    ? propertiesLandTxt.length
                    : propertiesTxt.length,
                itemBuilder: (context, index) {
                  ClassSwitchBox('آسانسور', state.elevator);
                  ClassSwitchBox('پارکینگ', state.parking);
                  ClassSwitchBox('انباری', state.storeroom);
                  ClassSwitchBox('بالکن', state.balcony);
                  ClassSwitchBox('پنت هاوس', state.penthouse);
                  ClassSwitchBox('دوبلکس', state.duplex);
                  return GestureDetector(
                    onTap: () {
                      setState(() {
                        if (widget.title != 'فروش زمین') {
                          propertiesTxt[index].switchBool =
                              !propertiesTxt[index].switchBool;
                          context.read<BoolStateCubit>().updateBool(
                              propertiesTxt[index].txt,
                              propertiesTxt[index].switchBool);
                        } else {
                          propertiesLandTxt[index].switchBool =
                              !propertiesLandTxt[index].switchBool;
                          context.read<BoolStateCubit>().updateBool(
                              propertiesLandTxt[index].txt,
                              propertiesLandTxt[index].switchBool);
                        }
                      });
                    },
                    child: Container(
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
                            thumbColor:
                                const WidgetStatePropertyAll(CustomColor.grey),
                            trackOutlineColor: const WidgetStatePropertyAll(
                                Colors.transparent),
                            value: widget.title == 'فروش زمین'
                                ? propertiesLandTxt[index].switchBool
                                : propertiesTxt[index].switchBool,
                            onChanged: (value) {
                              setState(() {
                                if (widget.title == 'فروش زمین') {
                                  propertiesLandTxt[index].switchBool = value;

                                  context.read<BoolStateCubit>().updateBool(
                                      propertiesLandTxt[index].txt, value);
                                } else {
                                  propertiesTxt[index].switchBool = value;

                                  context.read<BoolStateCubit>().updateBool(
                                      propertiesTxt[index].txt, value);
                                }
                              });
                            },
                          ),
                          textWidget(
                            widget.title == 'فروش زمین'
                                ? propertiesLandTxt[index].txt
                                : propertiesTxt[index].txt,
                            CustomColor.black,
                            16,
                            FontWeight.w400,
                          ),
                        ],
                      ),
                    ),
                  );
                },
              ),
              if (widget.title != 'فروش زمین') ...[
                SliverToBoxAdapter(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.grey350),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: pageIndexFM != 0,
                          replacement: const SizedBox(
                            width: 20,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (pageIndexFM > 0) {
                                  pageIndexFM--;
                                } else {
                                  return;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 20,
                              color: CustomColor.grey400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: 60,
                          child: PageView.builder(
                            controller: pageControllerFM,
                            itemCount: 3,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (int page) {
                              setState(() {
                                pageIndexFM = page;
                              });
                            },
                            itemBuilder: (context, index) {
                              List<String> ttl = ['سرامیک', 'موزائیک', 'پارکت'];
                              context
                                  .read<BoolStateCubit>()
                                  .updateTextFM(pageIndexFM);

                              return Center(
                                child: Text(
                                  ttl[pageIndexFM],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(color: CustomColor.red),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: pageIndexFM != 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (pageIndexFM < 2) {
                                  pageIndexFM++;
                                } else {
                                  return;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: CustomColor.grey400,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'جنس کف',
                          style: TextStyle(
                            color: CustomColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
                SliverToBoxAdapter(
                  child: Container(
                    height: 40,
                    margin: const EdgeInsets.symmetric(vertical: 10),
                    padding: const EdgeInsets.symmetric(horizontal: 10),
                    decoration: BoxDecoration(
                      border: Border.all(color: CustomColor.grey350),
                      borderRadius: BorderRadius.circular(4),
                    ),
                    child: Row(
                      crossAxisAlignment: CrossAxisAlignment.center,
                      mainAxisSize: MainAxisSize.min,
                      children: [
                        Visibility(
                          visible: pageIndexWC != 0,
                          replacement: const SizedBox(
                            width: 20,
                          ),
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (pageIndexWC > 0) {
                                  pageIndexWC--;
                                } else {
                                  return;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.arrow_back_ios_rounded,
                              size: 20,
                              color: CustomColor.grey400,
                            ),
                          ),
                        ),
                        SizedBox(
                          height: 30,
                          width: pageIndexWC == 2 ? 85 : 60,
                          child: PageView.builder(
                            controller: pageControllerWC,
                            itemCount: 3,
                            physics: const NeverScrollableScrollPhysics(),
                            onPageChanged: (int page) {
                              setState(() {
                                pageIndexWC = page;
                              });
                            },
                            itemBuilder: (context, index) {
                              List<String> ttl = [
                                'ایرانی',
                                'فرنگی',
                                'ایرانی و فرنگی'
                              ];
                              context
                                  .read<BoolStateCubit>()
                                  .updateTextWC(pageIndexWC);

                              return Center(
                                child: Text(
                                  ttl[pageIndexWC],
                                  style: Theme.of(context)
                                      .textTheme
                                      .bodyLarge!
                                      .apply(color: CustomColor.red),
                                ),
                              );
                            },
                          ),
                        ),
                        Visibility(
                          visible: pageIndexWC != 2,
                          child: GestureDetector(
                            onTap: () {
                              setState(() {
                                if (pageIndexWC < 2) {
                                  pageIndexWC++;
                                } else {
                                  return;
                                }
                              });
                            },
                            child: const Icon(
                              Icons.arrow_forward_ios_rounded,
                              size: 20,
                              color: CustomColor.grey400,
                            ),
                          ),
                        ),
                        const Spacer(),
                        const Text(
                          'سرویس بهداشتی',
                          style: TextStyle(
                            color: CustomColor.black,
                            fontSize: 16,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ),
                ),
              ],
            ],
          );
        },
      ),
    );
  }
}
