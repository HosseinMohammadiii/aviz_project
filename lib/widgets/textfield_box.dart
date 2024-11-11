import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../DataFuture/add_advertising/Bloc/add_advertising_bloc.dart';
import '../class/colors.dart';

// ignore: must_be_immutable
class TextFieldBox extends StatefulWidget {
  TextFieldBox({
    super.key,
    required this.hint,
    required this.textInputType,
    required this.countLine,
    required this.focusNode,
    this.controller,
    this.isShowPassword,
    this.enable = false,
    this.isPrice,
    required this.textInputAction,
  });
  String hint;
  TextInputType textInputType;
  int countLine;
  FocusNode focusNode = FocusNode();
  TextEditingController? controller;
  TextInputAction textInputAction;
  bool? isShowPassword;
  bool enable = false;
  bool? isPrice;

  @override
  State<TextFieldBox> createState() => _TextFieldBoxState();
}

class _TextFieldBoxState extends State<TextFieldBox> {
  @override
  Widget build(BuildContext context) {
    final stateAd = context.read<RegisterInfoAdCubit>().state;
    return LayoutBuilder(
      builder: (context, constraints) {
        return Container(
          padding: const EdgeInsets.symmetric(horizontal: 8),
          decoration: BoxDecoration(
            borderRadius: BorderRadius.circular(4),
            color: CustomColor.grey300,
          ),
          child: TextField(
            keyboardType: widget.textInputType,
            textInputAction: widget.textInputAction,
            maxLines: widget.countLine,
            focusNode: widget.focusNode,
            controller: widget.controller,
            obscuringCharacter: '*',
            obscureText: widget.isShowPassword ?? false,
            textAlign: TextAlign.end,
            style: TextStyle(
              fontFamily: 'SN',
              fontSize: 20,
              color: CustomColor.grey500,
            ),
            decoration: InputDecoration(
              enabledBorder: InputBorder.none,
              focusedBorder: InputBorder.none,
              icon: widget.enable
                  ? widget.isShowPassword!
                      ? GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.isShowPassword = !widget.isShowPassword!;
                            });
                          },
                          child: Image.asset(
                            'images/hide_password.png',
                            scale: 5,
                          ),
                        )
                      : GestureDetector(
                          onTap: () {
                            setState(() {
                              widget.isShowPassword = !widget.isShowPassword!;
                            });
                          },
                          child: Image.asset(
                            'images/show_password.png',
                            scale: 5,
                          ),
                        )
                  : null,
              hintText: widget.hint,
              hintStyle: TextStyle(
                fontFamily: 'SN',
                fontSize: 18,
                color: CustomColor.grey500,
              ),
            ),
            onTapOutside: (event) {
              FocusScope.of(context).unfocus();
            },
            onChanged: (value) {
              setState(() {
                switch (widget.hint) {
                  case 'عنوان آویز را وارد کنید':
                    stateAd.title = value;
                    break;
                  case '... توضیحات آویز را وارد کنید':
                    stateAd.description = value;
                    break;
                  case 'قیمت را وارد کنید':
                    stateAd.price = num.tryParse(value);
                    break;
                }
              });
            },
          ),
        );
      },
    );
  }
}
