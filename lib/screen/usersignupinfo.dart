import 'package:aviz_project/DataFuture/account/Bloc/account_bloc.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/DataFuture/account/Bloc/account_state.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/dialog.dart';
// import 'package:aviz_project/screen/confirmationnumber_screen.dart';
import 'package:aviz_project/screen/inputnumber_screen.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../Hive/UsersLogin/user_login.dart';
import '../class/checkinvalidcharacters.dart';
import '../widgets/buttomnavigationbar.dart';

class SignUpScreen extends StatefulWidget {
  const SignUpScreen({super.key});

  @override
  State<SignUpScreen> createState() => _SignUpScreenState();
}

class _SignUpScreenState extends State<SignUpScreen> {
  final TextEditingController _userNameController = TextEditingController();
  final TextEditingController _passwordController = TextEditingController();
  final TextEditingController _passwordConfirmController =
      TextEditingController();

  final FocusNode __userNameFocus = FocusNode();
  final FocusNode __passwordFocus = FocusNode();
  final FocusNode __passwordConfirmFocus = FocusNode();

  String errorText = '';
  bool isShowErrorText = false;

// Function to check for invalid characters in the username input
  void checkForInvalidCharacters() {
// Combine invalidCharacters and allCharacters
    final allInvalidChars = invalidCharacters + allCharacters;

// Check if the username contains any of the invalid characters
    for (String character in allInvalidChars) {
      if (_userNameController.text.contains(character)) {
        setState(() {
          errorText = 'از کاراکترهای غیرمجاز استفاده شده است: $character';
          isShowErrorText = true;
        });
        return;
      }
    }

// If no invalid characters are found, clear the error text
    setState(() {
      errorText = ''; // No invalid characters found
      isShowErrorText = false;
    });
  }

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: SingleChildScrollView(
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.end,
              children: [
                Row(
                  mainAxisAlignment: MainAxisAlignment.end,
                  children: [
                    Image.asset('images/aviz_icon.png'),
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
                  () {
                    checkForInvalidCharacters();
                  },
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
                // const Spacer(),

                SizedBox(
                  height: MediaQuery.of(context).size.height / 2.4,
                ),
                BlocConsumer<AuthAccountBloc, AuthAccountState>(
                  listener: (context, state) {
                    if (state is AuthResponseState) {
                      state.reponse.fold(
                        (error) {
                          var snackbar = SnackBar(
                            content: Text(
                              error,
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
                            Navigator.pushReplacement(
                              context,
                              MaterialPageRoute(
                                builder: (context) => BottomNavigationScreen(),
                              ),
                            );
                          } else {
                            // Handle error: Token not available
                            ScaffoldMessenger.of(context).showSnackBar(
                              const SnackBar(
                                  content: Text('لطفا مجدد تلاش کنید')),
                            );
                          }
                        },
                      );
                    }
                  },
                  builder: (context, state) {
                    // if (state is AuthLoadingState) {
                    //   return const Center(child: CircularProgressIndicator());
                    // }
                    if (state is AuthInitiateState) {
                      return buttonSignUp();
                    }

                    return buttonSignUp();
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
                            builder: (context) => const InputNumberScreen(),
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
  Widget buttonSignUp() {
    return GestureDetector(
      onTap: () {
        // Validate input fields
        if (_userNameController.text.isEmpty ||
            _passwordController.text.isEmpty ||
            _passwordConfirmController.text.isEmpty) {
          displayDialog('لطفا تمامی فیلد ها را کامل کنید', context);
          return;
        }
        if (_userNameController.text.length < 3) {
          displayDialog('نام کاربری باید بیش از 3 حرف باشد', context);
          return;
        }
        if (_passwordController.text.length < 8 ||
            _passwordConfirmController.text.length < 8) {
          displayDialog('طول رمز عبور باید بیش از 8 کاراکتر باشد', context);
          return;
        }
        if (_passwordController.text != _passwordConfirmController.text) {
          displayDialog('رمز عبور با تکرار رمز عبور یکسان نمی باشند', context);
          return;
        }
        if (isShowErrorText) {
          displayDialog('کاراکتر معتبر وارد کنید', context);
          return;
        }
        // Trigger registration event
        BlocProvider.of<AuthAccountBloc>(context).add(
          AuthRegisterRequest(
            _userNameController.text,
            _passwordController.text,
            _passwordConfirmController.text,
          ),
        );
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
        child: const Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            SizedBox(
              width: 8,
            ),
            Text(
              'ثبت نام',
              textAlign: TextAlign.center,
              style: TextStyle(
                color: CustomColor.grey,
                fontSize: 16,
                fontFamily: 'SN',
                fontWeight: FontWeight.w600,
              ),
            ),
          ],
        ),
      ),
    );
  }
}
