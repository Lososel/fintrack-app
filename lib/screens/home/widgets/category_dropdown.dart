import 'package:flutter/material.dart';
import 'package:fintrack_app/components/fields/input_field.dart';

class CategoryDropdown extends StatefulWidget {
  final String current;
  final VoidCallback onTap;

  const CategoryDropdown({
    super.key,
    required this.current,
    required this.onTap,
  });

  @override
  State<CategoryDropdown> createState() => _CategoryDropdownState();
}

class _CategoryDropdownState extends State<CategoryDropdown> {
  TextEditingController? _controller;

  @override
  void initState() {
    super.initState();
    _updateController();
  }

  @override
  void didUpdateWidget(CategoryDropdown oldWidget) {
    super.didUpdateWidget(oldWidget);
    if (oldWidget.current != widget.current) {
      _updateController();
    }
  }

  void _updateController() {
    final bool isHint = widget.current == "Select category";
    _controller?.dispose();
    _controller = isHint ? null : TextEditingController(text: widget.current);
  }

  @override
  void dispose() {
    _controller?.dispose();
    super.dispose();
  }

  @override
  Widget build(BuildContext context) {
    final bool isHint = widget.current == "Select category";
    
    return InputField(
      hint: isHint ? widget.current : "",
      controller: _controller,
      readOnly: true,
      onTap: widget.onTap,
      suffixIcon: const Icon(Icons.keyboard_arrow_down),
    );
  }
}


