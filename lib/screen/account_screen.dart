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
        title: Image.asset('images/my_aviz.png'),
        automaticallyImplyLeading: false,
      ),
      body: SafeArea(
        child: CustomScrollView(
          slivers: [
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 8),
              sliver: SliverToBoxAdapter(
                child: Column(
                  children: [
                    Container(
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
                  ],
                ),
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.only(
                  left: 15, right: 15, bottom: 20, top: 25),
              sliver: SliverToBoxAdapter(
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
            ),
            const SliverPadding(
              padding: EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: InfoAccountUser(),
              ),
            ),
            const SliverToBoxAdapter(
              child: SizedBox(
                height: 50,
              ),
            ),
            SliverPadding(
              padding: const EdgeInsets.symmetric(horizontal: 15),
              sliver: SliverToBoxAdapter(
                child: itemsAccountButton(),
              ),
            ),
            SliverToBoxAdapter(
              child: Column(
                children: [
                  textWidget(
                    'نسخه',
                    Colors.grey[400]!,
                    14,
                    FontWeight.w400,
                  ),
                  textWidget(
                    '۱.۵.۹',
                    Colors.grey[400]!,
                    14,
                    FontWeight.w400,
                  ),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget For display Items Account Button
  Widget itemsAccountButton() {
    List itemText = [
      'پرداخت های من',
      'بازدید های اخیر',
      'ذخیره شده ها',
      'تنظیمات',
      'پشتیبانی و قوانین',
      'درباره آویز',
    ];
    List itemImage = [
      'images/card.png',
      'images/eye.png',
      'images/save-2.png',
      'images/setting.png',
      'images/message-question.png',
      'images/info-circle.png',
    ];
    return SizedBox(
      height: 390,
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
