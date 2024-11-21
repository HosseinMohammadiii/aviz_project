import 'package:aviz_project/DataFuture/add_advertising/Data/model/register_future_ad.dart';
import 'package:aviz_project/class/colors.dart';
import 'package:aviz_project/class/scaffoldmessage.dart';
import 'package:aviz_project/widgets/text_widget.dart';
import 'package:flutter/material.dart';
import 'package:url_launcher/url_launcher.dart';

// ignore: must_be_immutable
class ButtonWidget extends StatelessWidget {
  ButtonWidget({
    super.key,
    required this.advertising,
  });
  RegisterFutureAd advertising;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: () async {
        await showModalBottomSheet(
          context: context,
          backgroundColor: Colors.transparent,
          barrierColor: Colors.transparent,
          isScrollControlled: true,
          builder: (context) {
            return Padding(
              padding: MediaQuery.of(context).viewInsets,
              child: Container(
                decoration: const BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.only(
                    topLeft: Radius.circular(12),
                    topRight: Radius.circular(12),
                  ),
                ),
                child: Column(
                  mainAxisSize: MainAxisSize.min,
                  children: [
                    Container(
                      width: 30,
                      height: 6,
                      margin: const EdgeInsets.only(bottom: 20, top: 10),
                      alignment: Alignment.topRight,
                      decoration: BoxDecoration(
                        color: CustomColor.grey300,
                        borderRadius: BorderRadius.circular(8),
                      ),
                    ),
                    Text(
                      'اطلاعات تماس',
                      style: TextStyle(
                        fontSize: 18,
                        fontWeight: FontWeight.w700,
                        color: CustomColor.grey500,
                      ),
                    ),
                    const SizedBox(
                      height: 20,
                    ),
                    const Divider(
                      thickness: 1,
                    ),
                    callInformation(
                      onTap: () {
                        callAction(advertising.phoneNumber, context);
                      },
                      callInfo: '${advertising.phoneNumber} :تماس تلفنی با ',
                      icon: Icons.phone_enabled_outlined,
                    ),
                    callInformation(
                      onTap: () {
                        smsAction(advertising.phoneNumber, context);
                      },
                      callInfo: '${advertising.phoneNumber} :ارسال پیامک به',
                      icon: Icons.message_rounded,
                    ),
                  ],
                ),
              ),
            );
          },
        );
      },
      child: Container(
        width: double.infinity,
        height: 40,
        transformAlignment: Alignment.bottomCenter,
        margin: const EdgeInsets.only(bottom: 15, top: 25, right: 15, left: 15),
        decoration: BoxDecoration(
          color: CustomColor.red,
          borderRadius: BorderRadius.circular(4),
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            textWidget(
              'اطلاعات تماس',
              CustomColor.grey,
              16,
              FontWeight.w500,
            ),
            const SizedBox(
              width: 12,
            ),
            Image.asset('images/call_icon.png')
          ],
        ),
      ),
    );
  }

//Method for Call Advertising User
  Future<void> callAction(
    String pNumber,
    BuildContext context,
  ) async {
    var url = Uri.parse('tel:$pNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showMessage(MessageSnackBar.tryAgain, context, 1);
    }
  }

//Method for Send SMS Advertising User
  Future<void> smsAction(
    String pNumber,
    BuildContext context,
  ) async {
    var url = Uri.parse('sms:$pNumber');
    if (await canLaunchUrl(url)) {
      await launchUrl(url);
    } else {
      showMessage(MessageSnackBar.tryAgain, context, 1);
    }
  }

//Widget for Display User Call Information
  Widget callInformation({
    required Function() onTap,
    required String callInfo,
    required IconData icon,
  }) {
    return GestureDetector(
      onTap: () {
        onTap();
      },
      child: Container(
        alignment: Alignment.centerRight,
        height: 50,
        margin: const EdgeInsets.symmetric(horizontal: 15, vertical: 10),
        padding: const EdgeInsets.only(right: 5),
        decoration: BoxDecoration(
          borderRadius: BorderRadius.circular(8),
          color: CustomColor.normalRed,
        ),
        child: Row(
          mainAxisAlignment: MainAxisAlignment.end,
          children: [
            Text(
              callInfo,
              style: const TextStyle(
                fontSize: 16,
                color: Colors.white,
                fontWeight: FontWeight.bold,
              ),
            ),
            const SizedBox(
              width: 5,
            ),
            Icon(
              icon,
              color: CustomColor.white,
            ),
          ],
        ),
      ),
    );
  }
}
