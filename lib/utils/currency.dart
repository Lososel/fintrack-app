enum Currency {
  dollar('USD', '\$', 'Dollar'),
  tenge('KZT', '₸', 'Tenge'),
  euro('EUR', '€', 'Euro');

  final String code;
  final String symbol;
  final String name;

  const Currency(this.code, this.symbol, this.name);
}

class CurrencyHelper {
  static String formatAmount(double amount, Currency currency) {
    return '${currency.symbol}${amount.toStringAsFixed(2)}';
  }

  static String formatAmountWithSign(double amount, Currency currency, bool isIncome) {
    final sign = isIncome ? '+' : '-';
    return '$sign${currency.symbol}${amount.toStringAsFixed(2)}';
  }
}

