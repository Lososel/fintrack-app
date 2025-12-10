import 'package:flutter/material.dart';
import 'package:fintrack_app/components/fields/input_field.dart';
import 'package:fintrack_app/components/button/primary_button.dart';
import 'package:fintrack_app/models/budget_model.dart';
import 'package:fintrack_app/services/budget_service.dart';
import 'package:fintrack_app/utils/currency.dart';
import 'package:fintrack_app/screens/home/widgets/utils/transaction_constants.dart';
import 'package:fintrack_app/screens/home/widgets/utils/transaction_icons.dart';
import 'package:fintrack_app/utils/modal_helper.dart';
import 'package:fintrack_app/screens/home/widgets/modals/category_modal.dart';

class CreateBudgetModal extends StatefulWidget {
  final BudgetModel? existingBudget;
  final TotalBudgetModel? existingTotalBudget;
  final bool isTotalBudget;
  final VoidCallback onBudgetCreated;

  const CreateBudgetModal({
    super.key,
    this.existingBudget,
    this.existingTotalBudget,
    this.isTotalBudget = false,
    required this.onBudgetCreated,
  });

  @override
  State<CreateBudgetModal> createState() => _CreateBudgetModalState();
}

class _CreateBudgetModalState extends State<CreateBudgetModal> {
  final TextEditingController _amountController = TextEditingController();
  final BudgetService _budgetService = BudgetService();
  String? _selectedCategory;
  String _selectedPeriod = "Monthly";
  bool _isTotalBudget = false;
  Currency _selectedCurrency = Currency.dollar;

  @override
  void initState() {
    super.initState();
    _isTotalBudget = widget.isTotalBudget;
    if (widget.existingBudget != null) {
      _selectedCategory = widget.existingBudget!.category;
      _selectedPeriod = widget.existingBudget!.period;
      _amountController.text = widget.existingBudget!.limit.toStringAsFixed(2);
      _selectedCurrency = widget.existingBudget!.currency;
      _isTotalBudget = false;
    } else if (widget.existingTotalBudget != null) {
      _selectedPeriod = widget.existingTotalBudget!.period;
      _amountController.text = widget.existingTotalBudget!.limit.toStringAsFixed(2);
      _selectedCurrency = widget.existingTotalBudget!.currency;
      _isTotalBudget = true;
    }
  }

  @override
  void dispose() {
    _amountController.dispose();
    super.dispose();
  }

  void _openCategorySheet() {
    ModalHelper.showSmoothModal(
      context: context,
      child: CategorySelectModal(
        categories: TransactionConstants.categories,
        icons: TransactionConstants.categoryIcons,
        onSelected: (value) {
          setState(() => _selectedCategory = value);
        },
      ),
    );
  }

