import 'package:aviz_project/class/colors.dart';
import 'package:flutter/material.dart';

class AboutAvizScreen extends StatefulWidget {
  const AboutAvizScreen({super.key});

  @override
  State<AboutAvizScreen> createState() => _AboutAvizScreenState();
}

class _AboutAvizScreenState extends State<AboutAvizScreen> {
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
                'درباره آویز',
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
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.stretch,
            children: [
              const Center(
                child: Padding(
                  padding: EdgeInsets.symmetric(vertical: 15),
                  child: Text(
                    'درباره آویز',
                    style: TextStyle(
                      fontSize: 25,
                      fontWeight: FontWeight.w700,
                      color: CustomColor.black,
                    ),
                  ),
                ),
              ),
              Text(
                'آویز با هدف خرید،فروش و اجاره املاک بدون واسطه آنلاین آغاز به فعالیت کرد.',
                textDirection: TextDirection.rtl,
                textAlign: TextAlign.center,
                style: TextStyle(
                  fontSize: 16,
                  color: CustomColor.grey500,
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
