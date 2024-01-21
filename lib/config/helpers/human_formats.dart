
import 'package:intl/intl.dart';
//!Aprender a usar este paquete - se mirá muy bueno
class HumanFormats {
  static String number( double number ){
    final formatNumber = NumberFormat.compactCurrency(
      decimalDigits: 0,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formatNumber;
  }
}