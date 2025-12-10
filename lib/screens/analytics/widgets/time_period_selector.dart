import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

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
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    return Row(
      children: [
        _buildPeriodButton(context, localizations.day, TimePeriod.day),
        const SizedBox(width: 8),
        _buildPeriodButton(context, localizations.week, TimePeriod.week),
        const SizedBox(width: 8),
        _buildPeriodButton(context, localizations.month, TimePeriod.month),
        const SizedBox(width: 8),
        _buildPeriodButton(context, localizations.year, TimePeriod.year),
      ],
    );
  }

  Widget _buildPeriodButton(
    BuildContext context,
    String label,
    TimePeriod period,
  ) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final isSelected = selectedPeriod == period;
    
    return Expanded(
      child: GestureDetector(
        onTap: () => onPeriodChanged(period),
        child: Container(
          padding: const EdgeInsets.symmetric(vertical: 12),
          decoration: BoxDecoration(
            color: isSelected
                ? (isDark ? Colors.white.withOpacity(0.15) : const Color(0xff1e1e1e))
                : (isDark ? const Color(0xFF181820) : Colors.white),
            borderRadius: BorderRadius.circular(30),
            border: Border.all(
              color: isSelected
                  ? Colors.transparent
                  : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
              width: 1,
            ),
          ),
          child: Center(
            child: Text(
              label,
              style: TextStyle(
                fontSize: 14,
                fontWeight: FontWeight.w600,
                color: isSelected
                    ? Colors.white
                    : (isDark ? Colors.white : Colors.black87),
              ),
            ),
          ),
        ),
      ),
    );
  }
}
