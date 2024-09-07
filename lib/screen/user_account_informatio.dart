import 'dart:async';
import 'dart:io';

import 'package:aviz_project/DataFuture/NetworkUtil/authmanager.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_bloc.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_state.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/search_provinces.dart';
import 'package:cached_network_image/cached_network_image.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:image_picker/image_picker.dart';
import 'package:shimmer/shimmer.dart';

import '../DataFuture/account/Data/model/account.dart';
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
      if (text.contains(character)) {
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

                      context
                          .read<AuthAccountBloc>()
                          .add(UpdateAvataUserEvent(galleryFile!));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: CustomColor.grey500,
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
                      context
                          .read<AuthAccountBloc>()
                          .add(UpdateAvataUserEvent(galleryFile!));
                    } else {
                      ScaffoldMessenger.of(context).showSnackBar(
                        SnackBar(
                          backgroundColor: CustomColor.grey500,
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
  void initState() {
    BlocProvider.of<AuthAccountBloc>(context).add(DisplayInformationEvent());
    super.initState();
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
          child: BlocBuilder<AuthAccountBloc, AuthAccountState>(
            builder: (context, state) {
              return CustomScrollView(
                slivers: [
                  if (state is AuthLoadingState) ...[
                    const SliverFillRemaining(
                      child: Center(
                        child: CircularProgressIndicator(),
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  if (state is DisplayInformationState) ...[
                    state.displayUserInformation.fold(
                      (error) => SliverToBoxAdapter(
                        child: Center(
                          child: textWidget(
                            error,
                            CustomColor.black,
                            16,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                      (r) => SliverToBoxAdapter(
                        child: showandselectProfileImage(context, r),
                      ),
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 18,
                    ),
                  ),
                  if (state is DisplayInformationState) ...[
                    state.displayUserInformation.fold(
                      (error) => SliverToBoxAdapter(
                        child: Center(
                          child: textWidget(
                            error,
                            CustomColor.black,
                            16,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                      (r) {
                        return SliverToBoxAdapter(
                          child: GestureDetector(
                            onTap: () async {
                              usernameController.text = r.name;
                              isShowErrorText = false;
                              await showBottomSheet(
                                context: context,
                                title: 'نام کاربری',
                                label: 'نام کاربری',
                                icon: Icon(
                                  Icons.person_outline_sharp,
                                  color: CustomColor.grey500,
                                ),
                                focusNode: usernameFocusNode,
                                inputType: TextInputType.name,
                                controller: usernameController,
                                registration: () {
                                  if (usernameController.text.length < 3 ||
                                      usernameController.text.length > 25) {
                                    setState(() {
                                      isShowErrorText = true;
                                      errorText =
                                          'طول <<اسم>> می تواند حداقل 3 و حداکثر 25 حرف باشد';
                                    });
                                    return;
                                  }

                                  context.read<AuthAccountBloc>().add(
                                      UpdateNameUserEvent(
                                          usernameController.text));
                                  Navigator.pop(context);
                                },
                              );
                            },
                            child: Row(
                              mainAxisAlignment: MainAxisAlignment.center,
                              children: [
                                const Icon(
                                  Icons.edit_outlined,
                                  size: 20,
                                  color: CustomColor.red,
                                ),
                                Text(
                                  r.name,
                                  textDirection: TextDirection.rtl,
                                  style: const TextStyle(
                                    fontSize: 17,
                                    color: CustomColor.black,
                                  ),
                                ),
                              ],
                            ),
                          ),
                        );
                      },
                    ),
                  ],
                  const SliverToBoxAdapter(
                    child: SizedBox(
                      height: 30,
                    ),
                  ),
                  if (state is DisplayInformationState) ...[
                    state.displayUserInformation.fold(
                      (l) => SliverToBoxAdapter(
                        child: Center(
                          child: textWidget(
                            l,
                            CustomColor.black,
                            16,
                            FontWeight.w500,
                          ),
                        ),
                      ),
                      (r) => SliverToBoxAdapter(
                        child: Column(
                          children: [
                            rowEnterInformationBox(
                              info: r.email,
                              title: 'پست الکترونیکی',
                              onChaged: () async {
                                isShowErrorText = false;

                                emailController.text = r.email;
                                return showBottomSheet(
                                  context: context,
                                  title: 'پست الکترونیکی',
                                  label: 'پست الکترونیکی',
                                  icon: Icon(
                                    Icons.email_outlined,
                                    color: CustomColor.grey500,
                                  ),
                                  controller: emailController,
                                  focusNode: emailFocusNode,
                                  inputType: TextInputType.emailAddress,
                                  registration: () {
                                    bool isValidEmail(String email) {
                                      final emailRegex = RegExp(
                                          r'^[\w-\.]+@([\w-]+\.)+[\w-]{2,4}$');
                                      return emailRegex.hasMatch(email);
                                    }

                                    if (!isValidEmail(emailController.text)) {
                                      errorText =
                                          'پست الکترونیکی معتبر وارد کنید';
                                      isShowErrorText = true;
                                      return;
                                    }
                                    if (isShowErrorText) {
                                      return;
                                    }
                                    context.read<AuthAccountBloc>().add(
                                        UpdateEmailUserEvent(
                                            emailController.text));
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            rowEnterInformationBox(
                              info: r.phoneNumber.toString(),
                              title: 'شماره موبایل',
                              onChaged: () {
                                if (r.phoneNumber != 0) {
                                  phoneNumberController.text =
                                      r.phoneNumber.toString();
                                }
                                isShowErrorText = false;

                                return showBottomSheet(
                                  context: context,
                                  title: 'شماره موبایل',
                                  label: 'شماره موبایل',
                                  icon: Icon(
                                    Icons.phone_enabled_outlined,
                                    color: CustomColor.grey500,
                                  ),
                                  focusNode: phoneNumberFocusNode,
                                  controller: phoneNumberController,
                                  inputType: TextInputType.phone,
                                  registration: () {
                                    bool isValidPhoneNumber(String text) {
                                      final RegExp regex = RegExp(r'^09\d{9}$');
                                      return regex.hasMatch(text);
                                    }

                                    if (!isValidPhoneNumber(
                                        phoneNumberController.text)) {
                                      errorText = 'شماره تلفن معتبر وارد کنید';
                                      isShowErrorText = true;
                                      return;
                                    }

                                    context
                                        .read<AuthAccountBloc>()
                                        .add(UpdatePhoNumberUserEvent(
                                          int.parse(phoneNumberController.text),
                                        ));
                                    Navigator.pop(context);
                                  },
                                );
                              },
                            ),
                            const SizedBox(
                              height: 25,
                            ),
                            rowEnterInformationBox(
                              info: r.province,
                              title: 'استان',
                              onChaged: () {
                                Navigator.push(
                                  context,
                                  MaterialPageRoute(
                                    builder: (context) =>
                                        const SearchProvincesScreen(),
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
                    ),
                  ],
                ],
              );
            },
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
    required Icon icon,
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
                                cursorColor: CustomColor.pink,
                                showCursor: true,
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
                                  prefixIcon: icon,
                                  // prefixIcon: Image.asset(
                                  //   'images/user_icon_text.png',
                                  //   scale: 6,
                                  // ),
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
                          Visibility.maintain(
                            visible: isShowErrorText,
                            child: SizedBox(
                              height: 30,
                              child: textWidget(
                                errorText,
                                CustomColor.pink,
                                15,
                                FontWeight.w400,
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
                                style: TextStyle(
                                  fontSize: 16,
                                  color: Colors.white,
                                  fontWeight: FontWeight.bold,
                                ),
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
  Widget showandselectProfileImage(
    BuildContext context,
    AccountInformation accountIno,
  ) {
    return Stack(
      alignment: Alignment.center,
      children: [
        ClipRRect(
          borderRadius: BorderRadius.circular(50),
          child: SizedBox(
            height: 100,
            width: 100,
            child: CachedNetworkImage(
              imageUrl: accountIno.avatar,
              height: 107,
              width: double.infinity,
              fit: BoxFit.cover,
              errorWidget: (context, url, error) => Center(
                child: Image.asset('images/user_profile.png'),
              ),
              placeholder: (context, url) => Center(
                child: Shimmer.fromColors(
                  baseColor: const Color(0xffE1E1E1),
                  highlightColor: const Color(0xffF3F3F2),
                  child: const Center(),
                ),
              ),
            ),
          ),
        ),
        Positioned(
          bottom: 0,
          left: 146,
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
                Authmanager().isLogout();

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
              info == '' || info == '0' ? 'اختیاری' : info!,
              style: TextStyle(
                fontSize: 17,
                color: info == '' || info == '0'
                    ? CustomColor.grey500
                    : CustomColor.pink,
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
