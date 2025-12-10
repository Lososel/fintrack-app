import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/services/currency_conversion_service.dart';
import 'package:fintrack_app/screens/analytics/widgets/time_period_selector.dart';

class IncomeExpenseTrendChart extends StatefulWidget {
  final List<TransactionModel> transactions;
  final TimePeriod selectedPeriod;

  const IncomeExpenseTrendChart({
    super.key,
    required this.transactions,
    required this.selectedPeriod,
  });

  @override
  State<IncomeExpenseTrendChart> createState() =>
      _IncomeExpenseTrendChartState();
}

class _IncomeExpenseTrendChartState extends State<IncomeExpenseTrendChart> {
  List<FlSpot>? _incomeSpots;
  List<FlSpot>? _expenseSpots;
  List<String>? _xAxisLabels;
  double? _maxY;

  @override
  void initState() {
    super.initState();
    _calculateData();
  }

  @override
  void didUpdateWidget(IncomeExpenseTrendChart oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.selectedPeriod != widget.selectedPeriod ||
        oldWidget.transactions != widget.transactions) {
      _calculateData();
    }
  }

  Future<void> _calculateData() async {
    final now = DateTime.now();
    DateTime startDate;
    int numberOfPoints;

    switch (widget.selectedPeriod) {
      case TimePeriod.day:
        startDate = DateTime(now.year, now.month, now.day);
        numberOfPoints = 24; // Hours in a day
        break;
      case TimePeriod.week:
        startDate = now.subtract(Duration(days: now.weekday - 1));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        numberOfPoints = 7; // Days in a week
        break;
      case TimePeriod.month:
        // Rolling 30 days including today (from 29 days ago to today)
        startDate = now.subtract(const Duration(days: 29));
        startDate = DateTime(startDate.year, startDate.month, startDate.day);
        numberOfPoints = 30; // 30 days including today
        break;
      case TimePeriod.year:
        startDate = DateTime(now.year, 1, 1);
        numberOfPoints = 12; // Months in a year
        break;
    }

    final endDate = DateTime(now.year, now.month, now.day, 23, 59, 59);

    // Filter transactions for the selected period
    final filteredTransactions = widget.transactions.where((transaction) {
      return transaction.date.isAfter(
            startDate.subtract(const Duration(days: 1)),
          ) &&
          transaction.date.isBefore(endDate.add(const Duration(days: 1)));
    }).toList();

    // Initialize data points
    final incomeData = List<double>.filled(numberOfPoints, 0.0);
    final expenseData = List<double>.filled(numberOfPoints, 0.0);
    final labels = <String>[];

    final conversionService = CurrencyConversionService();

    // Group transactions by time period with currency conversion
    for (var transaction in filteredTransactions) {
      int index;

      switch (widget.selectedPeriod) {
        case TimePeriod.day:
          index = transaction.date.hour;
          break;
        case TimePeriod.week:
          index = transaction.date.difference(startDate).inDays;
          break;
        case TimePeriod.month:
          index = transaction.date.difference(startDate).inDays;
          break;
        case TimePeriod.year:
          index = transaction.date.month - 1;
          break;
      }

      if (index >= 0 && index < numberOfPoints) {
        // Convert to base currency before summing
        final convertedAmount = await conversionService.convertToBase(
          transaction.amount,
          transaction.currency,
        );
        if (transaction.isIncome) {
          incomeData[index] += convertedAmount;
        } else {
          expenseData[index] += convertedAmount;
        }
      }
    }

    // Generate labels
    for (int i = 0; i < numberOfPoints; i++) {
      DateTime labelDate;
      switch (widget.selectedPeriod) {
        case TimePeriod.day:
          labelDate = startDate.add(Duration(hours: i));
          labels.add('${labelDate.hour.toString().padLeft(2, '0')}:00');
          break;
        case TimePeriod.week:
          labelDate = startDate.add(Duration(days: i));
          labels.add(_getDayAbbreviation(labelDate.weekday));
          break;
        case TimePeriod.month:
          labelDate = startDate.add(Duration(days: i));
          labels.add('${labelDate.day}');
          break;
        case TimePeriod.year:
          labelDate = DateTime(now.year, i + 1, 1);
          labels.add(_getMonthAbbreviation(labelDate.month));
          break;
      }
    }

    // Create FlSpot lists - ensure all values are >= 0
    _incomeSpots = List.generate(
      numberOfPoints,
      (index) => FlSpot(
        index.toDouble(),
        incomeData[index].clamp(0.0, double.infinity),
      ),
    );
    _expenseSpots = List.generate(
      numberOfPoints,
      (index) => FlSpot(
        index.toDouble(),
        expenseData[index].clamp(0.0, double.infinity),
      ),
    );

    // Calculate max Y value
    final maxIncome = incomeData.isEmpty
        ? 0
        : incomeData.reduce((a, b) => a > b ? a : b);
    final maxExpense = expenseData.isEmpty
        ? 0
        : expenseData.reduce((a, b) => a > b ? a : b);
    _maxY =
        (maxIncome > maxExpense ? maxIncome : maxExpense) *
        1.2; // Add 20% padding
    if (_maxY! < 100) _maxY = 100; // Minimum scale

    _xAxisLabels = labels;
    setState(() {});
  }

  String _getDayAbbreviation(int weekday) {
    const days = ['Mon', 'Tue', 'Wed', 'Thu', 'Fri', 'Sat', 'Sun'];
    return days[weekday - 1];
  }

  String _getMonthAbbreviation(int month) {
    const months = [
      'Jan',
      'Feb',
      'Mar',
      'Apr',
      'May',
      'Jun',
      'Jul',
      'Aug',
      'Sep',
      'Oct',
      'Nov',
      'Dec',
    ];
    return months[month - 1];
  }

  int _getXAxisInterval() {
    switch (widget.selectedPeriod) {
      case TimePeriod.day:
        return 4; // Show every 4 hours (6 labels total)
      case TimePeriod.week:
        return 1; // Show all 7 days
      case TimePeriod.month:
        // For 30 days, show every 5th day (6 labels total) to prevent overflow
        return 5;
      case TimePeriod.year:
        return 2; // Show every 2 months (6 labels total)
    }
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;
    final gridColor = isDark ? Colors.grey.shade700 : const Color(0xFFAAA6A6);
    final borderColor = isDark ? Colors.grey.shade700 : const Color(0xFFAAA6A6);
    
    if (_incomeSpots == null || _expenseSpots == null || _xAxisLabels == null) {
      return const SizedBox.shrink();
    }

    if (widget.transactions.isEmpty) {
      return Container(
        width: double.infinity,
        padding: const EdgeInsets.all(30),
        decoration: BoxDecoration(
          color: isDark ? const Color(0xFF181820) : Colors.white,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Center(
          child: Builder(
            builder: (context) {
              final localizations =
                  AppLocalizations.of(context) ??
                  AppLocalizations(const Locale('en'));
              return Text(
                localizations.noTransactionsYet,
                style: TextStyle(
                  fontSize: 12,
                  color: secondaryTextColor,
                ),
              );
            },
          ),
        ),
      );
    }

    final xAxisInterval = _getXAxisInterval();
    final yAxisInterval = _maxY! / 3; // Show only 3 Y-axis labels instead of 5

    return Container(
      width: double.infinity,

      child: Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Builder(
            builder: (context) {
              final localizations =
                  AppLocalizations.of(context) ??
                  AppLocalizations(const Locale('en'));
              return Text(
                localizations.incomeExpenseTrend,
                style: TextStyle(
                  fontSize: 22,
                  fontWeight: FontWeight.w900,
                  color: textColor,
                ),
              );
            },
          ),

          const SizedBox(height: 16),
          SizedBox(
            height: 200,
            child: LineChart(
              LineChartData(
                gridData: FlGridData(
                  show: true,
                  drawVerticalLine: false,
                  horizontalInterval: yAxisInterval,
                  getDrawingHorizontalLine: (value) {
                    return FlLine(
                      color: gridColor,
                      strokeWidth: 1,
                    );
                  },
                ),
                titlesData: FlTitlesData(
                  show: true,
                  rightTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  topTitles: const AxisTitles(
                    sideTitles: SideTitles(showTitles: false),
                  ),
                  bottomTitles: AxisTitles(
                    axisNameSize: 0,
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: widget.selectedPeriod == TimePeriod.month
                          ? 35
                          : 24,
                      interval:
                          1, // Use interval of 1 to get all values, then filter in getTitlesWidget
                      getTitlesWidget: (value, meta) {
                        final index = value.toInt();
                        final lastIndex = _xAxisLabels!.length - 1;
                        // Show labels at intervals OR the last label
                        final isAtInterval = index % xAxisInterval == 0;
                        final isLastLabel = index == lastIndex;
                        final shouldShow =
                            index >= 0 &&
                            index < _xAxisLabels!.length &&
                            (isAtInterval || isLastLabel);

                        if (shouldShow) {
                          // Use wider width for day view (time format "00:00" needs more space)
                          final labelWidth =
                              widget.selectedPeriod == TimePeriod.day
                              ? 35.0
                              : 25.0;
                          return Padding(
                            padding: const EdgeInsets.only(top: 4.0),
                            child: SizedBox(
                              width: labelWidth,
                              child: Text(
                                _xAxisLabels![index],
                                style: TextStyle(
                                  color: secondaryTextColor,
                                  fontSize: 9,
                                  fontWeight: FontWeight.w500,
                                ),
                                textAlign: TextAlign.center,
                                maxLines: 1,
                                overflow: TextOverflow.visible,
                              ),
                            ),
                          );
                        }
                        return const SizedBox.shrink();
                      },
                    ),
                  ),
                  leftTitles: AxisTitles(
                    sideTitles: SideTitles(
                      showTitles: true,
                      reservedSize: 45,
                      interval: yAxisInterval,
                      getTitlesWidget: (value, meta) {
                        // Format large numbers more compactly
                        String formattedValue;
                        if (value >= 1000) {
                          formattedValue =
                              '\$${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k';
                        } else {
                          formattedValue = '\$${value.toStringAsFixed(0)}';
                        }
                        return Padding(
                          padding: const EdgeInsets.only(right: 4.0),
                          child: Text(
                            formattedValue,
                            style: TextStyle(
                              color: secondaryTextColor,
                              fontSize: 9,
                              fontWeight: FontWeight.w500,
                            ),
                            textAlign: TextAlign.right,
                          ),
                        );
                      },
                    ),
                  ),
                ),
                borderData: FlBorderData(
                  show: true,
                  border: Border.all(color: borderColor, width: 1),
                ),
                clipData: FlClipData(
                  top: false,
                  bottom: false,
                  left: false,
                  right: false,
                ),
                minX: 0,
                maxX: (_incomeSpots!.length - 1).toDouble(),
                minY: 0,
                maxY: _maxY,
                lineTouchData: const LineTouchData(enabled: false),
                lineBarsData: [
                  LineChartBarData(
                    spots: _incomeSpots!,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    preventCurveOverShooting: true,
                    color: Colors.green,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.green.withOpacity(0.1),
                      cutOffY: 0,
                      applyCutOffY: true,
                    ),
                  ),
                  LineChartBarData(
                    spots: _expenseSpots!,
                    isCurved: true,
                    curveSmoothness: 0.35,
                    preventCurveOverShooting: true,
                    color: Colors.red,
                    barWidth: 2.5,
                    isStrokeCapRound: true,
                    dotData: const FlDotData(show: false),
                    belowBarData: BarAreaData(
                      show: true,
                      color: Colors.red.withOpacity(0.1),
                      cutOffY: 0,
                      applyCutOffY: true,
                    ),
                  ),
                ],
              ),
            ),
          ),
          const SizedBox(height: 12),
          Builder(
            builder: (context) {
              final localizations =
                  AppLocalizations.of(context) ??
                  AppLocalizations(const Locale('en'));
              return Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(localizations.income, Colors.green),
                  const SizedBox(width: 20),
                  _buildLegendItem(localizations.expense, Colors.red),
                ],
              );
            },
          ),
        ],
      ),
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black87;
    
    return Row(
      children: [
        Container(
          width: 10,
          height: 10,
          decoration: BoxDecoration(color: color, shape: BoxShape.circle),
        ),
        const SizedBox(width: 6),
        Text(
          label,
          style: TextStyle(
            fontSize: 11,
            color: textColor,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
