import 'package:flutter/material.dart';

//Enum Message Display Mode
enum MessageSnackBar {
  internet,
  vpnInternet,
  compeletFields,
  checkInputProvince,
  checkInputCity,
  checkPostImage,
  selectImage,
  tryAgain,
  checkUserName,
  checkPassword,
  checkUserNameWithPassword,
  errorLogIn,
  checkInputCharacters,
  checkPhoneNumber,
  saveAd,
  deleteSaveAd,
  validNumber,
}

void showMessage(MessageSnackBar message, BuildContext context, int duration) {
  String messageTitle = '';

  //Setting Message to Display in SnackBar
  switch (message) {
    case MessageSnackBar.internet:
      messageTitle = 'اتصال اینترنت خود را بررسی کنید';
      break;
    case MessageSnackBar.vpnInternet:
      messageTitle = 'VPN خود را خاموش کنید';
      break;
    case MessageSnackBar.compeletFields:
      messageTitle = 'تمامی فیلد ها را تکمیل کنید';
      break;
    case MessageSnackBar.checkInputProvince:
      messageTitle = 'ابتدا استان را انتخاب کنید';
      break;
    case MessageSnackBar.checkPostImage:
      messageTitle = 'حجم تصویر بیشتر از 1 مگابایت است!';
      break;
    case MessageSnackBar.selectImage:
      messageTitle = 'عکس مورد نظر را انتخاب کنید';
      break;
    case MessageSnackBar.tryAgain:
      messageTitle = 'مجدد تلاش کنید';
      break;
    case MessageSnackBar.checkUserName:
      messageTitle = 'نام کاربری باید بیش از 3 حرف باشد';
      break;
    case MessageSnackBar.checkPassword:
      messageTitle = 'طول رمز عبور باید بیش از 8 کاراکتر باشد';
      break;
    case MessageSnackBar.errorLogIn:
      messageTitle = 'نام کاربری یا رمز عبور اشتباه است';
      break;
    case MessageSnackBar.checkUserNameWithPassword:
      messageTitle = 'رمز عبور و تکرار رمز عبور یکسان نمی باشند';
      break;
    case MessageSnackBar.checkInputCharacters:
      messageTitle = 'کاراکتر معتبر وارد کنید';
      break;
    case MessageSnackBar.validNumber:
      messageTitle = 'عدد معتبر وارد کنید';
      break;
    case MessageSnackBar.checkPhoneNumber:
      messageTitle = 'شماره موبایل خود را وارد کنید';
      break;
    case MessageSnackBar.saveAd:
      messageTitle = 'آگهی ذخیره شد';
      break;
    case MessageSnackBar.deleteSaveAd:
      messageTitle = 'آگهی از ذخیره حذف شد';
      break;
    default:
  }
  ScaffoldMessenger.of(context).showSnackBar(SnackBar(
    content: Text(
      messageTitle,
      textDirection: TextDirection.rtl,
    ),
    duration: Duration(seconds: duration),
  ));
}
