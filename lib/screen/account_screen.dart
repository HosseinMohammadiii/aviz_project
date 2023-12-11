import 'package:aviz_project/widgets/information_user_account.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/my_aviz.png'),
            Image.asset('images/icon_home_active.png'),
          ],
        ),
      ),
      body: SafeArea(
        child: SingleChildScrollView(
          child: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 15),
            child: Column(
              children: [
                Container(
                  margin: const EdgeInsets.symmetric(vertical: 18),
                  height: 45,
                  decoration: BoxDecoration(
                    borderRadius: BorderRadius.circular(4),
                  ),
                  child: TextField(
                    keyboardType: TextInputType.text,
                    textAlign: TextAlign.end,
                    textDirection: TextDirection.ltr,
                    textAlignVertical: TextAlignVertical.center,
                    style: TextStyle(
                      fontFamily: 'SN',
                      fontSize: 18,
                      color: Colors.grey[500],
                    ),
                    decoration: InputDecoration(
                      suffixIcon: Image.asset('images/search-normal.png'),
                      enabledBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[350]!,
                        ),
                      ),
                      focusedBorder: OutlineInputBorder(
                        borderSide: BorderSide(
                          color: Colors.grey[350]!,
                        ),
                      ),
                      hintText: '...جستوجو',
                      hintStyle: TextStyle(
                        fontFamily: 'SN',
                        fontSize: 16,
                        fontWeight: FontWeight.w400,
                        color: Colors.grey[500],
                      ),
                    ),
                  ),
                ),
                Padding(
                  padding: const EdgeInsets.only(bottom: 18, top: 18),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      textWidget(
                        'حساب کاربری',
                        Colors.black,
                        16,
                        FontWeight.w700,
                      ),
                      const SizedBox(
                        width: 5,
                      ),
                      Image.asset('images/profile_logo.png'),
                    ],
                  ),
                ),
                const InfoAccountUser(),
                const SizedBox(
                  height: 50,
                ),
                itemsAccountButton(),
              ],
            ),
          ),
        ),
      ),
    );
  }

  List itemText = [
    'آگهی های من',
    'پرداخت های من',
    'بازدید های اخیر',
    'ذخیره شده ها',
    'تنظیمات',
    'پشتیبانی و قوانین',
    'درباره آویز',
  ];
  List itemImage = [
    'images/note-2.png',
    'images/card.png',
    'images/eye.png',
    'images/save-2.png',
    'images/setting.png',
    'images/message-question.png',
    'images/info-circle.png',
  ];

//Widget For display Items Account Button
  Widget itemsAccountButton() {
    return SizedBox(
      height: MediaQuery.of(context).size.height / 2.1,
      child: ListView.builder(
        itemCount: itemText.length,
        physics: const NeverScrollableScrollPhysics(),
        itemBuilder: (context, index) {
          return Container(
            height: 40,
            margin: const EdgeInsets.symmetric(vertical: 8),
            padding: const EdgeInsets.symmetric(horizontal: 8),
            alignment: Alignment.center,
            decoration: BoxDecoration(
              border: Border.all(color: Colors.grey[350]!),
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                Icon(
                  Icons.arrow_back_ios_rounded,
                  color: Colors.grey[400],
                ),
                const Spacer(),
                textWidget(
                  itemText[index],
                  Colors.black,
                  16,
                  FontWeight.w700,
                ),
                const SizedBox(
                  width: 10,
                ),
                Image.asset(itemImage[index]),
              ],
            ),
          );
        },
      ),
    );
  }
}
