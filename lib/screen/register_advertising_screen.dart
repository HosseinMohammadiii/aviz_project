import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/widgets/appbar_widget.dart';
import 'package:aviz_project/widgets/buttomnavigationbar.dart';
import 'package:aviz_project/widgets/switch_box.dart';
import 'package:aviz_project/widgets/text_title_section.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:aviz_project/widgets/upload_image.dart';
import 'package:flutter/material.dart';

class RegisterAdvertising extends StatefulWidget {
  const RegisterAdvertising({super.key});

  @override
  State<RegisterAdvertising> createState() => _RegisterAdvertisingState();
}

class _RegisterAdvertisingState extends State<RegisterAdvertising> {
  @override
  Widget build(BuildContext context) {
    return SafeArea(
      child: Scaffold(
        appBar: AppBar(
          backgroundColor: Colors.transparent,
          elevation: 0,
          automaticallyImplyLeading: false,
          flexibleSpace: AppBarWidget(stepScreen: 5),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
          child: SingleChildScrollView(
            child: Wrap(
              runSpacing: 12,
              alignment: WrapAlignment.spaceAround,
              children: [
                const TextTitleSection(
                    txt: 'تصویر آویز', img: 'images/camera_icon.png'),
                const UploadImage(),
                const TextTitleSection(
                    txt: 'عنوان آویز', img: 'images/edit2_icon.png'),
                TextFieldBox(
                  hint: 'عنوان آویز را وارد کنید',
                  textInputType: TextInputType.text,
                  countLine: 1,
                  focusNode: FocusNode(),
                ),
                const TextTitleSection(
                    txt: 'توضیحات', img: 'images/clipboard_icon.png'),
                TextFieldBox(
                  hint: '... توضیحات آویز را وارد کنید',
                  textInputType: TextInputType.text,
                  countLine: 3,
                  focusNode: FocusNode(),
                ),
                SwitchBox(switchCheck: false, txt: 'فعال کردن گفتگو'),
                SwitchBox(switchCheck: true, txt: 'فعال کردن تماس'),
                GestureDetector().textButton(
                  () {
                    Navigator.pushReplacement(
                        context,
                        MaterialPageRoute(
                          builder: (context) => const BottomNavigationScreen(),
                        ));
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