  void _saveBudget() {
    final amountText = _amountController.text.trim();
    if (amountText.isEmpty) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a budget amount")),
      );
      return;
    }

    final amount = double.tryParse(amountText);
    if (amount == null || amount <= 0) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please enter a valid amount")),
      );
      return;
    }

    if (!_isTotalBudget && _selectedCategory == null) {
      ScaffoldMessenger.of(context).showSnackBar(
        const SnackBar(content: Text("Please select a category")),
      );
      return;
    }

    if (_isTotalBudget) {
      _budgetService.setTotalBudget(
        TotalBudgetModel(
          limit: amount,
          currency: _selectedCurrency,
          period: _selectedPeriod,
        ),
      );
    } else {
      if (widget.existingBudget != null) {
        _budgetService.updateCategoryBudget(
          widget.existingBudget!,
          BudgetModel(
            category: _selectedCategory!,
            limit: amount,
            currency: _selectedCurrency,
            period: _selectedPeriod,
          ),
        );
      } else {
        _budgetService.addCategoryBudget(
          BudgetModel(
            category: _selectedCategory!,
            limit: amount,
            currency: _selectedCurrency,
            period: _selectedPeriod,
          ),
        );
      }
    }

    widget.onBudgetCreated();
    Navigator.pop(context);
  }

  @override
  Widget build(BuildContext context) {
    final theme = Theme.of(context);
    final isDark = theme.brightness == Brightness.dark;
    final textColor = isDark ? Colors.white : Colors.black;
    final secondaryTextColor = isDark ? Colors.grey.shade400 : Colors.black54;
    final modalColor = isDark ? theme.cardColor : Colors.white;

    return Container(
      padding: const EdgeInsets.all(24),
      decoration: BoxDecoration(
        color: modalColor,
        borderRadius: const BorderRadius.vertical(top: Radius.circular(25)),
      ),
      child: Column(
        mainAxisSize: MainAxisSize.min,
        crossAxisAlignment: CrossAxisAlignment.start,
        children: [
          Text(
            widget.existingBudget != null || widget.existingTotalBudget != null
                ? "Edit Budget"
                : "Create Budget",
            style: TextStyle(
              fontSize: 22,
              fontWeight: FontWeight.w700,
              color: textColor,
            ),
          ),
          const SizedBox(height: 24),
          if (widget.existingBudget == null && widget.existingTotalBudget == null)
            Row(
              children: [
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isTotalBudget = true),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: _isTotalBudget
                            ? (isDark ? Colors.white.withOpacity(0.15) : const Color(0xff1e1e1e))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: _isTotalBudget
                              ? Colors.transparent
                              : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                        ),
                      ),
                      child: Text(
                        "Total Budget",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: _isTotalBudget ? Colors.white : textColor,
                          fontWeight: _isTotalBudget ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
                const SizedBox(width: 12),
                Expanded(
                  child: GestureDetector(
                    onTap: () => setState(() => _isTotalBudget = false),
                    child: Container(
                      padding: const EdgeInsets.all(16),
                      decoration: BoxDecoration(
                        color: !_isTotalBudget
                            ? (isDark ? Colors.white.withOpacity(0.15) : const Color(0xff1e1e1e))
                            : Colors.transparent,
                        borderRadius: BorderRadius.circular(12),
                        border: Border.all(
                          color: !_isTotalBudget
                              ? Colors.transparent
                              : (isDark ? Colors.grey.shade700 : Colors.grey.shade300),
                        ),
                      ),
                      child: Text(
                        "Category Budget",
                        textAlign: TextAlign.center,
                        style: TextStyle(
                          color: !_isTotalBudget ? Colors.white : textColor,
                          fontWeight: !_isTotalBudget ? FontWeight.w600 : FontWeight.w400,
                        ),
                      ),
                    ),
                  ),
                ),
              ],
            ),
          if (widget.existingBudget == null) const SizedBox(height: 20),
          if (!_isTotalBudget && widget.existingBudget == null)
            InputField(
              hint: "Select Category",
              controller: TextEditingController(
                text: _selectedCategory ?? "",
              ),
              readOnly: true,
              onTap: _openCategorySheet,
              suffixIcon: const Icon(Icons.arrow_forward_ios, size: 16),
            ),
          if (!_isTotalBudget && widget.existingBudget == null)
            const SizedBox(height: 16),
          if (_selectedCategory != null || widget.existingBudget != null)
            Row(
              children: [
                Icon(
                  TransactionIcons.getCategoryIcon(
                    _selectedCategory ?? widget.existingBudget!.category,
                  ),
                  color: textColor,
                ),
                const SizedBox(width: 8),
                Text(
                  _selectedCategory ?? widget.existingBudget!.category,
                  style: TextStyle(
                    fontSize: 16,
                    fontWeight: FontWeight.w600,
                    color: textColor,
                  ),
                ),
              ],
            ),
          if (_selectedCategory != null || widget.existingBudget != null)
            const SizedBox(height: 20),
          InputField(
            hint: "Budget Amount",
            controller: _amountController,
            keyboardType: const TextInputType.numberWithOptions(decimal: true),
          ),
          const SizedBox(height: 16),
          DropdownButtonFormField<String>(
            value: _selectedPeriod,
            decoration: InputDecoration(
              labelText: "Period",
              labelStyle: TextStyle(color: secondaryTextColor),
              contentPadding: const EdgeInsets.symmetric(
                horizontal: 20,
                vertical: 18,
              ),
              filled: true,
              fillColor: isDark ? Colors.grey.shade800 : Colors.grey.shade200,
              border: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey.shade700 : Colors.black26,
                ),
              ),
              enabledBorder: OutlineInputBorder(
                borderRadius: BorderRadius.circular(20),
                borderSide: BorderSide(
                  color: isDark ? Colors.grey.shade700 : Colors.black26,
                ),
              ),
            ),
            dropdownColor: isDark ? theme.cardColor : Colors.white,
            style: TextStyle(color: textColor),
            items: ["Monthly", "Weekly", "Yearly"]
                .map((period) => DropdownMenuItem(
                      value: period,
                      child: Text(period),
                    ))
                .toList(),
            onChanged: (value) {
              if (value != null) {
                setState(() => _selectedPeriod = value);
              }
            },
          ),
          const SizedBox(height: 24),
          PrimaryButton(
            label: widget.existingBudget != null ? "Update Budget" : "Create Budget",
            onPressed: _saveBudget,
          ),
          SizedBox(height: MediaQuery.of(context).viewInsets.bottom),
        ],
      ),
    );
  }
}

