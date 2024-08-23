import 'dart:io';

import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/List/list_advertising.dart';
import 'package:aviz_project/class/advertising.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/widgets/switch_box.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:aviz_project/widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';

import '../Bloc/bloc_page_number/page_n_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';

class RegisterAdvertising extends StatefulWidget {
  const RegisterAdvertising({super.key});

  @override
  State<RegisterAdvertising> createState() => _RegisterAdvertisingState();
}

class _RegisterAdvertisingState extends State<RegisterAdvertising> {
  TextEditingController controllertitle = TextEditingController();
  TextEditingController controllerDescription = TextEditingController();
  TextEditingController controllerPrice = TextEditingController();
  List<File> galleryFile = [];
  final picker = ImagePicker();

  @override
  void initState() {
    final stateAd = context.read<RegisterInfoAdCubit>().state;

    controllertitle.text = stateAd.title;
    controllerDescription.text = stateAd.description;
    controllerPrice.text =
        stateAd.price.toString() == 'null' ? '' : stateAd.price.toString();
    galleryFile = stateAd.images ?? [];

    super.initState();
  }

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
                  title: const Text(
                    'گالری',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () async {
                    final pickedFileGallery = await picker.pickMultiImage();
                    List<XFile>? xfilePickGallery = pickedFileGallery;
                    setState(() {
                      if (xfilePickGallery.isNotEmpty) {
                        for (var i = 0; i < xfilePickGallery.length; i++) {
                          galleryFile.add(File(xfilePickGallery[i].path));
                          BlocProvider.of<AddAdvertisingBloc>(context)
                              .add(AddImagesToGallery(galleryFile));
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
                  title: const Text(
                    'دوربین',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
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
                  controller: controllertitle,
                  textInputAction: TextInputAction.next,
                ),
                const TextTitleSection(
                    txt: 'توضیحات', img: 'images/clipboard_icon.png'),
                TextFieldBox(
                  hint: '... توضیحات آویز را وارد کنید',
                  textInputType: TextInputType.text,
                  countLine: 3,
                  focusNode: FocusNode(),
                  controller: controllerDescription,
                  textInputAction: TextInputAction.next,
                ),
                const TextTitleSection(
                    txt: 'قیمت', img: 'images/money_icon.png'),
                TextFieldBox(
                  hint: 'قیمت را وارد کنید',
                  textInputType: TextInputType.number,
                  countLine: 1,
                  focusNode: FocusNode(),
                  controller: controllerPrice,
                  textInputAction: TextInputAction.done,
                ),
                SwitchBox(switchCheck: false, txt: 'فعال کردن گفتگو'),
                SwitchBox(switchCheck: true, txt: 'فعال کردن تماس'),
                GestureDetector().textButton(
                  () {
                    // Check if no images have been selected
                    if (galleryFile.isEmpty) {
                      // Display a dialog prompting the user to select an image
                      displayDialog(
                          'لطفا عکس مورد نظر را انتخاب کنید', context);
                    }
                    // Check if any of the required text fields are empty
                    else if (controllertitle.text.isEmpty ||
                        controllerDescription.text.isEmpty ||
                        controllerPrice.text.isEmpty) {
                      // Display a dialog prompting the user to fill in all fields
                      displayDialog('لطفا تمام فیلد ها را کامل کنید', context);
                    } else {
                      // Get the current state of the RegisterInfoAdCubit
                      final stateAd = context.read<RegisterInfoAdCubit>().state;
                      // Get the current state of the BoolStateCubit
                      final boolState = context.read<BoolStateCubit>().state;

                      // Add the selected images to the gallery using the AddAdvertisingBloc

                      // Add the advertising information using the AddAdvertisingBloc
                      BlocProvider.of<AddAdvertisingBloc>(context).add(
                        AddInfoAdvertising(
                          stateAd.idCt,
                          stateAd.address,
                          stateAd.title,
                          stateAd.description,
                          stateAd.price!,
                          stateAd.metr!.toInt(),
                          stateAd.countRoom!.toInt(),
                          stateAd.floor!.toInt(),
                          stateAd.yearBuild!.toInt(),
                        ),
                      );

                      // Add the facilities information using the AddAdvertisingBloc
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
                          boolState.floorMaterial,
                          boolState.wc,
                        ),
                      );

                      // Reset the information stored in RegisterInfoAdCubit
                      context.read<RegisterInfoAdCubit>().resetInfoAdSet();
                      // Reset the state of BoolStateCubit
                      context.read<BoolStateCubit>().reset();
                      // Navigate back to the first page
                      context.read<NavigationPage>().backFirstPAge();

                      // The following code is commented out and not currently in use:
                      // advertisingData(
                      //   title,
                      //   description,
                      //   galleryFile,
                      //   price,
                      // );
                      // Navigator.pushReplacement(
                      //     context,
                      //     MaterialPageRoute(
                      //       builder: (context) => BottomNavigationScreen(index: 2),
                      //     ));
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
