import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/class/colors.dart';
// import 'package:aviz_project/screen/confirmationnumber_screen.dart';
import 'package:aviz_project/screen/signup.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_state.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import '../DataFuture/home/Bloc/home_bloc.dart';
import '../DataFuture/home/Bloc/home_event.dart';

import '../Hive/Advertising/register_id.dart';
import '../class/checkconnection.dart';
import '../class/checkinvalidcharacters.dart';
import '../class/scaffoldmessage.dart';
import '../widgets/buttomnavigationbar.dart';
import 'city_screen.dart';
import 'screen_province.dart';

class LogInScreen extends StatefulWidget {
  const LogInScreen({super.key});

  @override
  State<LogInScreen> createState() => _LogInScreenState();
}

class _LogInScreenState extends State<LogInScreen> {
  final userNameController = TextEditingController();
  final passwordController = TextEditingController();

  final userNameFocus = FocusNode();
  final passwordFocus = FocusNode();

  String errorText = '';
  bool isShowErrorText = false;

// Function to check for invalid characters in the username input
  bool checkForInvalidCharacters() {
// Generate a list of all characters that are not alphanumeric and not in invalidCharacters
    final List<String> allCharacters =
        List.generate(65536, (i) => String.fromCharCode(i))
            .where((char) => !RegExp(r'[a-zA-Z0-9]').hasMatch(char))
            .toList()
            .where((char) => !invalidCharacters.contains(char))
            .toList();

// Combine invalidCharacters and allCharacters
    final allInvalidChars = invalidCharacters + allCharacters;

// Check if the username contains any of the invalid characters
    for (String character in allInvalidChars) {
      if (userNameController.text.contains(character)) {
        setState(() {
          errorText = 'از کاراکترهای غیرمجاز استفاده شده است: $character';
          isShowErrorText = true;
        });
        return false;
      }
    }

// If no invalid characters are found, clear the error text
    setState(() {
      errorText = ''; // No invalid characters found
      isShowErrorText = false;
    });
    return true;
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(
          scrolledUnderElevation: 0,
        ),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Image.asset(
                      'images/welcome_to_Aviz.png',
                      fit: BoxFit.contain,
                    ),
                    const SizedBox(
                      width: 4,
                    ),
                    textWidget(
                      'ورود به',
                      CustomColor.black,
                      16,
                      FontWeight.w700,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                textWidget('خوشحالیم که مجددا آویز رو برای آگهی انتخاب کردی!',
                    CustomColor.grey500, 15, FontWeight.w400),
                const SizedBox(
                  height: 25,
                ),
                textFieldUserNAme(
                  userNameController,
                  userNameFocus,
                ),
                Visibility(
                  visible: isShowErrorText,
                  replacement: const SizedBox(
                    height: 30,
                  ),
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
                TextFieldBox(
                  hint: 'رمز عبور',
                  controller: passwordController,
                  textInputType: TextInputType.text,
                  isShowPassword: true,
                  enable: true,
                  countLine: 1,
                  focusNode: passwordFocus,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 1.9,
                ),
                buttonLogIn(),
                const SizedBox(
                  height: 10,
                ),
                Row(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    GestureDetector(
                      onTap: () {
                        Navigator.pushReplacement(
                          context,
                          MaterialPageRoute(
                            builder: (context) => const SignUpScreen(),
                          ),
                        );
                      },
                      child: textWidget(
                        ' ثبت نام',
                        CustomColor.red,
                        17,
                        FontWeight.w600,
                      ),
                    ),
                    textWidget(
                      'تا حالا ثبت نام نکردی؟',
                      CustomColor.grey500,
                      17,
                      FontWeight.w400,
                    ),
                  ],
                ),
              ],
            ),
          ),
        ),
      ),
    );
  }

