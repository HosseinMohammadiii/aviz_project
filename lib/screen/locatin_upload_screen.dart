import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/extension/button.dart';
import 'package:aviz_project/widgets/switch_box.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:aviz_project/widgets/uploadlocation.dart';
import 'package:flutter/material.dart';
import 'package:flutter_bloc/flutter_bloc.dart';

import '../Bloc/bloc_page_number/page_n_bloc.dart';
import '../Bloc/bloc_page_number/page_n_bloc_state.dart';

// ignore: must_be_immutable
class LocatioUpload extends StatefulWidget {
  LocatioUpload({
    super.key,
    this.address = '',
  });
  String address;
  @override
  State<LocatioUpload> createState() => _LocatioUploadState();
}

class _LocatioUploadState extends State<LocatioUpload> {
  @override
  Widget build(BuildContext context) {
    return Scaffold(
      body: SafeArea(
        child: Padding(
          padding: const EdgeInsets.symmetric(horizontal: 15, vertical: 15),
          child: Column(
            children: [
              Row(
                mainAxisAlignment: MainAxisAlignment.end,
                children: [
                  textWidget(
                    'موقعیت مکانی',
                    CustomColor.black,
                    16,
                    FontWeight.w700,
                  ),
                  const SizedBox(
                    width: 10,
                  ),
                  Image.asset('images/map_icon.png'),
                ],
              ),
              const SizedBox(
                height: 20,
              ),
              textWidget(
                'بعد انتخاب محل دقیق روی نقشه میتوانید نمایش آن را فعال یا غیر فعال کید تا حریم خصوصی شما خفظ شود.',
                CustomColor.grey500,
                14,
                FontWeight.w400,
              ),
              const SizedBox(
                height: 70,
              ),
              UploadLocation(
                address: widget.address,
              ),
              const SizedBox(
                height: 30,
              ),
              SwitchBox(
                  switchCheck: false, txt: 'موقعیت دقیق نقشه نمایش داده شود؟'),
              const Spacer(),
              GestureDetector().textButton(
                () {
                  BlocProvider.of<NavigationPage>(context)
                      .getNavItems(ViewPage.registerHomeAdvertising);
                },
                'بعدی',
                CustomColor.red,
                CustomColor.grey,
                false,
              ),
            ],
          ),
        ),
      ),
    );
  }
}
