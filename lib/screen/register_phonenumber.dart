import 'package:aviz_project/Hive/Advertising/register_id.dart';
import 'package:flutter/material.dart';
import 'package:flutter/services.dart';
import 'package:flutter_bloc/flutter_bloc.dart';
import 'package:loading_indicator/loading_indicator.dart';

import '../DataFuture/account/Bloc/account_bloc.dart';
import '../DataFuture/account/Bloc/account_event.dart';
import '../DataFuture/account/Bloc/account_state.dart';
import '../class/checkconnection.dart';
import '../class/colors.dart';
import '../class/scaffoldmessage.dart';

class RegisterPhonenumber extends StatefulWidget {
  const RegisterPhonenumber({super.key});

  @override
  State<RegisterPhonenumber> createState() => _RegisterPhonenumberState();
}

class _RegisterPhonenumberState extends State<RegisterPhonenumber> {
  final phoneNumberController = TextEditingController();
  bool isShowErrorText = false;
  String errorText = '';
  @override
  Widget build(BuildContext context) {
    return BlocBuilder<AuthAccountBloc, AuthAccountState>(
      builder: (context, state) => Scaffold(
        appBar: AppBar(
          leadingWidth: double.infinity,
          scrolledUnderElevation: 0,
          automaticallyImplyLeading: false,
          elevation: 0,
          leading: Padding(
            padding: const EdgeInsets.symmetric(horizontal: 18),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.spaceBetween,
              children: [
                const Spacer(),
                const Text(
                  'شماره موبایل',
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
                  child: const Icon(Icons.arrow_forward_ios_rounded),
                ),
              ],
            ),
          ),
        ),
        bottomNavigationBar: GestureDetector(
          onTap: () async {
            //Checking Internet Connection Befor Register Information Ad in the Database
            if (!await checkInternetConnection(context)) {
              return;
            }

            // Checking if any of the required text fields are empty
            else if (phoneNumberController.text.isEmpty) {
              // Display a dialog prompting the user to fill in PhoneNumber Field
              showMessage(
                MessageSnackBar.checkPhoneNumber,
                context,
                2,
              );
            } else {
              // Phone number validation for Iranian format
              bool isValidPhoneNumber(String text) {
                final RegExp regex = RegExp(r'^09\d{9}$');
                return regex.hasMatch(text);
              }

              // Validate phone number and show error if invalid
              if (!isValidPhoneNumber(phoneNumberController.text)) {
                setState(() {
                  errorText = 'شماره تلفن معتبر وارد کنید';
                  isShowErrorText = true;
                });
                return;
              } else {
                setState(() {
                  isShowErrorText = false;
                });
                RegisterId().setPhoneNumber(phoneNumberController.text);
              }
              if (state is! AuthLoadingState) {
                // Update phone number using Bloc event
                context.read<AuthAccountBloc>().add(
                      UpdatePhoNumberUserEvent(
                        phoneNumberController.text,
                      ),
                    );
                Navigator.pop(context, phoneNumberController.text);
              }
            }
          },
          child: Container(
            height: 40,
            alignment: Alignment.center,
            margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
            decoration: BoxDecoration(
              color: CustomColor.red,
              borderRadius: BorderRadius.circular(4),
            ),
            child: Row(
              mainAxisAlignment: MainAxisAlignment.center,
              children: [
                Visibility(
                  visible: state is! AuthLoadingState,
                  replacement: LoadingIndicator(
                    indicatorType: Indicator.ballPulse,
                    strokeWidth: 10,
                    colors: [
                      CustomColor.white,
                    ],
                  ),
                  child: Text(
                    'ثبت',
                    textAlign: TextAlign.center,
                    style: TextStyle(
                      color: CustomColor.white,
                      fontSize: 16,
                      fontFamily: 'SN',
                      fontWeight: FontWeight.w600,
                    ),
                  ),
                ),
              ],
            ),
          ),
        ),
        body: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.end,
            children: [
              const Text(
                'شماره موبایل خود را وارد کنید',
                style: TextStyle(
                  fontSize: 18,
                  color: CustomColor.black,
                  fontWeight: FontWeight.w700,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Text(
                '.برای ساخت آگهی، لطفا شماره موبایل خود را وارد کنید',
                style: TextStyle(
                  fontSize: 15,
                  color: CustomColor.grey500,
                ),
              ),
              const SizedBox(
                height: 5,
              ),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 8),
                margin: const EdgeInsets.symmetric(vertical: 10),
                decoration: BoxDecoration(
                  borderRadius: BorderRadius.circular(4),
                  color: CustomColor.grey300,
                ),
                child: TextField(
                  keyboardType: TextInputType.phone,
                  textInputAction: TextInputAction.done,
                  // focusNode: focusNode,
                  controller: phoneNumberController,
                  textAlign: TextAlign.end,
                  style: TextStyle(
                    fontFamily: 'SN',
                    fontSize: 20,
                    color: CustomColor.grey500,
                  ),
                  decoration: InputDecoration(
                    enabledBorder: InputBorder.none,
                    focusedBorder: InputBorder.none,
                    hintText: 'شماره موبایل',
                    hintStyle: TextStyle(
                      fontFamily: 'SN',
                      fontSize: 18,
                      color: CustomColor.grey500,
                    ),
                  ),
                  onTapOutside: (event) {
                    FocusScope.of(context).unfocus();
                  },
                  onChanged: (value) {},
                  inputFormatters: [
                    LengthLimitingTextInputFormatter(11),
                    FilteringTextInputFormatter.digitsOnly,
                  ],
                ),
              ),
              Visibility(
                visible: isShowErrorText,
                child: Text(
                  errorText,
                  style: TextStyle(
                    fontSize: 14,
                    color: CustomColor.red,
                  ),
                ),
              ),
            ],
          ),
        ),
      ),
    );
  }
}
