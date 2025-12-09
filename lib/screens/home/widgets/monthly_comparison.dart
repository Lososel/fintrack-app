import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fintrack_app/models/transaction_model.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class MonthlyComparison extends StatefulWidget {
  const MonthlyComparison({super.key});

  @override
  State<MonthlyComparison> createState() => _MonthlyComparisonState();
}

class _MonthlyComparisonState extends State<MonthlyComparison> {
  final TransactionService _transactionService = TransactionService();

  @override
  void initState() {
    super.initState();
    _transactionService.addListener(_refresh);
  }

  @override
  void dispose() {
    _transactionService.removeListener(_refresh);
    super.dispose();
  }

  void _refresh() {
    setState(() {});
  }

  Map<String, double> _calculateMonthTotals(List<TransactionModel> transactions, int year, int month) {
    double income = 0;
    double expense = 0;

    for (var transaction in transactions) {
      if (transaction.date.year == year && transaction.date.month == month) {
        if (transaction.isIncome) {
          income += transaction.amount;
        } else {
          expense += transaction.amount;
        }
      }
    }

    return {'income': income, 'expense': expense};
  }

  String _getMonthAbbreviation(int month) {
    const months = ['Jan', 'Feb', 'Mar', 'Apr', 'May', 'Jun', 'Jul', 'Aug', 'Sep', 'Oct', 'Nov', 'Dec'];
    return months[month - 1];
  }

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    final now = DateTime.now();
    final currentMonth = now.month;
    final currentYear = now.year;
    
    // Calculate previous month
    final previousMonth = currentMonth == 1 ? 12 : currentMonth - 1;
    final previousYear = currentMonth == 1 ? currentYear - 1 : currentYear;

    final transactions = _transactionService.transactions;
    
    final currentMonthData = _calculateMonthTotals(transactions, currentYear, currentMonth);
    final previousMonthData = _calculateMonthTotals(transactions, previousYear, previousMonth);

    final currentIncome = currentMonthData['income']!;
    final currentExpense = currentMonthData['expense']!;
    final previousIncome = previousMonthData['income']!;
    final previousExpense = previousMonthData['expense']!;

    final maxValue = [
      currentIncome,
      currentExpense,
      previousIncome,
      previousExpense,
    ].reduce((a, b) => a > b ? a : b);

    final maxY = maxValue * 1.2; // Add 20% padding
    final yAxisInterval = maxY / 4; // Show 4 intervals

    if (maxValue == 0 && transactions.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            localizations.monthlyComparison,
            style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
          ),
          const SizedBox(height: 5),
          Padding(
            padding: const EdgeInsets.symmetric(vertical: 20),
            child: Text(
              localizations.noTransactionsYet,
              style: const TextStyle(color: Colors.black54),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Text(
          localizations.monthlyComparison,
          style: const TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
        ),
        const SizedBox(height: 16),
        Container(
          width: double.infinity,
          
          child: Column(
            children: [
              SizedBox(
                height: 250,
                child: BarChart(
                  BarChartData(
                    alignment: BarChartAlignment.spaceAround,
                    maxY: maxY < 100 ? 100 : maxY,
                    barTouchData: BarTouchData(
                      enabled: true,
                      touchTooltipData: BarTouchTooltipData(
                        getTooltipColor: (group) => Colors.white,
                        tooltipRoundedRadius: 8,
                        tooltipPadding: const EdgeInsets.all(8),
                        tooltipMargin: 8,
                        getTooltipItem: (group, groupIndex, rod, rodIndex) {
                          final monthIndex = group.x.toInt();
                          final monthName = monthIndex == 0 
                              ? _getMonthAbbreviation(previousMonth)
                              : _getMonthAbbreviation(currentMonth);
                          final isIncome = rodIndex == 0;
                          final value = rod.toY;
                          final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
                          return BarTooltipItem(
                            '$monthName\n${isIncome ? localizations.income : localizations.expense} : \$${value.toStringAsFixed(2)}',
                            TextStyle(
                              color: isIncome ? Colors.green : Colors.red,
                              fontWeight: FontWeight.w600,
                              fontSize: 12,
                            ),
                          );
                        },
                      ),
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
                        sideTitles: SideTitles(
                          showTitles: true,
                          getTitlesWidget: (value, meta) {
                            final index = value.toInt();
                            if (index == 0) {
                              return Text(
                                _getMonthAbbreviation(previousMonth),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            } else if (index == 1) {
                              return Text(
                                _getMonthAbbreviation(currentMonth),
                                style: const TextStyle(
                                  color: Colors.black,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                            return const Text('');
                          },
                        ),
                      ),
                      leftTitles: AxisTitles(
                        sideTitles: SideTitles(
                          showTitles: true,
                          reservedSize: 50,
                          interval: yAxisInterval,
                          getTitlesWidget: (value, meta) {
                            if (value >= 1000) {
                              return Text(
                                '\$${(value / 1000).toStringAsFixed(value >= 10000 ? 0 : 1)}k',
                                style: const TextStyle(
                                  color: Colors.black54,
                                  fontSize: 10,
                                  fontWeight: FontWeight.w500,
                                ),
                              );
                            }
                            return Text(
                              '\$${value.toStringAsFixed(0)}',
                              style: const TextStyle(
                                color: Colors.black54,
                                fontSize: 10,
                                fontWeight: FontWeight.w500,
                              ),
                            );
                          },
                        ),
                      ),
                    ),
                    gridData: FlGridData(
                      show: true,
                      drawVerticalLine: false,
                      horizontalInterval: yAxisInterval,
                      getDrawingHorizontalLine: (value) {
                        return FlLine(
                          color: const Color(0xFFAAA6A6),
                          strokeWidth: 1,
                        );
                      },
                    ),
                    borderData: FlBorderData(
                      show: true,
                      border: Border.all(
                        color: const Color(0xFFAAA6A6),
                        width: 1,
                      ),
                    ),
                    barGroups: [
                      BarChartGroupData(
                        x: 0,
                        barRods: [
                          BarChartRodData(
                            toY: previousIncome,
                            color: Colors.green,
                            width: 65,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                          BarChartRodData(
                            toY: previousExpense,
                            color: Colors.red,
                            width: 65,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ],
                        barsSpace: 8,
                      ),
                      BarChartGroupData(
                        x: 1,
                        barRods: [
                          BarChartRodData(
                            toY: currentIncome,
                            color: Colors.green,
                            width: 65,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                          BarChartRodData(
                            toY: currentExpense,
                            color: Colors.red,
                            width: 65,
                            borderRadius: const BorderRadius.vertical(
                              top: Radius.circular(4),
                            ),
                          ),
                        ],
                        barsSpace: 8,
                      ),
                    ],
                  ),
                ),
              ),
              const SizedBox(height: 16),
              Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  _buildLegendItem(localizations.income, Colors.green),
                  const SizedBox(width: 24),
                  _buildLegendItem(localizations.expense, Colors.red),
                ],
              ),
            ],
          ),
        ),
      ],
    );
  }

  Widget _buildLegendItem(String label, Color color) {
    return Row(
      children: [
        Container(
          width: 12,
          height: 12,
          decoration: BoxDecoration(
            color: color,
            shape: BoxShape.circle,
          ),
        ),
        const SizedBox(width: 8),
        Text(
          label,
          style: const TextStyle(
            fontSize: 12,
            color: Colors.black87,
            fontWeight: FontWeight.w500,
          ),
        ),
      ],
    );
  }
}
