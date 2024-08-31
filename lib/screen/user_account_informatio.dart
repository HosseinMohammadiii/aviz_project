import 'dart:io';

import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
import 'package:aviz_project/screen/search_provinces.dart';
import 'package:flutter/material.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../Hive/UsersLogin/user_login.dart';
import '../class/checkinvalidcharacters.dart';
import '../widgets/text_widget.dart';
import 'login_screen.dart';

class UserAccountInfirmation extends StatefulWidget {
  const UserAccountInfirmation({super.key});

  @override
  State<UserAccountInfirmation> createState() => _UserAccountInfirmationState();
}

class _UserAccountInfirmationState extends State<UserAccountInfirmation> {
  final TextEditingController usernameController = TextEditingController();
  final TextEditingController emailController = TextEditingController();
  final TextEditingController phoneNumberController = TextEditingController();
  final TextEditingController provincesController = TextEditingController();

  final FocusNode usernameFocusNode = FocusNode();
  final FocusNode emailFocusNode = FocusNode();
  final FocusNode phoneNumberFocusNode = FocusNode();
  final FocusNode provincesFocusNode = FocusNode();

  File? galleryFile;
  final picker = ImagePicker();

  String errorText = '';

  bool isShowErrorText = false;

// Function to check for invalid characters EmailAddress
  void checkInvalidEmailCharacters(String text) {
    // Combine invalidCharacters and allCharacters
    final allInvalidChars = invalidCharactersEmail + allCharacters;

    // Check if the username contains any of the invalid characters
    for (String character in allInvalidChars) {
      if (emailController.text.contains(character)) {
        setState(() {
          errorText = 'از کاراکتر غیرمجاز استفاده شده است: $character';
          isShowErrorText = true;
        });
        return;
      }
      setState(() {});
    }

    // If no invalid characters are found, clear the error text
    setState(() {
      errorText = ''; // No invalid characters found
      isShowErrorText = false;
    });
  }

// Function to check for invalid characters
  void checkForInvalidCharacters(
    String text,
  ) {
// Combine invalidCharacters and allCharacters
    final allInvalidChars = invalidCharacters + allCharacters;

// Check if the username contains any of the invalid characters
    for (String character in allInvalidChars) {
      if (text.contains(character)) {
        setState(() {
          errorText = 'از کاراکتر غیرمجاز استفاده شده است: $character';
          isShowErrorText = true;
        });
        return;
      }
    }

// If no invalid characters are found, clear the error text
    setState(() {
      errorText = ''; // No invalid characters found
      isShowErrorText = false;
    });
  }

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
                  final pickedFileCamera =
                      await picker.pickImage(source: ImageSource.gallery);
                  XFile? xfilePickCamera = pickedFileCamera;
                  setState(() {
                    if (xfilePickCamera != null) {
                      galleryFile = File(xfilePickCamera.path);
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
                      galleryFile = File(xfilePickCamera.path);
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

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 18),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              GestureDetector(
                onTap: () async {
                  return showDialogLogOut(context);
                },
                child: const Icon(Icons.logout),
              ),
              const SizedBox(
                width: 15,
              ),
              const Icon(Icons.email_outlined),
              const Spacer(),
              const Text(
                'حساب کاربری',
                style: TextStyle(
                  fontSize: 17,
                  color: CustomColor.black,
                ),
              ),
              const SizedBox(
                width: 15,
              ),
              GestureDetector(
                onTap: () {
                  Navigator.pop(context);
                },
                child: const Icon(Icons.arrow_forward_ios_rounded),
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
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverToBoxAdapter(
                child: showandselectProfileImage(context),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 18,
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    await showBottomSheet(
                      context: context,
                      title: 'نام کاربری',
                      label: 'نام کاربری',
                      focusNode: usernameFocusNode,
                      inputType: TextInputType.name,
                      controller: usernameController,
                      registration: () {
                        checkForInvalidCharacters(usernameController.text);
                        if (isShowErrorText) {
                          displayDialog(errorText, context);
                        }
                      },
                    );
                  },
                  child: const Row(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    mainAxisAlignment: MainAxisAlignment.center,
                    children: [
                      Icon(
                        Icons.edit_outlined,
                        size: 20,
                        color: CustomColor.red,
                      ),
                      Text(
                        'Hossein',
                        style: TextStyle(
                          fontSize: 17,
                          color: CustomColor.black,
                        ),
                      ),
                    ],
                  ),
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 30,
                ),
              ),
              SliverToBoxAdapter(
                child: Column(
                  children: [
                    rowEnterInformationBox(
                      info: 'hosseinmohammadi.dev22@yahoo.com',
                      title: 'پست الکترونیکی',
                      onChaged: () {
                        return showBottomSheet(
                          context: context,
                          title: 'پست الکترونیکی',
                          label: 'پست الکترونیکی',
                          controller: emailController,
                          focusNode: emailFocusNode,
                          inputType: TextInputType.emailAddress,
                          registration: () {
                            checkInvalidEmailCharacters(emailController.text);
                            if (isShowErrorText) {
                              displayDialog(errorText, context);
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    rowEnterInformationBox(
                      info: '09135887182',
                      title: 'شماره موبایل',
                      onChaged: () {
                        return showBottomSheet(
                          context: context,
                          title: 'شماره موبایل',
                          label: 'شماره موبایل',
                          focusNode: phoneNumberFocusNode,
                          controller: phoneNumberController,
                          inputType: TextInputType.phone,
                          registration: () {
                            checkForInvalidCharacters(
                                phoneNumberController.text);

                            if (isShowErrorText) {
                              displayDialog(errorText, context);
                            }

                            if (!isShowErrorText &&
                                    phoneNumberController.text.length < 11 ||
                                !isShowErrorText &&
                                    phoneNumberController.text.length > 11) {
                              displayDialog(
                                  'شماره وارد شده باید 11 رقم باشد', context);
                              return;
                            }
                          },
                        );
                      },
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    rowEnterInformationBox(
                      info: 'اصفهان',
                      title: 'استان',
                      onChaged: () {
                        // return showBottomSheet(
                        //   context: context,
                        //   title: 'استان',
                        //   label: 'استان',
                        //   focusNode: provincesFocusNode,
                        //   controller: provincesController,
                        //   inputType: TextInputType.streetAddress,
                        //   onChanged: (value) {
                        //   },
                        //   registration: () {},
                        // );
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => SearchProvincesScreen(),
                          ),
                        );
                      },
                    ),
                    const SizedBox(
                      height: 35,
                    ),
                    Text(
                      'اطلاعات حساب کاربری شما به صورت محرمانه نگهدرای می شود.این اطلاعات تحت هیچ شرایطی در اختیار سایر کاربران قرار نخواهد گرفت.',
                      textAlign: TextAlign.justify,
                      textDirection: TextDirection.rtl,
                      style: TextStyle(
                        fontSize: 15,
                        color: CustomColor.grey500,
                      ),
                    ),
                  ],
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }

//Function For Changed UserName,Email,PhoneNumber and Provinces
  Future<void> showBottomSheet({
    required BuildContext context,
    required String title,
    required String label,
    required FocusNode focusNode,
    required TextEditingController controller,
    required TextInputType inputType,
    required Function registration,
    Function(String value)? onChanged,
  }) async {
    await showModalBottomSheet(
      context: context,
      backgroundColor: Colors.transparent,
      barrierColor: Colors.transparent,
      isScrollControlled: true,
      builder: (context) {
        return LayoutBuilder(
          builder: (context, constraints) {
            final isKeyboardVisible =
                MediaQuery.of(context).viewInsets.bottom > 0;
            final heightFactor = isKeyboardVisible ? 0.9 : 0.6;

            return SizedBox(
              height: MediaQuery.of(context).size.height * heightFactor,
              child: DraggableScrollableSheet(
                initialChildSize: heightFactor,
                minChildSize: 0.5,
                maxChildSize: 0.9,
                builder: (context, scrollController) {
                  return Container(
                    decoration: const BoxDecoration(
                      color: Colors.white,
                      borderRadius: BorderRadius.only(
                        topLeft: Radius.circular(12),
                        topRight: Radius.circular(12),
                      ),
                    ),
                    child: SingleChildScrollView(
                      controller: scrollController,
                      child: Column(
                        mainAxisSize: MainAxisSize.min,
                        children: [
                          Container(
                            width: 30,
                            height: 6,
                            margin: const EdgeInsets.only(bottom: 20, top: 10),
                            alignment: Alignment.topCenter,
                            decoration: BoxDecoration(
                              color: CustomColor.grey300,
                              borderRadius: BorderRadius.circular(8),
                            ),
                          ),
                          Text(
                            title,
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
                          Container(
                            margin: const EdgeInsets.symmetric(vertical: 15),
                            padding: const EdgeInsets.symmetric(horizontal: 15),
                            decoration: BoxDecoration(
                              borderRadius: BorderRadius.circular(4),
                            ),
                            child: Directionality(
                              textDirection: TextDirection.rtl,
                              child: TextField(
                                controller: controller,
                                focusNode: focusNode,
                                keyboardType: inputType,
                                autofocus: true,
                                textDirection: TextDirection.rtl,
                                decoration: InputDecoration(
                                  labelText: label,
                                  labelStyle: TextStyle(
                                    fontSize: 15,
                                    color: colorShow(focusNode, controller),
                                  ),
                                  enabledBorder: OutlineInputBorder(
                                    borderSide: BorderSide(
                                      color: colorShow(focusNode, controller),
                                    ),
                                  ),
                                  focusedBorder: OutlineInputBorder(
                                    borderRadius: BorderRadius.circular(8),
                                    borderSide: BorderSide(
                                      width: 1,
                                      color: colorShow(focusNode, controller),
                                    ),
                                  ),
                                  prefixIcon: Image.asset(
                                    'images/user_icon_text.png',
                                    scale: 6,
                                  ),
                                ),
                                onChanged: (value) {
                                  onChanged != null ? onChanged(value) : null;
                                },
                                onTapOutside: (event) {
                                  FocusScope.of(context).unfocus();
                                },
                              ),
                            ),
                          ),
                          GestureDetector(
                            onTap: () => registration(),
                            child: Container(
                              width: double.infinity,
                              alignment: Alignment.center,
                              height: 50,
                              margin:
                                  const EdgeInsets.symmetric(horizontal: 15),
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(8),
                                color: Colors.pink,
                              ),
                              child: Text(
                                'ثبت',
                                style: Theme.of(context).textTheme.displayLarge,
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
        );
      },
    );
  }

//Widget For Slect And Display User Profile Image
  Widget showandselectProfileImage(BuildContext context) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            height: 100,
            width: 100,
            child: galleryFile != null
                ? Image.file(
                    galleryFile!,
                    key: ValueKey(galleryFile?.path),
                    fit: BoxFit.fill,
                  )
                : Image.asset('images/user_profile.png'),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 142,
          child: GestureDetector(
            onTap: () async {
              showPicker(context: context);
            },
            child: Container(
              width: 32,
              height: 32,
              alignment: Alignment.center,
              decoration: BoxDecoration(
                color: CustomColor.pink,
                borderRadius: BorderRadius.circular(30),
                border: Border.all(
                  color: CustomColor.white,
                  width: 2,
                ),
              ),
              child: Icon(
                Icons.camera_alt,
                color: CustomColor.white,
                size: 20,
              ),
            ),
          ),
        ),
      ],
    );
  }

//Future Function For Display Dialog to LogOut Account
  Future<void> showDialogLogOut(BuildContext context) {
    return showDialog(
      context: context,
      builder: (context) {
        return AlertDialog(
          alignment: Alignment.center,
          actionsAlignment: MainAxisAlignment.center,
          backgroundColor: CustomColor.bluegrey50,
          title: const Text(
            'آیا می خواهید از حسابتان خارج شوید؟',
            textAlign: TextAlign.center,
            style: TextStyle(
              fontWeight: FontWeight.w700,
              fontFamily: 'SN',
              fontSize: 20,
              color: CustomColor.black,
            ),
          ),
          actions: [
            TextButton(
              onPressed: () => Navigator.pop(context, 'OK'),
              style: ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(CustomColor.grey500),
              ),
              child: Text(
                'خیر',
                style: TextStyle(
                  color: CustomColor.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SN',
                  fontSize: 18,
                ),
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            TextButton(
              onPressed: () {
                final Box<UserLogin> userLogin = Hive.box('user_login');
                UserLogin user = UserLogin(
                  isLogin: false,
                  token: null,
                );

                userLogin.put(1, user);

                Navigator.push(
                  context,
                  MaterialPageRoute(
                    builder: (context) => const LogInScreen(),
                  ),
                );
              },
              style: const ButtonStyle(
                backgroundColor: WidgetStatePropertyAll(CustomColor.red),
              ),
              child: Text(
                'بله',
                style: TextStyle(
                  color: CustomColor.white,
                  fontWeight: FontWeight.bold,
                  fontFamily: 'SN',
                  fontSize: 18,
                ),
              ),
            ),
          ],
        );
      },
    );
  }

//Widget For Display Phone Number,Email and Provinces
  Widget rowEnterInformationBox({
    required String title,
    required String? info,
    required Function onChaged,
  }) {
    return GestureDetector(
      onTap: () => onChaged(),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceBetween,
        children: [
          SizedBox(
            width: 210,
            child: Text(
              info ?? 'اختیاری',
              style: const TextStyle(
                fontSize: 17,
                color: CustomColor.pink,
                overflow: TextOverflow.ellipsis,
              ),
            ),
          ),
          Text(
            title,
            style: const TextStyle(
              fontSize: 17,
              color: CustomColor.black,
            ),
          ),
        ],
      ),
    );
  }
}
