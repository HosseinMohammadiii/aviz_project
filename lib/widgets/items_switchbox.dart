import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../class/colors.dart';
import '../class/switch_classs.dart';
import 'text_widget.dart';

class ItemsSwitchbox extends StatefulWidget {
  const ItemsSwitchbox({super.key});
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
                itemCount: propertiesTxt.length,
                itemBuilder: (context, index) => GestureDetector(
                  onTap: () {
                    setState(() {
                      propertiesTxt[index].switchBool =
                          !propertiesTxt[index].switchBool;
                    });
                    context.read<BoolStateCubit>().updateBool(
                        propertiesTxt[index].txt,
                        propertiesTxt[index].switchBool);
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
                          trackOutlineColor:
                              const WidgetStatePropertyAll(Colors.transparent),
                          value: propertiesTxt[index].switchBool,
                          onChanged: (value) {
                            setState(() {
                              propertiesTxt[index].switchBool = value;
                            });
                            context
                                .read<BoolStateCubit>()
                                .updateBool(propertiesTxt[index].txt, value);
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
                        visible: pageIndexFM != 0,
                        replacement: const SizedBox(
                          width: 20,
                        ),
                        child: GestureDetector(
                          onTap: () {
                            setState(() {
                              // if (pageIndexFM == 0) {
                              //   titleFM = 'سرامیک';
                              // } else if (pageIndexFM == 1) {
                              //   titleFM = 'موزائیک';
                              // } else {
                              //   titleFM = 'پارکت';
                              // }

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
                              // if (pageIndexWC == 0) {
                              //   titleWC = 'ایرانی';
                              // } else if (pageIndexWC == 1) {
                              //   titleWC = 'فرنگی';
                              // } else {
                              //   titleWC = 'ایرانی و فرنگی';
                              // }
                              // context
                              //     .read<BoolStateCubit>()
                              //     .updateText(titleWC);
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
          );
        },
      ),
    );
  }

  @override
  void dispose() {
    super.dispose();
    pageControllerFM.dispose();
    pageControllerWC.dispose();
  }
}
