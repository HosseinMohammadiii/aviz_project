import 'dart:io';

import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/widgets/buttomnavigationbar.dart';
import 'package:aviz_project/widgets/switch_box.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:aviz_project/widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:image_picker/image_picker.dart';

class RegisterAdvertising extends StatefulWidget {
  const RegisterAdvertising({super.key});

  @override
  State<RegisterAdvertising> createState() => _RegisterAdvertisingState();
}

class _RegisterAdvertisingState extends State<RegisterAdvertising> {
  TextEditingController controller1 = TextEditingController();
  TextEditingController controller2 = TextEditingController();
  TextEditingController controller3 = TextEditingController();
  List<File> galleryFile = [];
  final picker = ImagePicker();

  @override
  Widget build(BuildContext context) {
//Widget For display buttomsheet Use Camera or Gallary for Select image
    Future showPicker({
      required BuildContext context,
    }) async {
      showModalBottomSheet(
        context: context,
        builder: (BuildContext context) {
          return SafeArea(
            child: Wrap(
              children: <Widget>[
                ListTile(
                  leading: const Icon(Icons.photo_library),
                  title: const Text('گالری'),
                  onTap: () async {
                    final pickedFileGallery = await picker.pickMultiImage();
                    List<XFile>? xfilePickGallery = pickedFileGallery;
                    setState(() {
                      if (xfilePickGallery.isNotEmpty) {
                        for (var i = 0; i < xfilePickGallery.length; i++) {
                          galleryFile.add(File(xfilePickGallery[i].path));
                        }
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: CustomColor.bluegrey,
                            content: textWidget(
                              'عکسی انتخاب نشد',
                              CustomColor.grey,
                              14,
                              FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    });
                  },
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text('دوربین'),
                  onTap: () async {
                    final pickedFileCamera =
                        await picker.pickImage(source: ImageSource.camera);
                    XFile? xfilePickCamera = pickedFileCamera;
                    setState(() {
                      if (xfilePickCamera != null) {
                        galleryFile.add(File(xfilePickCamera.path));
                      } else {
                        ScaffoldMessenger.of(context).showSnackBar(
                          SnackBar(
                            backgroundColor: CustomColor.bluegrey,
                            content: textWidget(
                              'عکسی انتخاب نشد',
                              CustomColor.grey,
                              14,
                              FontWeight.w500,
                            ),
                          ),
                        );
                      }
                      Navigator.of(context).pop();
                    });
                  },
                ),
              ],
            ),
          );
        },
      );
    }

    return Scaffold(
      appBar: AppBar(
        scrolledUnderElevation: 0,
        elevation: 0,
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: 12,
              alignment: WrapAlignment.spaceAround,
              children: [
                const TextTitleSection(
                    txt: 'تصویر آویز', img: 'images/camera_icon.png'),
                UploadImage(
                  fileImage: galleryFile,
                  onChange: () {
                    showPicker(context: context);
                  },
                ),
                const TextTitleSection(
                    txt: 'عنوان آویز', img: 'images/edit2_icon.png'),
                TextFieldBox(
                  hint: 'عنوان آویز را وارد کنید',
                  textInputType: TextInputType.text,
                  countLine: 1,
                  focusNode: FocusNode(),
                  controller: controller1,
                  textInputAction: TextInputAction.next,
                ),
                const TextTitleSection(
                    txt: 'توضیحات', img: 'images/clipboard_icon.png'),
                TextFieldBox(
                  hint: '... توضیحات آویز را وارد کنید',
                  textInputType: TextInputType.text,
                  countLine: 3,
                  focusNode: FocusNode(),
                  controller: controller2,
                  textInputAction: TextInputAction.next,
                ),
                const TextTitleSection(
                    txt: 'قیمت', img: 'images/money_icon.png'),
                TextFieldBox(
                  hint: 'قیمت را وارد کنید',
                  textInputType: TextInputType.number,
                  countLine: 1,
                  focusNode: FocusNode(),
                  controller: controller3,
                  textInputAction: TextInputAction.done,
                ),
                SwitchBox(switchCheck: false, txt: 'فعال کردن گفتگو'),
                SwitchBox(switchCheck: true, txt: 'فعال کردن تماس'),
                GestureDetector().textButton(
                  () {
                    if (galleryFile.isEmpty) {
                      displayDialog(
                          'لطفا عکس مورد نظر را انتخاب کنید', context);
                    } else if (controller1.text.isEmpty ||
                        controller2.text.isEmpty ||
                        controller3.text.isEmpty) {
                      displayDialog('لطفا تمام فیلد ها را کامل کنید', context);
                    } else {
                      try {
                        String title = controller1.text;
                        String description = controller2.text;
                        String price = controller3.text;

                        advertisingData(
                          title,
                          description,
                          galleryFile,
                          double.parse(price),
                        );
                        Navigator.pushReplacement(
                            context,
                            MaterialPageRoute(
                              builder: (context) =>
                                  BottomNavigationScreen(index: 2),
                            ));
                      } catch (e) {
                        displayDialog('لطفاً مقدار معتبر وارد کنید', context);
                      }
                    }
                  },
                  'ثبت آگهی',
                  CustomColor.red,
                  CustomColor.grey,
                  false,
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

  void advertisingData(
    String title,
    String description,
    List<File> img,
    double price,
  ) {
    AdvertisingData advertisingData = AdvertisingData(
      title: title,
      description: description,
      img: img,
      price: price,
    );
    advertisingDataBox.add(advertisingData);
  }
}
