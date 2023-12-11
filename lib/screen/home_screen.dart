import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/screen/information_advertising.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';

class HomeScreen extends StatefulWidget {
  const HomeScreen({super.key});

  @override
  State<HomeScreen> createState() => _HomeScreenState();
}

class _HomeScreenState extends State<HomeScreen> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        backgroundColor: Colors.transparent,
        elevation: 0,
        title: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Image.asset('images/aviz.png'),
            Image.asset('images/icon_home_active.png'),
          ],
        ),
      ),
      body: SafeArea(
        child: Column(
          children: [
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textWidget(
                  'مشاهده همه',
                  Colors.grey[400]!,
                  14,
                  FontWeight.w400,
                ),
                const SizedBox(
                  width: 130,
                ),
                textWidget(
                  'آویز های داغ',
                  Colors.black,
                  16,
                  FontWeight.w700,
                ),
              ],
            ),
            SizedBox(
              height: 250,
              child: ListView.builder(
                scrollDirection: Axis.horizontal,
                itemCount: 10,
                reverse: true,
                itemBuilder: (context, index) {
                  return hotestAdvertisingBox();
                },
              ),
            ),
            const SizedBox(
              height: 20,
            ),
            Row(
              mainAxisAlignment: MainAxisAlignment.spaceAround,
              children: [
                textWidget(
                  'مشاهده همه',
                  Colors.grey[400]!,
                  14,
                  FontWeight.w400,
                ),
                const SizedBox(
                  width: 130,
                ),
                textWidget(
                  'آویز های اخیر',
                  Colors.black,
                  16,
                  FontWeight.w700,
                ),
              ],
            ),
            SizedBox(
              height: MediaQuery.of(context).size.height / 2.2,
              child: ListView.builder(
                padding: const EdgeInsets.symmetric(vertical: 15),
                itemCount: 5,
                itemBuilder: (context, index) {
                  return recentlyAdvertisingBox();
                },
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget For display recently Advertising
  GestureDetector recentlyAdvertisingBox() {
    return GestureDetector(
      onTap: () {
        Navigator.push(
          context,
          MaterialPageRoute(
            builder: (context) => const InformationAdvertising(),
          ),
        );
      },
      child: Container(
        width: double.maxFinite,
        height: 140,
        margin: const EdgeInsets.symmetric(horizontal: 15),
        padding: const EdgeInsets.symmetric(horizontal: 15),
        alignment: Alignment.center,
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(4),
          color: Colors.white,
          boxShadow: const [
            BoxShadow(
              color: Colors.black,
              blurRadius: 40,
              spreadRadius: -35,
              offset: Offset(0, 8),
            ),
          ],
        ),
        child: Row(
          crossAxisAlignment: CrossAxisAlignment.center,
          children: [
            SizedBox(
              width: 111,
              child: Image.asset(
                'images/Image_home2.png',
              ),
            ),
            const SizedBox(
              width: 20,
            ),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.end,
                mainAxisAlignment: MainAxisAlignment.spaceEvenly,
                children: [
                  const SizedBox(
                    height: 5,
                  ),
                  textWidget(
                    'واحد دوبلکس فول امکانات',
                    Colors.black,
                    14,
                    FontWeight.w700,
                  ),
                  textWidget(
                    'سال ساخت ۱۳۹۸، سند تک برگ، دوبلکس تجهیزات کامل',
                    Colors.black,
                    12,
                    FontWeight.w400,
                  ),
                  const SizedBox(
                    height: 10,
                  ),
                  priceText(),
                ],
              ),
            ),
          ],
        ),
      ),
    );
  }

//Widget For display hotest Advertising
  Container hotestAdvertisingBox() {
    return Container(
      width: 210,
      height: 240,
      padding: const EdgeInsets.all(16),
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(4),
        color: Colors.white,
        boxShadow: const [
          BoxShadow(
            color: Colors.black,
            blurRadius: 40,
            spreadRadius: -35,
            offset: Offset(0, 8),
          ),
        ],
      ),
      child: Column(
        crossAxisAlignment: CrossAxisAlignment.end,
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: [
          Image.asset('images/Image_home.png'),
          textWidget(
            'ویلا ۵۰۰ متری زیر قیمت',
            Colors.black,
            14,
            FontWeight.w700,
          ),
          textWidget(
            'ویو عالی، سند تک برگ، سال ساخت ۱۴۰۲، تحویل فوری',
            Colors.grey[500]!,
            12,
            FontWeight.w400,
          ),
          priceText(),
        ],
      ),
    );
  }

//Widget For display Price Advertising
  Row priceText() {
    return Row(
      mainAxisAlignment: MainAxisAlignment.spaceBetween,
      children: [
        Container(
          width: 91,
          height: 26,
          margin: const EdgeInsets.only(bottom: 10),
          alignment: Alignment.center,
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(2),
            color: Colors.grey[200],
          ),
          child: textWidget(
              '۲۵٬۶۸۳٬۰۰۰٬۰۰۰', CustomColor.red, 12, FontWeight.w500),
        ),
        textWidget('قیمت:', Colors.black, 12, FontWeight.w500)
      ],
    );
  }
}
