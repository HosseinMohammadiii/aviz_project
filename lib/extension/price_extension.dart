import 'package:intl/intl.dart';

// This extension adds a `formatter` method to `int` that formats the number as a currency string using the Persian locale ('fa-IR').
extension PriceExtension on int {
  String formatter() {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'fa-IR', symbol: '');
    return currencyFormat.format(this);
  }
}
