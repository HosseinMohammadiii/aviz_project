import 'package:aviz_project/screen/aboutaviz.dart';
import 'package:aviz_project/screen/display_ad_save_items.dart';
import 'package:aviz_project/screen/my_advertising_screen.dart';
import 'package:aviz_project/widgets/displayreconnection.dart';
import 'package:aviz_project/widgets/information_user_account.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:package_info_plus/package_info_plus.dart';
import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_state.dart';
import '../class/checkconnection.dart';
import '../class/colors.dart';
import 'recent_user_ad_items.dart';

class AccountScreen extends StatefulWidget {
  const AccountScreen({super.key});

  @override
  State<AccountScreen> createState() => _AccountScreenState();
}

class _AccountScreenState extends State<AccountScreen> {
  String appVersion = '';
  @override
  void initState() {
    _loadAppVersion();
    super.initState();
  }

  Future<void> _loadAppVersion() async {
//Initializing packageInfo variable with PackageInfo
    final packageInfo = await PackageInfo.fromPlatform();
    setState(() {
//Initializing appVersion variable with packageInfo version constructor
      appVersion = "نسخه ${packageInfo.version}";
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: AppBar(
        elevation: 0,
        automaticallyImplyLeading: false,
        centerTitle: true,
        title: Image.asset(
          'images/logo_avizman.png',
        ),
      ),
      body: BlocBuilder<AuthAccountBloc, AuthAccountState>(
        builder: (context, state) {
          if (state is AuthErrorState) {
            return DisplayReconnection(screen: 'حساب کاربری');
          } else if (state is AuthLoadingState) {
            return const Center(
              child: CircularProgressIndicator(
                color: CustomColor.normalRed,
              ),
            );
          } else if (state is DisplayInformationState) {
            return state.displayUserInformation.fold(
              (error) => DisplayReconnection(screen: 'حساب کاربری'),
              (r) {
                return SafeArea(
                  child: Padding(
                    padding: const EdgeInsets.symmetric(horizontal: 15),
                    child: Column(
                      children: [
                        Expanded(
                          child: CustomScrollView(
                            slivers: [
                              SliverPadding(
                                padding:
                                    const EdgeInsets.only(bottom: 20, top: 25),
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
                                      const SizedBox(width: 5),
                                      Image.asset('images/profile_logo.png'),
                                    ],
                                  ),
                                ),
                              ),
                              const SliverToBoxAdapter(
                                  child: InfoAccountUser()),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 50),
                              ),
                              SliverToBoxAdapter(
                                child: itemsAccountButton(
                                  title: 'آگهی های من',
                                  icon: 'images/note_red.png',
                                  onTap: () async {
                                    //Checking Internet Connection
                                    if (!await checkInternetConnection(context))
                                      return;
                                    //Navigation to MyAdvertisingScreen Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const MyAdvertisingScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: itemsAccountButton(
                                  title: 'بازدید های اخیر',
                                  icon: 'images/eye.png',
                                  onTap: () async {
                                    //Checking Internet Connection
                                    if (!await checkInternetConnection(context))
                                      return;

                                    //Navigation to MyAdvertisingScreen Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const RecentUserAdItems(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: itemsAccountButton(
                                  title: 'ذخیره شده ها',
                                  icon: 'images/save-2.png',
                                  onTap: () async {
                                    //Checking Internet Connection
                                    if (!await checkInternetConnection(context))
                                      return;

                                    //Navigation to MyAdvertisingScreen Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const DisplayAdSaveItems(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              SliverToBoxAdapter(
                                child: itemsAccountButton(
                                  title: 'درباره آویز',
                                  icon: 'images/info-circle.png',
                                  onTap: () {
                                    //Navigation to MyAdvertisingScreen Screen
                                    Navigator.push(
                                      context,
                                      MaterialPageRoute(
                                        builder: (context) =>
                                            const AboutAvizScreen(),
                                      ),
                                    );
                                  },
                                ),
                              ),
                              const SliverToBoxAdapter(
                                child: SizedBox(height: 50),
                              ),
                              SliverFillRemaining(
                                hasScrollBody: false,
                                child: Column(
                                  mainAxisAlignment: MainAxisAlignment.end,
                                  children: [
                                    Text(
                                      appVersion,
                                      textAlign: TextAlign.center,
                                    ),
                                    const SizedBox(height: 20),
                                  ],
                                ),
                              ),
                            ],
                          ),
                        ),
                      ],
                    ),
                  ),
                );
              },
            );
          } else {
            return const SizedBox.shrink();
          }
        },
      ),
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
