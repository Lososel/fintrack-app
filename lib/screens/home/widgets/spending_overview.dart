import 'package:flutter/material.dart';
import 'package:fl_chart/fl_chart.dart';
import 'package:fintrack_app/services/transaction_service.dart';
import 'package:fintrack_app/utils/spending_calculator.dart';
import 'package:fintrack_app/utils/category_colors.dart';

class SpendingOverview extends StatefulWidget {
  const SpendingOverview({super.key});

  @override
  State<SpendingOverview> createState() => _SpendingOverviewState();
}

class _SpendingOverviewState extends State<SpendingOverview> {
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

  @override
  Widget build(BuildContext context) {
    final spendingByCategory = SpendingCalculator.calculateSpendingByCategory(
      _transactionService.transactions,
    );

    if (spendingByCategory.isEmpty) {
      return Column(
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Row(
            mainAxisAlignment: MainAxisAlignment.spaceBetween,
            children: const [
              Text(
                "Spending Overview",
                style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
              ),
              Text(
                "View Details →",
                style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
              ),
            ],
          ),
          const SizedBox(height: 20),
          Center(
            child: Container(
              width: 180,
              height: 180,
              decoration: const BoxDecoration(
                shape: BoxShape.circle,
                color: Color(0xffF4F4F7),
              ),
              child: const Center(
                child: Text(
                  "No expenses yet",
                  style: TextStyle(color: Colors.black54),
                ),
              ),
            ),
          ),
        ],
      );
    }

    return Column(
      crossAxisAlignment: CrossAxisAlignment.start,
      children: [
        Row(
          mainAxisAlignment: MainAxisAlignment.spaceBetween,
          children: const [
            Text(
              "Spending Overview",
              style: TextStyle(fontSize: 22, fontWeight: FontWeight.w900),
            ),
            Text(
              "View Details →",
              style: TextStyle(fontSize: 13, fontWeight: FontWeight.w400),
            ),
          ],
        ),
        const SizedBox(height: 20),
        Center(
          child: Column(
            children: [
              // Pie Chart
              SizedBox(
                width: 180,
                height: 180,
                child: PieChart(
                  PieChartData(
                    sectionsSpace: 2,
                    centerSpaceRadius: 50,
                    sections: _buildPieChartSections(spendingByCategory),
                  ),
                ),
              ),
              const SizedBox(height: 20),
              // Legend
              Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: _buildLegend(spendingByCategory),
              ),
            ],
          ),
        ),
      ],
    );
  }

  List<PieChartSectionData> _buildPieChartSections(
    List<CategorySpending> spendingByCategory,
  ) {
    return spendingByCategory.map((categorySpending) {
      final color = CategoryColors.getColor(categorySpending.category);

      return PieChartSectionData(
        value: categorySpending.amount,
        title: '',
        color: color,
        radius: 60,
      );
    }).toList();
  }

  List<Widget> _buildLegend(List<CategorySpending> spendingByCategory) {
    return spendingByCategory.map((categorySpending) {
      final color = CategoryColors.getColor(categorySpending.category);
      return Padding(
        padding: const EdgeInsets.only(bottom: 8),
        child: Row(
          children: [
            Container(
              width: 12,
              height: 12,
              decoration: BoxDecoration(
                shape: BoxShape.circle,
                color: color,
              ),
            ),
            const SizedBox(width: 8),
            Expanded(
              child: Text(
                categorySpending.category,
                style: const TextStyle(
                  fontSize: 14,
                  fontWeight: FontWeight.w500,
                ),
              ),
            ),
          ],
        ),
      );
    }).toList();
  }
}
