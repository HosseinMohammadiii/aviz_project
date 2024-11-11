import 'dart:async';
import 'dart:io';
import 'dart:math';

import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_state.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:aviz_project/class/scaffoldmessage.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:aviz_project/widgets/upload_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:intl/intl.dart';

import '../Bloc/bloc_page_number/page_n_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../class/checkconnection.dart';

class RegisterAdvertising extends StatefulWidget {
  const RegisterAdvertising({super.key});

  @override
  State<RegisterAdvertising> createState() => _RegisterAdvertisingState();
}

class _RegisterAdvertisingState extends State<RegisterAdvertising> {
  final TextEditingController controllertitle = TextEditingController();
  final TextEditingController controllerDescription = TextEditingController();
  final TextEditingController controllerPrice = TextEditingController();
  final TextEditingController controllerRentPrice = TextEditingController();

  final FocusNode priceFocusNude = FocusNode();
  final FocusNode rentFocusNude = FocusNode();
  final FocusNode titleFocusNude = FocusNode();
  final FocusNode descriptionFocusNude = FocusNode();

  final picker = ImagePicker();

  bool isLoading = true;

  String formattedAmount1 = '';
  String formattedAmount2 = '';

  int priceLength1 = 0;
  int priceLength2 = 0;

  @override
  void initState() {
    final stateAd = context.read<RegisterInfoAdCubit>().state;

    controllertitle.text = stateAd.title;
    controllerDescription.text = stateAd.description;
    controllerPrice.text =
        stateAd.price.toString() == 'null' ? '' : stateAd.price.toString();

    super.initState();
  }

// Function to select images from the gallery and add them to the list
  Future<List<File>> setImages(List<File> gallery) async {
    final stateAd = context.read<RegisterInfoAdCubit>().state;
    final pickedFileGallery =
        await picker.pickMultiImage(); // Pick multiple images from gallery
    List<XFile>? xfilePickGallery = pickedFileGallery;

    setState(() {
      if (xfilePickGallery.isNotEmpty) {
        // If images are picked, add them to the gallery list
        for (var i = 0; i < xfilePickGallery.length; i++) {
          stateAd.images?.add(File(xfilePickGallery[i].path));
        }
      }
      Navigator.of(context).pop(); // Close the bottom sheet
    });

    return gallery;
  }

// Function to take a photo using the camera and add it to the list
  Future<List<File>> setCameraImage(List<File> camera) async {
    final stateAd = context.read<RegisterInfoAdCubit>().state;
    final pickedFileCamera = await picker.pickImage(
        source: ImageSource.camera); // Capture image using camera
    XFile? xfilePickCamera = pickedFileCamera;
    setState(() {
      if (xfilePickCamera != null) {
        // If an image was captured, add it to the camera list

        stateAd.images?.add(File(xfilePickCamera.path));
      }
      Navigator.of(context).pop(); // Close the bottom sheet
    });
    return camera;
  }

