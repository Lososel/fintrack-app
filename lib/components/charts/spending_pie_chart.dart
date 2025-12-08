import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/category_colors.dart';
import 'package:fintrack_app/utils/currency.dart';

class SpendingPieChart extends StatefulWidget {
  final List<CategorySpending> spendingByCategory;
  final Currency currency;
  final double? totalSpending;
  final double size;
  final double centerSpaceRadius;
  final double baseRadius;
  final double touchedRadius;
  final Widget? centerWidget;
  final bool showCategoryDetails;

  const SpendingPieChart({
    super.key,
    required this.spendingByCategory,
    required this.currency,
    this.totalSpending,
    this.size = 180,
    this.centerSpaceRadius = 50,
    this.baseRadius = 60,
    this.touchedRadius = 65,
    this.centerWidget,
    this.showCategoryDetails = false,
  });

  @override
  State<SpendingPieChart> createState() => _SpendingPieChartState();
}

class _SpendingPieChartState extends State<SpendingPieChart> {
  int? _touchedIndex;

  @override
  Widget build(BuildContext context) {
    // Handle empty data
    if (widget.spendingByCategory.isEmpty) {
      return Center(
        child: Builder(
          builder: (context) {
            final localizations =
                AppLocalizations.of(context) ??
                AppLocalizations(const Locale('en'));
            return Text(
              localizations.noExpensesYet,
              style: const TextStyle(fontSize: 14, color: Colors.black54),
            );
          },
        ),
      );
    }

    final calculatedTotal =
        widget.totalSpending ??
        widget.spendingByCategory.fold<double>(
          0.0,
          (sum, item) => sum + item.amount,
        );

    return SizedBox(
      width: widget.size,
      height: widget.size,
      child: Stack(
        alignment: Alignment.center,
        children: [
          PieChart(
            PieChartData(
              sectionsSpace: 2,
              centerSpaceRadius: widget.centerSpaceRadius,
              sections: _buildPieChartSections(),
              pieTouchData: PieTouchData(
                touchCallback: (FlTouchEvent event, pieTouchResponse) {
                  setState(() {
                    if (!event.isInterestedForInteractions ||
                        pieTouchResponse == null ||
                        pieTouchResponse.touchedSection == null) {
                      _touchedIndex = null;
                      return;
                    }
                    final index =
                        pieTouchResponse.touchedSection!.touchedSectionIndex;
                    if (index >= 0 &&
                        index < widget.spendingByCategory.length) {
                      _touchedIndex = index;
                    } else {
                      _touchedIndex = null;
                    }
                  });
                },
              ),
            ),
          ),
          if (widget.centerWidget != null)
            widget.centerWidget!
          else if (_touchedIndex != null &&
              _touchedIndex! >= 0 &&
              _touchedIndex! < widget.spendingByCategory.length)
            _buildTouchedContent(calculatedTotal)
          else
            _buildDefaultContent(calculatedTotal),
        ],
      ),
    );
  }

  Widget _buildTouchedContent(double totalSpending) {
    final categorySpending = widget.spendingByCategory[_touchedIndex!];

    if (widget.showCategoryDetails) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            categorySpending.category,
            style: const TextStyle(fontSize: 16, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyHelper.formatAmount(
              categorySpending.amount,
              widget.currency,
            ),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 4),
          Text(
            "${categorySpending.percentage.toStringAsFixed(1)}%",
            style: const TextStyle(fontSize: 14, color: Colors.black54),
          ),
        ],
      );
    } else {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          Text(
            categorySpending.category,
            style: const TextStyle(fontSize: 14, fontWeight: FontWeight.w600),
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyHelper.formatAmount(
              categorySpending.amount,
              widget.currency,
            ),
            style: const TextStyle(fontSize: 18, fontWeight: FontWeight.w900),
          ),
        ],
      );
    }
  }

  Widget _buildDefaultContent(double totalSpending) {
    if (widget.showCategoryDetails) {
      return Column(
        mainAxisSize: MainAxisSize.min,
        children: [
          const Text(
            'Total',
            style: TextStyle(fontSize: 14, color: Colors.black54),
          ),
          const SizedBox(height: 4),
          Text(
            CurrencyHelper.formatAmount(totalSpending, widget.currency),
            style: const TextStyle(fontSize: 20, fontWeight: FontWeight.w900),
          ),
        ],
      );
    } else {
      return const Text(
        'Tap',
        style: TextStyle(fontSize: 12, color: Colors.black54),
        textAlign: TextAlign.center,
      );
    }
  }

  List<PieChartSectionData> _buildPieChartSections() {
    return widget.spendingByCategory.asMap().entries.map((entry) {
      final index = entry.key;
      final categorySpending = entry.value;
      final color = CategoryColors.getColor(categorySpending.category);
      final isTouched = index == _touchedIndex;
      final radius = isTouched ? widget.touchedRadius : widget.baseRadius;

      return PieChartSectionData(
        value: categorySpending.amount,
        title: '',
        color: color,
        radius: radius,
      );
    }).toList();
  }
}
