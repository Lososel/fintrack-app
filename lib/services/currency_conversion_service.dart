import 'dart:convert';
import 'package:http/http.dart' as http;
import 'package:fintrack_app/utils/currency.dart';

class CurrencyConversionService {
  static final CurrencyConversionService _instance =
      CurrencyConversionService._internal();
  factory CurrencyConversionService() => _instance;
  CurrencyConversionService._internal();

  // Base currency for all calculations (USD)
  static const Currency baseCurrency = Currency.dollar;

  // Cache for exchange rates
  Map<String, double> _exchangeRates = {};
  DateTime? _lastFetchTime;
  static const Duration _cacheDuration = Duration(hours: 24);

  // Fallback exchange rates (updated manually, used if API fails)
  static const Map<String, double> _fallbackRates = {
    'USD': 1.0,
    'EUR': 0.92, // 1 USD = 0.92 EUR
    'KZT': 450.0, // 1 USD = 450 KZT
  };

  /// Get exchange rate from cache or fetch from API
  Future<double> getExchangeRate(Currency from, Currency to) async {
    if (from == to) return 1.0;

    // Check if we need to refresh rates
    if (_lastFetchTime == null ||
        DateTime.now().difference(_lastFetchTime!) > _cacheDuration) {
      await _fetchExchangeRates();
    }

    // Get rates from cache or fallback
    final rates = _exchangeRates.isNotEmpty ? _exchangeRates : _fallbackRates;

    // Convert through USD (base currency)
    if (from == baseCurrency) {
      // Converting from USD to another currency
      final toRate = rates[to.code] ?? _fallbackRates[to.code] ?? 1.0;
      return toRate;
    } else if (to == baseCurrency) {
      // Converting to USD from another currency
      final fromRate = rates[from.code] ?? _fallbackRates[from.code] ?? 1.0;
      return 1.0 / fromRate;
    } else {
      // Converting between two non-USD currencies
      final fromRate = rates[from.code] ?? _fallbackRates[from.code] ?? 1.0;
      final toRate = rates[to.code] ?? _fallbackRates[to.code] ?? 1.0;
      return toRate / fromRate;
    }
  }

  /// Fetch exchange rates from API
  Future<void> _fetchExchangeRates() async {
    try {
      // Using exchangerate-api.com (free, no API key required)
      final response = await http.get(
        Uri.parse('https://api.exchangerate-api.com/v4/latest/USD'),
      ).timeout(const Duration(seconds: 5));

      if (response.statusCode == 200) {
        final data = json.decode(response.body);
        final rates = data['rates'] as Map<String, dynamic>;
        
        _exchangeRates = rates.map((key, value) => 
          MapEntry(key, (value as num).toDouble())
        );
        _lastFetchTime = DateTime.now();
      } else {
        // Use fallback rates if API fails
        _exchangeRates = Map.from(_fallbackRates);
      }
    } catch (e) {
      // Use fallback rates on error
      _exchangeRates = Map.from(_fallbackRates);
    }
  }

  /// Convert amount from one currency to another
  Future<double> convertAmount(
    double amount,
    Currency from,
    Currency to,
  ) async {
    if (from == to) return amount;
    final rate = await getExchangeRate(from, to);
    return amount * rate;
  }

  /// Convert amount to base currency (USD)
  Future<double> convertToBase(double amount, Currency from) async {
    return convertAmount(amount, from, baseCurrency);
  }

  /// Convert multiple amounts to base currency and sum them
  Future<double> convertAndSum(
    List<({double amount, Currency currency})> amounts,
  ) async {
    double total = 0.0;
    for (final item in amounts) {
      final converted = await convertToBase(item.amount, item.currency);
      total += converted;
    }
    return total;
  }
}

