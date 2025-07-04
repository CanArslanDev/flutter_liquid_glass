import 'package:flutter/material.dart';
import 'package:flutter_liquid_glass/src/models/liquid_glass_config.dart';
import 'package:flutter_liquid_glass/src/widgets/liquid_glass_container.dart';

/// Navigation bar with Liquid Glass effect
class LiquidGlassNavigationBar extends StatelessWidget {
  const LiquidGlassNavigationBar({
    super.key,
    required this.selectedIndex,
    required this.items,
    required this.onItemSelected,
    this.config = const LiquidGlassConfig(),
    this.height = 70,
  });

  /// Selected index
  final int selectedIndex;

  /// Navigation items
  final List<LiquidGlassNavigationItem> items;

  /// Callback when item is selected
  final ValueChanged<int> onItemSelected;

  /// Configuration for the liquid glass effect
  final LiquidGlassConfig config;

  /// Height of the navigation bar
  final double height;

  @override
  Widget build(BuildContext context) {
    return LiquidGlassContainer(
      config: config,
      height: height,
      padding: const EdgeInsets.symmetric(horizontal: 20, vertical: 8),
      child: Row(
        mainAxisAlignment: MainAxisAlignment.spaceAround,
        children: List.generate(
          items.length,
          (index) => Expanded(
            child: _NavigationItem(
              item: items[index],
              isSelected: selectedIndex == index,
              onTap: () => onItemSelected(index),
            ),
          ),
        ),
      ),
    );
  }
}

class _NavigationItem extends StatelessWidget {
  const _NavigationItem({
    required this.item,
    required this.isSelected,
    required this.onTap,
  });
  final LiquidGlassNavigationItem item;
  final bool isSelected;
  final VoidCallback onTap;

  @override
  Widget build(BuildContext context) {
    return GestureDetector(
      onTap: onTap,
      behavior: HitTestBehavior.opaque,
      child: AnimatedContainer(
        duration: const Duration(milliseconds: 200),
        padding: const EdgeInsets.symmetric(horizontal: 12, vertical: 4),
        decoration: BoxDecoration(
          color: isSelected
              ? Theme.of(context).primaryColor.withValues(alpha: 0.1)
              : Colors.transparent,
          borderRadius: BorderRadius.circular(20),
        ),
        child: Column(
          mainAxisSize: MainAxisSize.min,
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            Icon(
              item.icon,
              color: isSelected ? Theme.of(context).primaryColor : Colors.grey,
              size: 20,
            ),
            if (item.label != null) ...[
              const SizedBox(height: 1),
              Text(
                item.label!,
                style: TextStyle(
                  fontSize: 10,
                  color:
                      isSelected ? Theme.of(context).primaryColor : Colors.grey,
                  fontWeight: isSelected ? FontWeight.bold : FontWeight.normal,
                ),
                overflow: TextOverflow.ellipsis,
                maxLines: 1,
              ),
            ],
          ],
        ),
      ),
    );
  }
}

/// Navigation item model
class LiquidGlassNavigationItem {
  const LiquidGlassNavigationItem({
    required this.icon,
    this.label,
  });
  final IconData icon;
  final String? label;
}