//Widget For Button LogIn
  Widget buttonLogIn() {
    return BlocConsumer<AuthAccountBloc, AuthAccountState>(
      listener: (context, state) async {
        if (state is AuthErrorState) {
          showMessage(MessageSnackBar.tryAgain, context, 1);
        } else if (state is AuthLoadingState) {
          // Reset error visibility when loading starts
          setState(() {
            isShowErrorText = false;
          });
        } else if (state is AuthResponseState) {
          state.response.fold(
            (l) async {
              // Show error message if login fails
              setState(() {
                isShowErrorText = true;
              });
              showMessage(MessageSnackBar.errorLogIn, context, 1);
            },
            (r) {
              // Hide error message if login is successful
              setState(() {
                isShowErrorText = false;
              });
              final provinceAndCity = context.read<RegisterInfoAdCubit>().state;
              Navigator.pushReplacement(
                context,
                MaterialPageRoute(
                  builder: (context) => ScreenProvince(
                    isShowIcon: false,
                    isCity: true,
                    onChanged: () {},
                    onChangedCity: () {
                      if (provinceAndCity.province != '') {
                        Navigator.push(
                            context,
                            MaterialPageRoute(
                              builder: (context) => CityScreen(
                                onChanged: () {
                                  //Register City in the AdvertisingHive
                                  RegisterId().setCity(provinceAndCity.city);

                                  provinceAndCity.city = '';
                                  //Call HomeGetInitializeData event from HomeBloc
                                  context
                                      .read<HomeBloc>()
                                      .add(HomeGetInitializeData());
                                  //Call InitializedDisplayAdvertising event from AddAdvertisingBloc
                                  context
                                      .read<AddAdvertisingBloc>()
                                      .add(InitializedDisplayAdvertising());

                                  //Call DisplayInformationEvent event from AuthAccountBloc
                                  BlocProvider.of<AuthAccountBloc>(context)
                                      .add(DisplayInformationEvent());
                                  Navigator.pushReplacement(
                                    context,
                                    MaterialPageRoute(
                                      builder: (context) =>
                                          BottomNavigationScreen(),
                                    ),
                                  );
                                },
                                province: RegisterId().getProvince(),
                              ),
                            ));
                      }

                      //Register Province in the AdvertisingHive
                      RegisterId().setProvince(provinceAndCity.province);
                      provinceAndCity.province = '';
                    },
                  ),
                ),
              );
            },
          );
        }
      },
      builder: (context, state) {
        // Display login button when not in loading state
        return GestureDetector(
          onTap: () async {
            //Check Internet Connection
            if (!await checkInternetConnection(context)) {
              return;
            }

            // Validate input fields
            if (userNameController.text.isEmpty ||
                passwordController.text.isEmpty) {
              showMessage(MessageSnackBar.compeletFields, context, 2);

              return;
            }

            //Check Valid Input Characters
            if (!checkForInvalidCharacters()) {
              return;
            }

            //Check that the UserName is not less than 3 characters long
            if (userNameController.text.length < 3) {
              showMessage(MessageSnackBar.checkUserName, context, 2);
              return;
            }

            //Check that the Password is not less than 8 characters long
            if (passwordController.text.length < 8) {
              showMessage(MessageSnackBar.checkPassword, context, 2);
              return;
            }

            //This condition is for when the status is not AuthLoading
            if (state is! AuthLoadingState) {
              // Trigger login event
              BlocProvider.of<AuthAccountBloc>(context).add(
                AuthLoginRequest(
                  userNameController.text,
                  passwordController.text,
                ),
              );
            }
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(4),
              border: Border.all(
                color: CustomColor.red,
              ),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                const SizedBox(
                  width: 8,
                ),
                Visibility(
                  visible: state is! AuthLoadingState,
                  replacement: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    strokeWidth: 10,
                    colors: [
                      CustomColor.white,
                    ],
                  ),
                  child: const Text(
                    'ورود',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColor.grey,
                      fontSize: 16,
                      fontFamily: 'SN',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        );
      },
    );
  }
}
