import 'package:intl/intl.dart';

extension FormatMixins on double {
  //
  String get currentyPTBR {
    final currentyFormart = NumberFormat.currency(
      locale: 'pt_br',
      symbol: r'R$',
    );
    return currentyFormart.format(this);
  }
}
