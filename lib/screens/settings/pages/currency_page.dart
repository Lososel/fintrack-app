import 'package:flutter/material.dart';
import 'package:fintrack_app/components/nav/bottom_nav.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/screens/home/widgets/modals/currency_modal.dart';
import 'package:fintrack_app/utils/modal_helper.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class CurrencyPage extends StatefulWidget {
  const CurrencyPage({super.key});

  @override
  State<CurrencyPage> createState() => _CurrencyPageState();
}

class _CurrencyPageState extends State<CurrencyPage> {
  Currency _fromCurrency = Currency.dollar;
  Currency _toCurrency = Currency.euro;
  final TextEditingController _fromAmountController = TextEditingController(text: "100");

  @override
  void initState() {
    super.initState();
    _fromAmountController.addListener(_calculateConversion);
  }

  @override
  void dispose() {
    _fromAmountController.dispose();
    super.dispose();
  }

  void _calculateConversion() {
    setState(() {
      // Trigger rebuild to update converted amount
    });
  }

  double _getExchangeRate(Currency from, Currency to) {
    if (from == to) return 1.0;
    
    // Simple exchange rates (in production, fetch from API)
    // Base: USD
    if (from == Currency.dollar && to == Currency.euro) {
      return 0.9200;
    } else if (from == Currency.euro && to == Currency.dollar) {
      return 1.0869; // 1 / 0.9200
    } else if (from == Currency.dollar && to == Currency.tenge) {
      return 450.0; // Approximate
    } else if (from == Currency.tenge && to == Currency.dollar) {
      return 0.0022; // 1 / 450
    } else if (from == Currency.euro && to == Currency.tenge) {
      return 489.0; // Approximate
    } else if (from == Currency.tenge && to == Currency.euro) {
      return 0.0020; // 1 / 489
    }
    
    return 1.0;
  }

  double _getConvertedAmount() {
    final amount = double.tryParse(_fromAmountController.text) ?? 0.0;
    final rate = _getExchangeRate(_fromCurrency, _toCurrency);
    return amount * rate;
  }

  void _swapCurrencies() {
    setState(() {
      final temp = _fromCurrency;
      _fromCurrency = _toCurrency;
      _toCurrency = temp;
      // Swap amounts - calculate with old currencies first
      final currentAmount = double.tryParse(_fromAmountController.text) ?? 0.0;
      final oldRate = _getExchangeRate(_toCurrency, _fromCurrency); // Reverse rate
      final swappedAmount = currentAmount * oldRate;
      _fromAmountController.text = swappedAmount.toStringAsFixed(2);
    });
  }

  void _openFromCurrencyModal() {
    ModalHelper.showSmoothModal(
      context: context,
      child: CurrencyModal(
        selectedCurrency: _fromCurrency,
        onSelected: (currency) {
          setState(() {
            _fromCurrency = currency;
          });
        },
      ),
    );
  }

  void _openToCurrencyModal() {
    ModalHelper.showSmoothModal(
      context: context,
      child: CurrencyModal(
        selectedCurrency: _toCurrency,
        onSelected: (currency) {
          setState(() {
            _toCurrency = currency;
          });
        },
      ),
    );
  }

  String _getCurrencyDisplay(Currency currency) {
    return "${currency.code} - ${currency.name}";
  }

