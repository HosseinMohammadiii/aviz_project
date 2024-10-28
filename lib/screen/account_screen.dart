import 'package:aviz_project/DataFuture/recent/bloc/recent_bloc.dart';
import 'package:aviz_project/DataFuture/recent/bloc/recent_state.dart';
import 'package:aviz_project/screen/display_ad_save_items.dart';
import 'package:aviz_project/widgets/information_user_account.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/NetworkUtil/authmanager.dart';
import 'recent_user_ad_items.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<RecentBloc, RecentState>(
      builder: (context, state) {
        return Scaffold(
          appBar: AppBar(
            scrolledUnderElevation: 0,
            elevation: 0,
            centerTitle: true,
            title: Image.asset(
              'images/logo_avizman.png',
            ),
            automaticallyImplyLeading: false,
          ),
          body: SafeArea(
            child: CustomScrollView(
              slivers: [
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
                    child: itemsAccountButton(
                      title: 'بازدید های اخیر',
                      icon: 'images/eye.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const RecentUserAdItems(),
                          ),
                        );
                      },
                    ),
                  ),
                ),

                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  sliver: SliverToBoxAdapter(
                    child: itemsAccountButton(
                      title: 'ذخیره شده ها',
                      icon: 'images/save-2.png',
                      onTap: () {
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const DisplayAdSaveItems(),
                          ),
                        );
                      },
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  sliver: SliverToBoxAdapter(
                    child: itemsAccountButton(
                      title: 'پشتیبانی و قوانین',
                      icon: 'images/message-question.png',
                      onTap: () {},
                    ),
                  ),
                ),
                SliverPadding(
                  padding: const EdgeInsets.symmetric(horizontal: 15),
                  sliver: SliverToBoxAdapter(
                    child: itemsAccountButton(
                      title: 'درباره آویز',
                      icon: 'images/info-circle.png',
                      onTap: () {
                        Authmanager().isLogout();
                      },
                    ),
                  ),
                ),
                // SliverToBoxAdapter(
                //   child: Column(
                //     children: [
                //       textWidget(
                //         'نسخه',
                //         Colors.grey[400]!,
                //         14,
                //         FontWeight.w400,
                //       ),
                //       textWidget(
                //         '۱.0.0',
                //         Colors.grey[400]!,
                //         14,
                //         FontWeight.w400,
                //       ),
                //     ],
                //   ),
                // ),
              ],
            ),
          ),
        );
      },
    );
  }

//Widget For display Items Account Button
  Widget itemsAccountButton({
    required String title,
    required String icon,
    required Function onTap,
  }) {
    return GestureDetector(
      onTap: () => onTap(),
      child: Container(
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
              title,
              Colors.black,
              16,
              FontWeight.w700,
            ),
            const SizedBox(
              width: 10,
            ),
            Image.asset(icon),
          ],
        ),
      ),
    );
  }
}