  @override
  Widget build(BuildContext context) {
    final stateAd = context.read<RegisterInfoAdCubit>().state;
    // Widget to display a bottom sheet for selecting images from the camera or gallery
    Future showPicker({
      required BuildContext context,
      required Function(Future<List<File>>)
          regiterFileImage, // Callback for gallery selection
      required Function(Future<List<File>>)
          regiterCameraImage, // Callback for camera selection
      required List<File> images, // List of images
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
                  onTap: () => regiterFileImage(
                      setImages(images)), // Call function to pick from gallery
                ),
                ListTile(
                  leading: const Icon(Icons.photo_camera),
                  title: const Text(
                    'دوربین',
                    style: TextStyle(
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                  onTap: () => regiterCameraImage(setCameraImage(
                      images)), // Call function to pick from camera
                ),
              ],
            ),
          );
        },
      );
    }

    return BlocConsumer<AddAdvertisingBloc, AddAdvertisingState>(
      listener: (context, state) {
        if (state is PostImageAdState) {
          state.postImage.fold(
            (l) {
              showMessage(l, context, 2);
              stateAd.uploadProgress = true;
            },
            (r) {
              // Get the current state of the RegisterInfoAdCubit

              BlocProvider.of<AddAdvertisingBloc>(context).add(
                AddInfoAdvertising(
                  stateAd.idCt,
                  stateAd.idFeature,
                  stateAd.province,
                  stateAd.city,
                  stateAd.title,
                  stateAd.description,
                  priceLength2,
                  priceLength1,
                  stateAd.metr!.toInt(),
                  stateAd.buildingMetr!.toInt(),
                  stateAd.countRoom!.toInt(),
                  stateAd.floor!.toInt(),
                  stateAd.yearBuild!.toInt(),
                ),
              );

              // Reset the information stored in RegisterInfoAdCubit
              context.read<RegisterInfoAdCubit>().resetInfoAdSet();
              // Reset the state of BoolStateCubit
              context.read<BoolStateCubit>().reset();
              // Navigate back to the first page
              context.read<NavigationPage>().backFirstPAge();
              context
                  .read<AddAdvertisingBloc>()
                  .add(InitializedDisplayAdvertising());
            },
          );
        }
      },
      builder: (context, state) => Scaffold(
        body: SafeArea(
          child: SingleChildScrollView(
            child: Stack(
              alignment: Alignment.center,
              children: [
                Padding(
                  padding:
                      const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
                  child: Wrap(
                    runSpacing: 12,
                    alignment: WrapAlignment.end,
                    children: [
                      const TextTitleSection(
                          txt: 'تصویر آویز', img: 'images/camera_icon.png'),
                      UploadImage(
                        fileImage: stateAd.images,
                        isLoading: false,
                        onChange: () {
                          showPicker(
                            context: context,
                            regiterFileImage: (p0) async {
                              stateAd.images = await p0;
                            },
                            regiterCameraImage: (p0) async {
                              stateAd.images = await p0;
                            },
                            images: stateAd.images!,
                          );
                        },
                        addImage: () {
                          showPicker(
                            context: context,
                            regiterFileImage: (p0) async {
                              stateAd.images = await p0;
                            },
                            regiterCameraImage: (p0) async {
                              stateAd.images = await p0;
                            },
                            images: stateAd.images!,
                          );
                        },
                      ),
                      const TextTitleSection(
                          txt: 'عنوان آویز', img: 'images/edit2_icon.png'),
                      TextFieldBox(
                        hint: 'عنوان آویز را وارد کنید',
                        textInputType: TextInputType.text,
                        countLine: 1,
                        focusNode: titleFocusNude,
                        controller: controllertitle,
                        textInputAction: TextInputAction.next,
                      ),
                      const TextTitleSection(
                          txt: 'توضیحات', img: 'images/clipboard_icon.png'),
                      TextFieldBox(
                        hint: '... توضیحات آویز را وارد کنید',
                        textInputType: TextInputType.text,
                        countLine: 3,
                        focusNode: descriptionFocusNude,
                        controller: controllerDescription,
                        textInputAction: TextInputAction.next,
                      ),
                      const TextTitleSection(
                          txt: 'قیمت', img: 'images/money_icon.png'),
                      Visibility(
                        visible: stateAd.stateRentHome ?? true,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            inputPrice(
                              txtAction: TextInputAction.done,
                              focusNode: priceFocusNude,
                              controller: controllerPrice,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  var convertedNumber = int.parse(value);
                                  priceLength2 = convertedNumber;
                                  final formatter = NumberFormat('#,###', 'fa');
                                  setState(() {
                                    formattedAmount2 =
                                        '${formatter.format(convertedNumber)} تومان';
                                  });
                                } else {
                                  setState(() {
                                    formattedAmount2 = '';
                                  });
                                }
                              },
                            ),
                            Text(
                              formattedAmount2 != '' ? formattedAmount2 : '',
                              style: TextStyle(
                                fontSize: 18,
                                color: formattedAmount2 != ''
                                    ? CustomColor.grey500
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: stateAd.stateRentHome ?? false,
                        child: Column(
                          crossAxisAlignment: CrossAxisAlignment.end,
                          children: [
                            textWidget(
                              'ودیعه',
                              CustomColor.black,
                              15,
                              FontWeight.w700,
                            ),
                            inputPrice(
                              txtAction: TextInputAction.next,
                              focusNode: rentFocusNude,
                              controller: controllerRentPrice,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  var convertedNumber = int.parse(value);
                                  priceLength1 = convertedNumber;
                                  final formatter = NumberFormat('#,###', 'fa');

                                  setState(() {
                                    formattedAmount1 =
                                        '${formatter.format(convertedNumber)} تومان';
                                  });
                                } else {
                                  setState(() {
                                    formattedAmount1 = '';
                                    priceLength1 = 0;
                                  });
                                }
                              },
                            ),
                            Text(
                              formattedAmount1 != ''
                                  ? priceLength1 < 1000000
                                      ? '.مبلغ ودیعه نباید کمتر از 1,000,000 تومان باشد'
                                      : formattedAmount1
                                  : '',
                              style: TextStyle(
                                fontSize: priceLength1 < 1000000 ? 14 : 18,
                                color: formattedAmount1 != ''
                                    ? priceLength1 < 1000000
                                        ? CustomColor.red
                                        : CustomColor.grey500
                                    : null,
                              ),
                            ),
                            const SizedBox(
                              height: 10,
                            ),
                            textWidget(
                              'اجاره ماهانه',
                              CustomColor.black,
                              15,
                              FontWeight.w700,
                            ),
                            inputPrice(
                              txtAction: TextInputAction.done,
                              focusNode: priceFocusNude,
                              controller: controllerPrice,
                              onChanged: (value) {
                                if (value.isNotEmpty) {
                                  var convertedNumber = int.parse(value);
                                  priceLength2 = convertedNumber;
                                  final formatter = NumberFormat('#,###', 'fa');

                                  setState(() {
                                    formattedAmount2 =
                                        '${formatter.format(convertedNumber)} تومان';
                                  });
                                } else {
                                  setState(() {
                                    formattedAmount2 = '';
                                    priceLength2 = 0;
                                  });
                                }
                              },
                            ),
                            Text(
                              formattedAmount2 != ''
                                  ? priceLength2 < 100000
                                      ? '.مبلغ اجاره نباید کمتر از 100,000 تومان باشد'
                                      : formattedAmount2
                                  : '',
                              style: TextStyle(
                                fontSize: priceLength2 < 100000 ? 14 : 18,
                                color: formattedAmount2 != ''
                                    ? priceLength2 < 100000
                                        ? CustomColor.red
                                        : CustomColor.grey500
                                    : null,
                              ),
                            ),
                          ],
                        ),
                      ),
                      Visibility(
                        visible: stateAd.uploadProgress ?? true,
                        child: GestureDetector(
                          onTap: () async {
                            //Check Internet Connection Befor Register Information Ad in the Database
                            if (!await checkInternetConnection(context)) {
                              return;
                            }

                            //Checking the size of images larger than 1 MB
                            for (var i = 0; i < stateAd.images!.length; i++) {
                              //Get the size of the image
                              final bytes = stateAd.images![i]
                                  .readAsBytesSync()
                                  .lengthInBytes;
                              //Convert bytes to megabytes
                              final mb = bytes / pow(1024, 2);
                              if (mb > 1) {
                                //Display Message for image larger than 1 MB
                                showMessage(
                                  'حجم تصویر ${i + 1} بیشتر از 1 مگابایت است',
                                  context,
                                  2,
                                );
                                return;
                              }
                            }

                            // Check if no images have been selected
                            if (stateAd.images!.isEmpty) {
                              // Display a dialog prompting the user to select an image
                              displayDialog(
                                  'لطفا عکس مورد نظر را انتخاب کنید', context);
                            }
                            // Check if any of the required text fields are empty
                            else if (controllertitle.text.isEmpty ||
                                controllerDescription.text.isEmpty ||
                                controllerPrice.text.isEmpty) {
                              // Display a dialog prompting the user to fill in all fields
                              displayDialog(
                                  'لطفا تمام فیلد ها را کامل کنید', context);
                            } else if (stateAd.stateRentHome == true) {
                              if (priceLength1 < 1000000 ||
                                  priceLength2 < 100000) {
                                displayDialog(
                                    'لطفا قیمت صحیح وارد کنید', context);
                              }
                            } else {
                              BlocProvider.of<AddAdvertisingBloc>(context)
                                  .add(AddImagesToGallery(stateAd.images!));
                              setState(() {
                                stateAd.uploadProgress = false;
                              });
                            }
                          },
                          child: Container(
                            height: 40,
                            alignment: Alignment.center,
                            decoration: BoxDecoration(
                              color: CustomColor.red,
                              borderRadius: BorderRadius.circular(4),
                              border: Border.all(
                                color: CustomColor.red,
                              ),
                            ),
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                Text(
                                  'ثبت آگهی',
                                  textAlign: TextAlign.center,
                                  style: TextStyle(
                                    color: CustomColor.white,
                                    fontSize: 16,
                                    fontFamily: 'SN',
                                    fontWeight: FontWeight.w600,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        ),
                      ),
                    ],
                  ),
                ),
                if (state is AddAdvertisingImageLoading) ...[
                  Container(
                    height: MediaQuery.sizeOf(context).height,
                    width: MediaQuery.sizeOf(context).width,
                    color: Colors.transparent,
                  ),
                  Container(
                    height: 150,
                    width: 190,
                    decoration: BoxDecoration(
                      color: CustomColor.black.withOpacity(0.4),
                      borderRadius: BorderRadius.circular(10),
                    ),
                    child: Column(
                      mainAxisAlignment: MainAxisAlignment.center,
                      children: [
                        const SizedBox(
                          width: 40,
                          height: 40,
                          child: CircularProgressIndicator(
                            color: CustomColor.normalRed,
                          ),
                        ),
                        const SizedBox(
                          height: 15,
                        ),
                        Text(
                          '...در حال ساخت آگهی',
                          style: TextStyle(
                            fontSize: 17,
                            color: CustomColor.white,
                          ),
                        ),
                      ],
                    ),
                  ),
                ],
              ],
            ),
          ),
        ),
      ),
    );
  }

  //Widget TextField For Input Prices
  Widget inputPrice({
    required TextInputAction txtAction,
    required FocusNode focusNode,
    required TextEditingController controller,
    required Function(String value) onChanged,
  }) {
    return Container(
      padding: const EdgeInsets.symmetric(horizontal: 8),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: CustomColor.grey300,
      ),
      child: TextField(
        keyboardType: TextInputType.number,
        textInputAction: txtAction,
        focusNode: focusNode,
        controller: controller,
        textAlign: TextAlign.end,
        style: TextStyle(
          fontFamily: 'SN',
          fontSize: 20,
          color: CustomColor.grey500,
        ),
        decoration: InputDecoration(
          enabledBorder: InputBorder.none,
          focusedBorder: InputBorder.none,
          hintText: 'قیمت را وارد کنید',
          hintStyle: TextStyle(
            fontFamily: 'SN',
            fontSize: 18,
            color: CustomColor.grey500,
          ),
        ),
        onTapOutside: (event) {
          FocusScope.of(context).unfocus();
        },
        onChanged: (value) {
          onChanged(value);
        },
        inputFormatters: [
          LengthLimitingTextInputFormatter(15),
          FilteringTextInputFormatter.digitsOnly,
        ],
      ),
    );
  }
}
