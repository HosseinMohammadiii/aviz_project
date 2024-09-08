import 'package:aviz_project/class/dialog.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<bool> checkInternetConnection(BuildContext context) async {
  // Check the connectivity status
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

  // Return false if there is no connection
  if (connectivityResult.contains(ConnectivityResult.none)) {
    displayDialog('لطفاً اتصال اینترنت خود را بررسی کنید', context);
    return false;
  }
  // Otherwise, return true
  return true;
}
