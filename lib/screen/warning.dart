import 'package:flutter/material.dart';

import '../class/colors.dart';

// ignore: must_be_immutable
class WarningScreen extends StatelessWidget {
  const WarningScreen({
    super.key,
  });

  //List Text the First Part=> 'روش‌های رایج کلاهبرداری در املاک'
  static const List listtxt1 = [
    '- دریافت بیعانه',
    '- اجاره یا فروش همزمان ملک به چند نفر',
    '- دریافت پول به بهانهٔ ارسال عکس و بازدید',
    '- اجاره یا فروش ملک با سند یا شرایط مشکل‌دار',
  ];

  //List Text the Second Part=>  'در این موارد به شدت احتیاط کنید'
  static const List listtxt2 = [
    'آگهی‌گذار درخواست بیعانه دارد',
    'قیمت ملک پایین و وسوسه‌کننده‌ است',
    'وضعیت سند مشخص نیست',
  ];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        scrolledUnderElevation: 0,
        leadingWidth: double.infinity,
        leading: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: [
              const Spacer(),
              const Text(
                'هشدار های قبل از معامله',
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
                child: const Icon(
                  Icons.arrow_forward_ios_rounded,
                ),
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
                  height: 15,
                ),
              ),
              SliverToBoxAdapter(
                child: Text(
                  'روش‌های رایج کلاهبرداری در املاک',
                  textDirection: TextDirection.rtl,
                  style: Theme.of(context).textTheme.displayMedium,
                ),
              ),
              const SliverToBoxAdapter(
                child: SizedBox(
                  height: 15,
                ),
              ),
              SliverList.builder(
                itemCount: listtxt1.length,
                itemBuilder: (context, index) {
                  return Text(
                    listtxt1[index],
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.displaySmall,
                  );
                },
              ),
              SliverPadding(
                padding: const EdgeInsets.only(top: 60, bottom: 10),
                sliver: SliverToBoxAdapter(
                  child: Text(
                    'در این موارد به شدت احتیاط کنید',
                    textDirection: TextDirection.rtl,
                    style: Theme.of(context).textTheme.displayMedium,
                  ),
                ),
              ),
              SliverList.builder(
                itemCount: listtxt2.length,
                itemBuilder: (context, index) {
                  return Row(
                    mainAxisAlignment: MainAxisAlignment.end,
                    children: [
                      Padding(
                        padding: const EdgeInsets.symmetric(vertical: 8),
                        child: Text(
                          listtxt2[index],
                          textDirection: TextDirection.rtl,
                          style: Theme.of(context).textTheme.displaySmall,
                        ),
                      ),
                      const Padding(
                        padding: EdgeInsets.only(left: 15),
                        child: Icon(
                          Icons.not_interested_rounded,
                          color: CustomColor.pink,
                        ),
                      ),
                    ],
                  );
                },
              ),
            ],
          ),
        ),
      ),
    );
  }
}
