
import 'package:intl/intl.dart';
//!Aprender a usar este paquete - se mirá muy bueno
class HumanFormats {
  static String number( double number, [ int decimals = 0] ){
    final formatNumber = NumberFormat.compactCurrency(
      decimalDigits: decimals,
      symbol: '',
      locale: 'en'
    ).format(number);
    return formatNumber;
  }
}