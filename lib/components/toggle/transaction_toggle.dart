import 'package:flutter/material.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class TransactionToggle extends StatelessWidget {
  final bool isExpense;
  final ValueChanged<bool> onChanged;

  const TransactionToggle({
    super.key,
    required this.isExpense,
    required this.onChanged,
  });

  @override
  Widget build(BuildContext context) {
    const duration = Duration(milliseconds: 260);

    return Container(
      height: 50,
      decoration: BoxDecoration(
        borderRadius: BorderRadius.circular(40),
        border: Border.all(color: Color(0xff9CA3AF)),
        color: const Color(0xFFF4F4F6),
      ),
      child: LayoutBuilder(
        builder: (context, constraints) {
          final double pillWidth = constraints.maxWidth / 2;

          return Stack(
            children: [
              AnimatedPositioned(
                duration: duration,
                curve: Curves.easeOutCubic,
                left: isExpense ? 0 : pillWidth,
                top: 0,
                bottom: 0,
                child: Container(
                  width: pillWidth,
                  decoration: BoxDecoration(
                    color: isExpense ? Color(0xFFB52424) : Color(0xFf31A05F),
                    borderRadius: BorderRadius.circular(40),
                  ),
                ),
              ),

              Row(
                children: [
                  Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(true),
                      child: Center(
                        child: Builder(
                          builder: (context) {
                            final localizations =
                                AppLocalizations.of(context) ??
                                AppLocalizations(const Locale('en'));
                            return AnimatedDefaultTextStyle(
                              duration: duration,
                              style: TextStyle(
                                color: isExpense
                                    ? Colors.white
                                    : Color(0xff9CA3AF),
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                              child: Text(localizations.expense),
                            );
                          },
                        ),
                      ),
                    ),
                  ),

                  Expanded(
                    child: GestureDetector(
                      onTap: () => onChanged(false),
                      child: Center(
                        child: Builder(
                          builder: (context) {
                            final localizations =
                                AppLocalizations.of(context) ??
                                AppLocalizations(const Locale('en'));
                            return AnimatedDefaultTextStyle(
                              duration: duration,
                              style: TextStyle(
                                color: !isExpense
                                    ? Colors.white
                                    : Color(0xff9CA3AF),
                                fontSize: 15,
                                fontWeight: FontWeight.w900,
                              ),
                              child: Text(localizations.income),
                            );
                          },
                        ),
                      ),
                    ),
                  ),
                ],
              ),
            ],
          );
        },
      ),
    );
  }
}
