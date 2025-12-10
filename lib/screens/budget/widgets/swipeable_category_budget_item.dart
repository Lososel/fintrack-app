import 'package:flutter/material.dart';
import 'package:fintrack_app/models/budget_model.dart';
import 'package:fintrack_app/services/budget_service.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/screens/budget/widgets/category_budget_item.dart';
import 'package:fintrack_app/screens/budget/widgets/create_budget_modal.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class SwipeableCategoryBudgetItem extends StatefulWidget {
  final BudgetModel budget;
  final double spending;
  final Currency currency;
  final VoidCallback onBudgetChanged;

  const SwipeableCategoryBudgetItem({
    super.key,
    required this.budget,
    required this.spending,
    required this.currency,
    required this.onBudgetChanged,
  });

  @override
  State<SwipeableCategoryBudgetItem> createState() =>
      _SwipeableCategoryBudgetItemState();
}

class _SwipeableCategoryBudgetItemState
    extends State<SwipeableCategoryBudgetItem>
    with SingleTickerProviderStateMixin {
  final BudgetService _budgetService = BudgetService();
  double _dragOffset = 0.0;
  late AnimationController _controller;
  late Animation<double> _animation;

  static const double _actionButtonWidth = 60.0;
  static const double _maxSwipeDistance = 120.0;
  static const double _openThreshold = 60.0;
  static const double _cornerRadius = 16.0;

  @override
  void initState() {
    super.initState();
    _controller = AnimationController(
      vsync: this,
      duration: const Duration(milliseconds: 300),
    );
    _animation = Tween<double>(begin: 0.0, end: -_maxSwipeDistance).animate(
      CurvedAnimation(parent: _controller, curve: Curves.easeOutCubic),
    );
    _animation.addListener(() {
      setState(() {
        _dragOffset = _animation.value;
      });
    });
  }

  @override
  void dispose() {
    _controller.dispose();
    super.dispose();
  }

  void _onHorizontalDragUpdate(DragUpdateDetails details) {
    setState(() {
      // Only allow swiping left (negative direction)
      if (details.primaryDelta != null) {
        _dragOffset = (_dragOffset + details.primaryDelta!).clamp(-_maxSwipeDistance, 0.0);
      }
    });
  }

  void _onHorizontalDragEnd(DragEndDetails details) {
    // If dragged more than threshold, snap to open position
    if (_dragOffset < -_openThreshold) {
      _controller.forward();
    } else {
      // Otherwise, snap back to closed position
      _controller.reverse();
    }
  }

  void _closeActions() {
    _controller.reverse();
  }

  void _handleEdit() {
    _closeActions();
    showModalBottomSheet(
      context: context,
      isScrollControlled: true,
      backgroundColor: Colors.transparent,
      builder: (context) => CreateBudgetModal(
        existingBudget: widget.budget,
        onBudgetCreated: () {
          widget.onBudgetChanged();
        },
      ),
    );
  }

  void _handleDelete() {
    _closeActions();
    final localizations =
        AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));

    showDialog(
      context: context,
      builder: (BuildContext context) {
        return AlertDialog(
          title: const Text("Delete Budget"),
          content: Text("Are you sure you want to delete the budget for ${widget.budget.category}?"),
          actions: [
            TextButton(
              onPressed: () => Navigator.of(context).pop(),
              child: Text(localizations.cancel),
            ),
            TextButton(
              onPressed: () {
                _budgetService.deleteCategoryBudget(widget.budget);
                Navigator.of(context).pop();
                ScaffoldMessenger.of(context).showSnackBar(
                  const SnackBar(
                    content: Text("Budget deleted"),
                    duration: Duration(seconds: 2),
                  ),
                );
                widget.onBudgetChanged();
              },
              style: TextButton.styleFrom(
                foregroundColor: Colors.red,
              ),
              child: Text(localizations.delete),
            ),
          ],
        );
      },
    );
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final cardBackgroundColor = isDark ? theme.cardColor : Colors.white;

    return GestureDetector(
      onHorizontalDragUpdate: _onHorizontalDragUpdate,
      onHorizontalDragEnd: _onHorizontalDragEnd,
      child: Stack(
        clipBehavior: Clip.hardEdge,
        children: [
          // Action buttons (background layer) - rendered first
          Positioned.fill(
            child: Row(
              mainAxisAlignment: MainAxisAlignment.end,
              crossAxisAlignment: CrossAxisAlignment.stretch,
              children: [
                // Edit button - green, no rounded corners
                Container(
                  width: _actionButtonWidth,
                  color: const Color(0xFF10B981), // Green #10B981
                  child: Material(
                    color: Colors.transparent,
                    child: InkWell(
                      onTap: _handleEdit,
                      child: Column(
                        mainAxisAlignment: MainAxisAlignment.center,
                        children: [
                          const Icon(Icons.edit, color: Colors.white, size: 24),
                          const SizedBox(height: 4),
                          Builder(
                            builder: (context) {
                              final localizations =
                                  AppLocalizations.of(context) ??
                                  AppLocalizations(const Locale('en'));
                              return Text(
                                localizations.edit,
                                style: const TextStyle(
                                  color: Colors.white,
                                  fontSize: 12,
                                  fontWeight: FontWeight.w600,
                                ),
                              );
                            },
                          ),
                        ],
                      ),
                    ),
                  ),
                ),
                // Delete button - red, only right-side rounded corners
                ClipRRect(
                  borderRadius: const BorderRadius.only(
                    topRight: Radius.circular(_cornerRadius),
                    bottomRight: Radius.circular(_cornerRadius),
                  ),
                  child: Container(
                    width: _actionButtonWidth,
                    color: const Color(0xFFEF4444), // Red #EF4444
                    child: Material(
                      color: Colors.transparent,
                      child: InkWell(
                        onTap: _handleDelete,
                        child: Column(
                          mainAxisAlignment: MainAxisAlignment.center,
                          children: [
                            const Icon(Icons.delete, color: Colors.white, size: 24),
                            const SizedBox(height: 4),
                            Builder(
                              builder: (context) {
                                final localizations =
                                    AppLocalizations.of(context) ??
                                    AppLocalizations(const Locale('en'));
                                return Text(
                                  localizations.delete,
                                  style: const TextStyle(
                                    color: Colors.white,
                                    fontSize: 12,
                                    fontWeight: FontWeight.w600,
                                  ),
                                );
                              },
                            ),
                          ],
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          ),
          // White budget card (foreground layer) - always on top with all rounded corners
          // This is rendered last so it has the highest z-index
          Transform.translate(
            offset: Offset(_dragOffset, 0),
            child: ClipRRect(
              borderRadius: BorderRadius.circular(_cornerRadius),
              child: Container(
                color: cardBackgroundColor,
                child: CategoryBudgetItem(
                  budget: widget.budget,
                  spending: widget.spending,
                  currency: widget.currency,
                  onTap: () {
                    // Close any open swipe actions when tapping
                    if (_dragOffset < 0) {
                      _closeActions();
                    } else {
                      // Open edit modal if not swiped
                      _handleEdit();
                    }
                  },
                ),
              ),
            ),
          ),
        ],
      ),
    );
  }
}
