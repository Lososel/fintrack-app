import 'package:flutter/material.dart';
import 'package:fintrack_app/components/modal/app_modal.dart';
import 'package:fintrack_app/components/modal/animated_selectable_tile.dart';
import 'package:fintrack_app/utils/app_localizations.dart';

class CategorySelectModal extends StatelessWidget {
  final List<String> categories;
  final Map<String, IconData> icons;
  final Function(String) onSelected;

  const CategorySelectModal({
    super.key,
    required this.categories,
    required this.icons,
    required this.onSelected,
  });

  @override
  Widget build(BuildContext context) {
    final localizations = AppLocalizations.of(context) ?? AppLocalizations(const Locale('en'));
    return AppModal(
      title: localizations.selectCategory,
      child: ConstrainedBox(
        constraints: BoxConstraints(
          maxHeight: MediaQuery.of(context).size.height * 0.7,
        ),
        child: ListView(
          shrinkWrap: true,
          children: categories.map((category) {
            return AnimatedSelectableTile(
              title: category,
              icon: icons[category] ?? Icons.more_horiz,
              onTap: () {
                onSelected(category);
                Navigator.pop(context);
              },
            );
          }).toList(),
        ),
      ),
    );
  }
}
