import 'package:aviz_project/DataFuture/account/Bloc/account_bloc.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_state.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/scaffoldmessage.dart';
import 'package:aviz_project/screen/login.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../DataFuture/add_advertising/Bloc/add_advertising_event.dart';
import '../DataFuture/home/Bloc/home_bloc.dart';
import '../DataFuture/home/Bloc/home_event.dart';
import '../Hive/Advertising/register_id.dart';
import '../Hive/UsersLogin/user_login.dart';
import '../class/checkconnection.dart';
import '../class/checkinvalidcharacters.dart';
import '../widgets/buttomnavigationbar.dart';
import 'city_screen.dart';
import 'screen_province.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final _userNameController = TextEditingController();
  final _passwordController = TextEditingController();
  final _passwordConfirmController = TextEditingController();

  final __userNameFocus = FocusNode();
  final __passwordFocus = FocusNode();
  final __passwordConfirmFocus = FocusNode();

  String errorText = '';
  bool isShowErrorText = false;
  // Function to check for invalid characters in the username input
  bool checkForInvalidCharacters() {
    // Combine invalidCharacters and allCharacters
    final allInvalidChars = invalidCharacters + allCharacters;

    // Check if the username contains any of the invalid characters
    for (String character in allInvalidChars) {
      if (_userNameController.text.contains(character)) {
        setState(() {
          errorText = 'از کاراکترهای غیرمجاز استفاده شده است: $character';
          isShowErrorText = true;
        });
        return false;
      }
    }

    // If no invalid characters are found, clear the error text
    setState(() {
      errorText = '';
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
                      'خوش اومدی به',
                      CustomColor.black,
                      16,
                      FontWeight.w700,
                    ),
                  ],
                ),
                const SizedBox(
                  height: 12,
                ),
                textWidget(
                  'این فوق العادست که آویزو برای آگهی هات انتخاب کردی!',
                  CustomColor.grey500,
                  15,
                  FontWeight.w400,
                ),
                const SizedBox(
                  height: 25,
                ),
                textFieldUserNAme(
                  _userNameController,
                  __userNameFocus,
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
                  controller: _passwordController,
                  textInputType: TextInputType.text,
                  isShowPassword: true,
                  enable: true,
                  countLine: 1,
                  focusNode: __passwordFocus,
                  textInputAction: TextInputAction.next,
                ),
                const SizedBox(
                  height: 30,
                ),
                TextFieldBox(
                  hint: 'تکرار رمز عبور',
                  controller: _passwordConfirmController,
                  textInputType: TextInputType.text,
                  isShowPassword: true,
                  enable: true,
                  countLine: 1,
                  focusNode: __passwordConfirmFocus,
                  textInputAction: TextInputAction.done,
                ),
                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.4,
                ),
                BlocConsumer<AuthAccountBloc, AuthAccountState>(
                  listener: (context, state) {
                    if (state is AuthResponseState) {
                      state.response.fold(
                        (error) {
                          var snackbar = SnackBar(
                            content: Text(
                              error,
                              textDirection: TextDirection.rtl,
                              style: const TextStyle(fontSize: 14),
                            ),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 2),
                          );
                          ScaffoldMessenger.of(context).showSnackBar(snackbar);
                        },
                        (r) {
                          // Wait until the token is available
                          final Box<UserLogin> userLogin =
                              Hive.box('user_login');
                          final String? token = userLogin.get(1)?.token;
                          if (token != null && token.isNotEmpty) {
                            final provinceAndCity =
                                context.read<RegisterInfoAdCubit>().state;
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
                                                RegisterId().setCity(
                                                    provinceAndCity.city);

                                                //Call HomeGetInitializeData event from HomeBloc
                                                context.read<HomeBloc>().add(
                                                    HomeGetInitializeData());

                                                provinceAndCity.city = '';
                                                Navigator.pushReplacement(
                                                  context,
                                                  MaterialPageRoute(
                                                    builder: (context) =>
                                                        BottomNavigationScreen(),
                                                  ),
                                                );
                                              },
                                              province:
                                                  RegisterId().getProvince(),
                                            ),
                                          ));
                                    }

                                    //Register Province in the AdvertisingHive
                                    RegisterId()
                                        .setProvince(provinceAndCity.province);
                                    provinceAndCity.province = '';
                                  },
                                ),
                              ),
                            );

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
                          } else {
                            // Handle error: Token not available
                            showMessage(MessageSnackBar.tryAgain, context, 1);
                          }
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    return buttonSignUp(state);
                  },
                ),
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
                            builder: (context) => const LogInScreen(),
                          ),
                        );
                      },
                      child: textWidget(
                        '  ورود',
                        CustomColor.red,
                        17,
                        FontWeight.w600,
                      ),
                    ),
                    textWidget(
                      'قبلا ثبت نام کردی؟',
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

  //Widget For Button SignUp
  Widget buttonSignUp(AuthAccountState state) {
    return GestureDetector(
      onTap: () async {
        //Check Internet Connection
        if (!await checkInternetConnection(context)) {
          return;
        }

        // Validate input fields
        if (_userNameController.text.isEmpty ||
            _passwordController.text.isEmpty ||
            _passwordConfirmController.text.isEmpty) {
          showMessage(MessageSnackBar.compeletFields, context, 2);
          return;
        }

        //Check Valid Input Characters
        if (!checkForInvalidCharacters()) {
          return;
        }

        //Check that the UserName is not less than 3 characters long
        if (_userNameController.text.length < 3) {
          showMessage(MessageSnackBar.checkUserName, context, 2);
          return;
        }

        //Check that the Password & PasswordConfirm is not less than 8 characters long
        if (_passwordController.text.length < 8 ||
            _passwordConfirmController.text.length < 8) {
          showMessage(MessageSnackBar.checkPassword, context, 2);
          return;
        }

        //Check that the Password & PasswordConfirm repeat are the same
        if (_passwordController.text != _passwordConfirmController.text) {
          showMessage(MessageSnackBar.checkUserNameWithPassword, context, 2);
          return;
        }

        //This condition is for when the status is not AuthLoading
        if (state is! AuthLoadingState) {
          // Trigger registration event
          BlocProvider.of<AuthAccountBloc>(context).add(
            AuthRegisterRequest(
              _userNameController.text,
              _passwordController.text,
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
                'ثبت نام',
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
  }
}
