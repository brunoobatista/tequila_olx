import 'dart:convert';

import 'package:intl/intl.dart';

class Converter {
  static double fromBRLToDouble(String value) {
    value =
        value.replaceAll(RegExp(r'\.'), '').replaceFirst(RegExp(r'\,'), '.');
    return double.parse(value);
  }

  static String fromDoubleToBRL(
      {required double value, String format = '', String locale = 'pt_BR'}) {
    final currencyFormat;
    if (format.isEmpty)
      currencyFormat = NumberFormat.currency(locale: locale, symbol: '');
    else
      currencyFormat = NumberFormat(format, locale);

    return currencyFormat.format(value);
  }
}
