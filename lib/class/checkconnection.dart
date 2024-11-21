import 'package:aviz_project/class/scaffoldmessage.dart';
import 'package:connectivity_plus/connectivity_plus.dart';
import 'package:flutter/material.dart';

Future<bool> checkInternetConnection(BuildContext context) async {
  // Check the connectivity status
  final List<ConnectivityResult> connectivityResult =
      await (Connectivity().checkConnectivity());

  // Return false if there is no connection
  if (connectivityResult.contains(ConnectivityResult.none)) {
    showMessage(MessageSnackBar.internet, context, 2);
    return false;
  } else if (connectivityResult.contains(ConnectivityResult.vpn)) {
    showMessage(MessageSnackBar.vpnInternet, context, 2);
    return false;
  }
  // Otherwise, return true
  return true;
}
