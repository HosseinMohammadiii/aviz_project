import 'dart:async';
import 'dart:io';

import 'package:aviz_project/DataFuture/add_advertising/Bloc/add_advertising_event.dart';
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
import '../class/checkconnection.dart';

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
  List<File> updateImage = [];
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

// Function to select images from the gallery and add them to the list
  Future<List<File>> setImages(List<File> gallery) async {
    final pickedFileGallery =
        await picker.pickMultiImage(); // Pick multiple images from gallery
    List<XFile>? xfilePickGallery = pickedFileGallery;

    setState(() {
      if (xfilePickGallery.isNotEmpty) {
        // If images are picked, add them to the gallery list
        for (var i = 0; i < xfilePickGallery.length; i++) {
          gallery.add(File(xfilePickGallery[i].path));
        }
      } else {
        // Show a message if no images were selected
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColor.bluegrey,
            content: textWidget(
              'No images selected',
              CustomColor.grey,
              14,
              FontWeight.w500,
            ),
          ),
        );
      }
      Navigator.of(context).pop(); // Close the bottom sheet
    });
    return gallery;
  }

// Function to take a photo using the camera and add it to the list
  Future<List<File>> setCameraImage(List<File> camera) async {
    final pickedFileCamera = await picker.pickImage(
        source: ImageSource.camera); // Capture image using camera
    XFile? xfilePickCamera = pickedFileCamera;
    setState(() {
      if (xfilePickCamera != null) {
        // If an image was captured, add it to the camera list
        camera.add(File(xfilePickCamera.path));
      } else {
        // Show a message if no image was captured
        ScaffoldMessenger.of(context).showSnackBar(
          SnackBar(
            backgroundColor: CustomColor.bluegrey,
            content: textWidget(
              'No images captured',
              CustomColor.grey,
              14,
              FontWeight.w500,
            ),
          ),
        );
      }
      Navigator.of(context).pop(); // Close the bottom sheet
    });
    return camera;
  }

  @override
  Widget build(BuildContext context) {
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
                    showPicker(
                      context: context,
                      regiterFileImage: (p0) async {
                        galleryFile = await p0;
                        BlocProvider.of<AddAdvertisingBloc>(context).add(
                            AddImagesToGallery(
                                galleryFile)); // Add selected gallery images to Bloc
                      },
                      regiterCameraImage: (p0) async {
                        galleryFile = await p0;
                        BlocProvider.of<AddAdvertisingBloc>(context).add(
                            AddImagesToGallery(
                                galleryFile)); // Add selected camera images to Bloc
                      },
                      images: galleryFile,
                    );
                  },
                  addImage: () {
                    updateImage.clear(); // Clear the update image list
                    showPicker(
                      context: context,
                      regiterFileImage: (p0) async {
                        updateImage = await p0;
                        galleryFile.addAll(
                            updateImage); // Add images to the gallery list
                        BlocProvider.of<AddAdvertisingBloc>(context).add(
                            UpdateImageData(
                                updateImage)); // Update image data in Bloc
                      },
                      regiterCameraImage: (p0) async {
                        updateImage = await p0;
                        galleryFile.addAll(
                            updateImage); // Add images to the gallery list
                        BlocProvider.of<AddAdvertisingBloc>(context).add(
                            UpdateImageData(
                                updateImage)); // Update image data in Bloc
                      },
                      images: updateImage,
                    );
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
                  () async {
                    //Check Internet Connection Befor Register Information Ad in the Database
                    if (!await checkInternetConnection(context)) {
                      return;
                    }

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

                      BlocProvider.of<AddAdvertisingBloc>(context).add(
                        AddInfoAdvertising(
                          stateAd.idCt,
                          stateAd.idFeature,
                          stateAd.province,
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
                      // Reset the information stored in RegisterInfoAdCubit
                      context.read<RegisterInfoAdCubit>().resetInfoAdSet();
                      // Reset the state of BoolStateCubit
                      context.read<BoolStateCubit>().reset();
                      // Navigate back to the first page
                      context.read<NavigationPage>().backFirstPAge();

                      // RegisterId().clearID();
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
}
