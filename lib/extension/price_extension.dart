import 'package:intl/intl.dart';

extension PriceExtension on int {
  String formatter() {
    NumberFormat currencyFormat =
        NumberFormat.currency(locale: 'fa-IR', symbol: '');
    return currencyFormat.format(this);
  }
}
