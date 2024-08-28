import 'package:aviz_project/DataFuture/account/Bloc/account_event.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/extension/button.dart';
// import 'package:aviz_project/screen/confirmationnumber_screen.dart';
import 'package:aviz_project/screen/usersignupinfo.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/textfield_box.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_state.dart';
import '../widgets/buttomnavigationbar.dart';

class InputNumberScreen extends StatelessWidget {
  const InputNumberScreen({super.key});

  @override
  Widget build(BuildContext context) {
    final TextEditingController _userNameController = TextEditingController();
    final TextEditingController _passwordController = TextEditingController();
    return Scaffold(
      appBar: PreferredSize(
        preferredSize: const Size(0, 0),
        child: AppBar(),
      ),
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
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
              TextFieldBox(
                hint: 'نام کاربری',
                textInputType: TextInputType.text,
                controller: _userNameController,
                countLine: 1,
                focusNode: FocusNode(),
                textInputAction: TextInputAction.done,
              ),
              const SizedBox(
                height: 30,
              ),
              TextFieldBox(
                hint: 'رمز عبور',
                controller: _passwordController,
                textInputType: TextInputType.text,
                countLine: 1,
                focusNode: FocusNode(),
                textInputAction: TextInputAction.done,
              ),
              const Spacer(),
              BlocConsumer<AuthAccountBloc, AuthAccountState>(
                builder: (context, state) {
                  if (state is AuthInitiateState) {
                    return GestureDetector().textButton(
                      () {
                        BlocProvider.of<AuthAccountBloc>(context).add(
                          AuthLoginRequest(
                            _userNameController.text,
                            _passwordController.text,
                          ),
                        );
                      },
                      'ورود',
                      CustomColor.red,
                      CustomColor.grey,
                      false,
                    );
                  }
                  if (state is AuthLoadingState) {
                    return const CircularProgressIndicator();
                  }
                  return const Center(
                    child: Text(
                      '!خطای نامشخص',
                      style: TextStyle(
                        fontSize: 20,
                        color: CustomColor.pink,
                      ),
                    ),
                  );
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
                        Navigator.push(
                          context,
                          MaterialPageRoute(
                            builder: (context) => BottomNavigationScreen(),
                          ),
                        );
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
    );
  }
}
