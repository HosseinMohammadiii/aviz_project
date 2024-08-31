import 'dart:io';

import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';
import 'package:flutter/rendering.dart';
import 'package:flutter/widgets.dart';
import 'package:hive/hive.dart';
import 'package:image_picker/image_picker.dart';

import '../Hive/UsersLogin/user_login.dart';
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
                child: Stack(
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
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 18,
                ),
              ),
              SliverToBoxAdapter(
                child: GestureDetector(
                  onTap: () async {
                    return showModalBottomSheet(
                      context: context,
                      useSafeArea: true,
                      builder: (context) {
                        return Padding(
                          padding: EdgeInsets.only(
                            bottom: MediaQuery.of(context).viewInsets.bottom,
                          ),
                          child: DraggableScrollableSheet(
                            expand: true,
                            initialChildSize: 0.8,
                            maxChildSize: 1,
                            minChildSize: 0.2,
                            builder: (context, scrollController) {
                              scrollController =
                                  ScrollController(initialScrollOffset: 1);

                              return Column(
                                mainAxisAlignment: MainAxisAlignment.start,
                                children: [
                                  Container(
                                    width: 30,
                                    height: 6,
                                    margin: EdgeInsets.only(bottom: 20),
                                    alignment: Alignment.topCenter,
                                    decoration: BoxDecoration(
                                      color: CustomColor.red,
                                      borderRadius: BorderRadius.circular(8),
                                    ),
                                  ),
                                  Container(
                                    width: double.infinity,
                                    margin: const EdgeInsets.symmetric(
                                        horizontal: 15),
                                    decoration: BoxDecoration(
                                      //color: CustomColor.grey350,
                                      borderRadius: BorderRadius.circular(4),
                                    ),
                                    child: Directionality(
                                      textDirection: TextDirection.rtl,
                                      child: TextField(
                                        controller: usernameController,
                                        focusNode: usernameFocusNode,
                                        autofocus: true,
                                        textDirection: TextDirection.rtl,
                                        decoration: InputDecoration(
                                          labelText: 'نام کاربری',
                                          hintTextDirection: TextDirection.rtl,
                                          labelStyle: TextStyle(
                                            fontSize: usernameFocusNode.hasFocus
                                                ? 18
                                                : 15,
                                            color: usernameFocusNode.hasFocus
                                                ? CustomColor.pink
                                                : CustomColor.grey500,
                                          ),
                                          enabledBorder: OutlineInputBorder(
                                            borderSide: BorderSide(
                                                color: CustomColor.grey500),
                                          ),
                                          focusedBorder: OutlineInputBorder(
                                            borderRadius:
                                                BorderRadius.circular(4),
                                            borderSide: BorderSide(
                                              width: 1,
                                              color: CustomColor.grey500,
                                            ),
                                          ),
                                          prefixIcon: Image.asset(
                                            'images/user_icon_text.png',
                                            scale: 6,
                                          ),
                                        ),
                                        onTapOutside: (event) {
                                          usernameFocusNode.unfocus();
                                        },
                                      ),
                                    ),
                                  ),
                                ],
                              );
                            },
                          ),
                        );
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
                      onChaged: () {},
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    rowEnterInformationBox(
                      info: '09135887182',
                      title: 'شماره موبایل',
                      onChaged: () {},
                    ),
                    const SizedBox(
                      height: 25,
                    ),
                    rowEnterInformationBox(
                      info: 'اصفهان',
                      title: 'استان',
                      onChaged: () {},
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

List<String> Provinces = [
  "آذربایجان شرقی",
  "آذربایجان غربی",
  "اردبیل",
  "اصفهان",
  "البرز",
  "ایلام",
  "بوشهر",
  "تهران",
  "چهارمحال و بختیاری",
  "خراسان جنوبی",
  "خراسان رضوی",
  "خراسان شمالی",
  "خوزستان",
  "زنجان",
  "سمنان",
  "سیستان و بلوچستان",
  "فارس",
  "قزوین",
  "قم",
  "کردستان",
  "کرمان",
  "کرمانشاه",
  "کهگیلویه وبویراحمد",
  "گلستان",
  "گیلان",
  "لرستان",
  "مازندران",
  "مرکزی",
  "هرمزگان",
  "همدان",
  "یزد"
];
