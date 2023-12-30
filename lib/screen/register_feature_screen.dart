import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:aviz_project/class/scroll_behavior.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/screen/locatin_upload_screen.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_feature_screen.dart';
import 'package:flutter/material.dart';

class RegisterFeatureScreen extends StatefulWidget {
  const RegisterFeatureScreen({super.key});

  @override
  State<RegisterFeatureScreen> createState() => _RegisterFeatureScreenState();
}

class _RegisterFeatureScreenState extends State<RegisterFeatureScreen> {
  bool _switchBox = false;
  bool changeIcon = false;

  final layerLink = LayerLink();

  FocusNode focusNode1 = FocusNode();

  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  TextEditingController controller4 = TextEditingController();

  OverlayEntry? entry;

  double metr = 0;

  String txtTitle = 'فروش آپارتمان';

  List<Advertising> advertisingBox = [];

  @override
  void initState() {
    super.initState();
    WidgetsBinding.instance.addPostFrameCallback(
      (_) => hideOverlay(),
    );
  }

  List txt = [
    'فروش آپارتمان',
    'فروش ویلا',
    'فروش زمین',
  ];
  List<ClassSwitchBox> propertiesTxt = [
    ClassSwitchBox('آسانسور', false),
    ClassSwitchBox('پارکینگ', true),
    ClassSwitchBox('انباری', false),
  ];
  void showOverlay() {
    final overLay = Overlay.of(context);
    final renderBox = context.findRenderObject() as RenderBox;
    final size = renderBox.size;
    entry = OverlayEntry(
      builder: (context) => Positioned(
          width: size.width / 2.6,
          child: CompositedTransformFollower(
            link: layerLink,
            showWhenUnlinked: false,
            offset: Offset(0, size.height / 31),
            child: SizedBox(
              height: 110,
              child: ScrollConfiguration(
                behavior: MyBehavior(),
                child: ListView.builder(
                  itemCount: txt.length,
                  itemBuilder: (context, index) {
                    return GestureDetector(
                      onTap: () {
                        setState(() {
                          txtTitle = txt[index];
                          hideOverlay();
                          changeIcon = false;
                        });
                      },
                      child: Container(
                        alignment: Alignment.topRight,
                        padding: const EdgeInsets.symmetric(vertical: 4),
                        color: Colors.grey[300],
                        child: textWidget(
                          txt[index],
                          Colors.black,
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

  void hideOverlay() {
    entry?.remove();
    entry = null;
  }

  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: AppBarWidget(
            stepScreen: 3,
            screen: const LocatioUpload(),
          ),
        ),
        body: Padding(
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
                          margin: const EdgeInsets.only(right: 43),
                          padding: const EdgeInsets.only(right: 5),
                          decoration: BoxDecoration(
                            color: Colors.grey[350],
                            borderRadius: BorderRadius.circular(4),
                          ),
                          alignment: Alignment.center,
                          child: TextField(
                            keyboardType: TextInputType.streetAddress,
                            focusNode: focusNode1,
                            textAlign: TextAlign.end,
                            style: TextStyle(
                              fontFamily: 'SN',
                              fontSize: 16,
                              color: Colors.grey[500],
                              overflow: TextOverflow.ellipsis,
                            ),
                            decoration: InputDecoration(
                              enabledBorder: InputBorder.none,
                              focusedBorder: InputBorder.none,
                              hintText: 'محدوده را وارد کنید',
                              hintStyle: TextStyle(
                                fontFamily: 'SN',
                                fontSize: 16,
                                color: Colors.grey[500],
                              ),
                            ),
                            onTapOutside: (event) {
                              focusNode1.unfocus();
                            },
                          ),
                        ),
                        const Spacer(),
                        CompositedTransformTarget(
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
                                border: Border.all(color: Colors.grey[350]!),
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
                                crossAxisAlignment: CrossAxisAlignment.center,
                                children: [
                                  Icon(
                                    changeIcon == false
                                        ? Icons.keyboard_arrow_down_rounded
                                        : Icons.keyboard_arrow_up_rounded,
                                    size: 34,
                                  ),
                                  Padding(
                                    padding: const EdgeInsets.only(right: 6),
                                    child: textWidget(
                                      txtTitle,
                                      Colors.black,
                                      16,
                                      FontWeight.w400,
                                    ),
                                  ),
                                ],
                              ),
                            ),
                          ),
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
                        TextfieldFeature(controller: controller1),
                        TextfieldFeature(controller: controller2),
                      ],
                    ),
                    textCategory(
                      'سال ساخت',
                      'طبقه',
                    ),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        TextfieldFeature(controller: controller3),
                        TextfieldFeature(controller: controller4),
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
              SliverList.builder(
                itemCount: propertiesTxt.length,
                itemBuilder: (context, index) => switchBox(index),
              ),
              SliverToBoxAdapter(
                child: Padding(
                  padding: const EdgeInsets.only(bottom: 20, top: 15),
                  child: GestureDetector().textButton(
                    () {
                      if (controller1.text.isEmpty ||
                          controller2.text.isEmpty ||
                          controller3.text.isEmpty ||
                          controller4.text.isEmpty) {
                        displayDialog(
                            'لطفا تمام ویژگی ها را وارد کنید', context);
                      } else {
                        try {
                          num metr = num.parse(controller1.text);
                          num countRoom = num.parse(controller2.text);
                          num floor = num.parse(controller3.text);
                          num yearBuild = num.parse(controller4.text);

                          addAdvertising(
                            metr,
                            countRoom,
                            floor,
                            yearBuild,
                          );
                          Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => const LocatioUpload(),
                            ),
                          );
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

//Widget For Add Advertising
  void addAdvertising(
    num metr,
    num countRoom,
    num floor,
    num yearBuild,
  ) {
    Advertising advertising = Advertising(
      metr: metr,
      countRom: countRoom,
      floor: floor,
      yearBuild: yearBuild,
    );
    // advertisingBox.add(advertising);
  }

//Widget for display switch feature
  Widget switchBox(int index) {
    return Container(
      height: 40,
      margin: const EdgeInsets.symmetric(vertical: 10),
      padding: const EdgeInsets.symmetric(horizontal: 10),
      decoration: BoxDecoration(
        border: Border.all(color: Colors.grey[350]!),
        borderRadius: BorderRadius.circular(4),
      ),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          Switch(
            activeColor: CustomColor.red,
            value: propertiesTxt[index].switchb,
            onChanged: (value) {
              setState(() {
                propertiesTxt[index].switchb = !propertiesTxt[index].switchb;
                value = propertiesTxt[index].switchb;
              });
            },
          ),
          textWidget(
            propertiesTxt[index].txt,
            Colors.black,
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
            Colors.grey[500]!,
            14,
            FontWeight.w600,
          ),
          SizedBox(
            width: MediaQuery.of(context).size.width / 3.5,
          ),
          textWidget(
            txt2,
            Colors.grey[500]!,
            14,
            FontWeight.w600,
          ),
        ],
      ),
    );
  }
}

class ClassSwitchBox {
  String txt;
  bool switchb;
  ClassSwitchBox(this.txt, this.switchb);
}
