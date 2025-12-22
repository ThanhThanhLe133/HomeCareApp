import 'package:flutter/material.dart';

class CategoryRow extends StatelessWidget {
  const CategoryRow({
    super.key,
    required this.onCategoryTap,
    this.selectedLabel,
  });

  final ValueChanged<String> onCategoryTap;
  final String? selectedLabel;

  static const _categories = [
    _Category(Icons.flash_on, 'Automation', Color(0xFFEAF0FF)),
    _Category(Icons.videocam_outlined, 'Security', Color(0xFFFDF1E3)),
    _Category(Icons.energy_savings_leaf_outlined, 'Energy', Color(0xFFE9F7EF)),
    _Category(Icons.add_circle_outline, 'Add Device', Color(0xFFF5EAFE)),
  ];

  @override
  Widget build(BuildContext context) {
    return SizedBox(
      height: 88,
      child: ListView.separated(
        scrollDirection: Axis.horizontal,
        itemCount: _categories.length,
        separatorBuilder: (_, __) => const SizedBox(width: 12),
        itemBuilder: (context, index) {
          final category = _categories[index];
          final isSelected = selectedLabel == category.label;
          return _CategoryChip(
            category: category,
            selected: isSelected,
            onTap: () => onCategoryTap(category.label),
          );
        },
      ),
    );
  }
}

class _CategoryChip extends StatelessWidget {
  final _Category category;
  final VoidCallback onTap;
  final bool selected;
  const _CategoryChip({
    required this.category,
    required this.onTap,
    required this.selected,
  });

  @override
  Widget build(BuildContext context) {
    return InkWell(
      borderRadius: BorderRadius.circular(18),
      onTap: onTap,
      child: Container(
        width: 150,
        padding: const EdgeInsets.all(14),
        decoration: BoxDecoration(
          color: selected ? const Color(0xFF4A6CF7) : category.background,
          borderRadius: BorderRadius.circular(18),
        ),
        child: Row(
          children: [
            Icon(
              category.icon,
              color: selected ? Colors.white : const Color(0xFF4A6CF7),
            ),
            const SizedBox(width: 12),
            Expanded(
              child: Text(
                category.label,
                style: TextStyle(
                  fontWeight: FontWeight.w600,
                  color: selected ? Colors.white : Colors.black,
                ),
              ),
            ),
          ],
        ),
      ),
    );
  }
}

class _Category {
  final IconData icon;
  final String label;
  final Color background;
  const _Category(this.icon, this.label, this.background);
}
