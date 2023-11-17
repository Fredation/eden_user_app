import 'package:flutter/material.dart';
import 'package:intl/intl.dart';

GlobalKey<NavigatorState> navigatorKey = GlobalKey<NavigatorState>();

String formatMoney({required num amount, String? symbol}) {
  final format = NumberFormat.currency(
      locale: "en_US", symbol: (symbol == null ? "NGN " : "$symbol "));
  return format.format(amount);
}
