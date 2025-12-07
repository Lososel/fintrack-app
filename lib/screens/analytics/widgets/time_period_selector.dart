import 'package:flutter/material.dart';

enum TimePeriod { day, week, month, year }

class TimePeriodSelector extends StatelessWidget {
  final TimePeriod selectedPeriod;
  final Function(TimePeriod) onPeriodChanged;

  const TimePeriodSelector({
    super.key,
    required this.selectedPeriod,
    required this.onPeriodChanged,
  });

  @override
  Widget build(BuildContext context) {
    return Row(
      children: [
        _buildPeriodButton('Day', TimePeriod.day),
        const SizedBox(width: 8),
        _buildPeriodButton('Week', TimePeriod.week),
        const SizedBox(width: 8),
        _buildPeriodButton('Month', TimePeriod.month),
        const SizedBox(width: 8),
        _buildPeriodButton('Year', TimePeriod.year),
      ],
    );
  }

  Widget _buildPeriodButton(String label, TimePeriod period) {
    final isSelected = selectedPeriod == period;
    return Expanded(
      child: GestureDetector(
        onTap: () => onPeriodChanged(period),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected ? const Color(0xff1e1e1e) : Colors.white,
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected ? Colors.transparent : Colors.grey.shade300,
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected ? Colors.white : Colors.black87,
              ),
            ),
          ),
        ),
      ),
    );
  }
}