  String _formatAmount(double amount) {
    if (amount == amount.truncateToDouble()) {
      return amount.toStringAsFixed(0);
    }
    return amount.toStringAsFixed(2);
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final convertedAmount = _getConvertedAmount();
    final currentRate = _getExchangeRate(_fromCurrency, _toCurrency);

    return Scaffold(
      backgroundColor: const Color(0xffF6F6F9),
      bottomNavigationBar: const HomeBottomNav(currentIndex: 3),
      body: SafeArea(
        child: SingleChildScrollView(
          padding: const EdgeInsets.symmetric(horizontal: 24),
          child: Column(
            crossAxisAlignment: CrossAxisAlignment.start,
            children: [
              const SizedBox(height: 16),
              Row(
                children: [
                  IconButton(
                    icon: const Icon(Icons.arrow_back, color: Colors.black),
                    onPressed: () => Navigator.pop(context),
                  ),
                  const SizedBox(width: 8),
                  Expanded(
                    child: Text(
                      localizations.currencyConverter,
                      style: const TextStyle(
                        fontSize: 22,
                        fontWeight: FontWeight.w900,
                        color: Colors.black,
                      ),
                      overflow: TextOverflow.ellipsis,
                    ),
                  ),
                ],
              ),
              const SizedBox(height: 24),
              // Current Exchange Rate Card
              Container(
                width: double.infinity,
                padding: const EdgeInsets.all(20),
                decoration: BoxDecoration(
                  color: Colors.black,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  crossAxisAlignment: CrossAxisAlignment.center,
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Text(
                      localizations.currentExchangeRate,
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      currentRate.toStringAsFixed(4),
                      style: const TextStyle(
                        fontSize: 40,
                        fontWeight: FontWeight.w900,
                        color: Colors.white,
                      ),
                    ),
                    const SizedBox(height: 8),
                    Text(
                      "1 ${_fromCurrency.code} = ${currentRate.toStringAsFixed(4)} ${_toCurrency.code}",
                      style: const TextStyle(
                        fontSize: 14,
                        fontWeight: FontWeight.w400,
                        color: Colors.white70,
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // From Section
              Text(
                localizations.from,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _openFromCurrencyModal,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getCurrencyDisplay(_fromCurrency),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              TextField(
                controller: _fromAmountController,
                keyboardType: const TextInputType.numberWithOptions(decimal: true),
                style: const TextStyle(fontSize: 16),
                decoration: InputDecoration(
                  hintText: "0",
                  hintStyle: const TextStyle(color: Colors.black54, fontSize: 16),
                  contentPadding: const EdgeInsets.symmetric(
                    horizontal: 20,
                    vertical: 18,
                  ),
                  filled: true,
                  fillColor: Colors.white,
                  border: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  enabledBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black26),
                  ),
                  focusedBorder: OutlineInputBorder(
                    borderRadius: BorderRadius.circular(20),
                    borderSide: const BorderSide(color: Colors.black),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // Swap Button
              Center(
                child: GestureDetector(
                  onTap: _swapCurrencies,
                  child: Container(
                    width: 48,
                    height: 48,
                    decoration: const BoxDecoration(
                      color: Colors.black,
                      shape: BoxShape.circle,
                    ),
                    child: const Icon(
                      Icons.swap_horiz,
                      color: Colors.white,
                      size: 24,
                    ),
                  ),
                ),
              ),
              const SizedBox(height: 24),
              // To Section
              Text(
                localizations.to,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w600,
                  color: Colors.black87,
                ),
              ),
              const SizedBox(height: 8),
              GestureDetector(
                onTap: _openToCurrencyModal,
                child: Container(
                  padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(20),
                    border: Border.all(color: Colors.black26),
                  ),
                  child: Row(
                    mainAxisAlignment: MainAxisAlignment.spaceBetween,
                    children: [
                      Text(
                        _getCurrencyDisplay(_toCurrency),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black,
                        ),
                      ),
                      const Icon(
                        Icons.keyboard_arrow_down,
                        color: Colors.black54,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 12),
              Container(
                padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 18),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(20),
                  border: Border.all(color: Colors.black26),
                ),
                child: Row(
                  children: [
                    Expanded(
                      child: Text(
                        convertedAmount.toStringAsFixed(2),
                        style: const TextStyle(
                          fontSize: 16,
                          color: Colors.black54,
                        ),
                      ),
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 24),
              // Conversion Details
              Text(
                localizations.conversionDetails,
                style: const TextStyle(
                  fontSize: 16,
                  fontWeight: FontWeight.w700,
                  color: Colors.black,
                ),
              ),
              const SizedBox(height: 16),
              Container(
                padding: const EdgeInsets.all(16),
                decoration: BoxDecoration(
                  color: Colors.white,
                  borderRadius: BorderRadius.circular(16),
                ),
                child: Column(
                  children: [
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizations.youSend,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${_fromCurrency.symbol}${_formatAmount(double.tryParse(_fromAmountController.text) ?? 0.0)}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Colors.black,
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizations.theyReceive,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "${_toCurrency.symbol}${convertedAmount.toStringAsFixed(2)}",
                          style: const TextStyle(
                            fontSize: 14,
                            fontWeight: FontWeight.w600,
                            color: Color(0xFF31A05F), // Green color
                          ),
                        ),
                      ],
                    ),
                    const SizedBox(height: 12),
                    Row(
                      mainAxisAlignment: MainAxisAlignment.spaceBetween,
                      children: [
                        Text(
                          localizations.exchangeRate,
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                        Text(
                          "1 ${_fromCurrency.code} = ${currentRate.toStringAsFixed(4)} ${_toCurrency.code}",
                          style: const TextStyle(
                            fontSize: 14,
                            color: Colors.grey,
                            fontWeight: FontWeight.w400,
                          ),
                        ),
                      ],
                    ),
                  ],
                ),
              ),
              const SizedBox(height: 80),
            ],
          ),
        ),
      ),
    );
  }
}
