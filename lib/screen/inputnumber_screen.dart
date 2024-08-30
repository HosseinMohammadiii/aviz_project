import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/class/colors.dart';
// import 'package:aviz_project/screen/confirmationnumber_screen.dart';
import 'package:aviz_project/screen/usersignupinfo.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:hive/hive.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_state.dart';
import '../Hive/UsersLogin/user_login.dart';
import '../class/checkinvalidcharacters.dart';
import '../class/dialog.dart';
import '../widgets/buttomnavigationbar.dart';

class InputNumberScreen extends StatefulWidget {
  const InputNumberScreen({super.key});

  @override
  State<InputNumberScreen> createState() => _InputNumberScreenState();
}

class _InputNumberScreenState extends State<InputNumberScreen> {
  final TextEditingController userNameController = TextEditingController();
  final TextEditingController passwordController = TextEditingController();

  final FocusNode userNameFocus = FocusNode();
  final FocusNode passwordFocus = FocusNode();

  String errorText = '';
  bool isShowErrorText = false;

// Function to check for invalid characters in the username input
  void checkForInvalidCharacters() {
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
                Image.asset('images/textinputnumscreen.png'),
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
                BlocConsumer<AuthAccountBloc, AuthAccountState>(
                  builder: (context, state) {
                    if (state is AuthInitiateState) {
                      return buttonLogIn();
                    }

                    return buttonLogIn();
                  },
                  listener: (context, state) {
                    if (state is AuthResponseState) {
                      state.reponse.fold(
                        (l) {
                          var snackbar = SnackBar(
                            content: Text(
                              l,
                              style: const TextStyle(fontSize: 14),
                            ),
                            backgroundColor: Colors.black,
                            behavior: SnackBarBehavior.floating,
                            duration: const Duration(seconds: 1),
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
    return GestureDetector(
      onTap: () {
        // Validate input fields
        if (userNameController.text.isEmpty ||
            passwordController.text.isEmpty) {
          displayDialog('لطفا تمامی فیلد ها را کامل کنید', context);
          return;
        }
        if (passwordController.text.length < 8) {
          displayDialog('طول رمز عبور باید بیش از 8 کاراکتر باشد', context);
          return;
        }

        if (isShowErrorText) {
          displayDialog('کاراکتر معتبر وارد کنید', context);
          return;
        }
        // Trigger registration event
        BlocProvider.of<AuthAccountBloc>(context).add(
          AuthLoginRequest(
            userNameController.text,
            passwordController.text,
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
              'ورود',
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
