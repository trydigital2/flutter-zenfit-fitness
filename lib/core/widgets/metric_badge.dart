import 'package:flutter/material.dart';
import '../../app/theme/app_colors.dart';

class MetricBadge extends StatelessWidget {
  final IconData icon;
  final String label;
  final Color? color;
  final Color? textColor;
  final double iconSize;
  final double fontSize;
  final EdgeInsetsGeometry padding;

  const MetricBadge({
    super.key,
    required this.icon,
    required this.label,
    this.color,
    this.textColor,
    this.iconSize = 14,
    this.fontSize = 12,
    this.padding = const EdgeInsets.symmetric(horizontal: 10, vertical: 5),
  });

  @override
  Widget build(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    final badgeBg =
        color ??
        (isDark
            ? AppColors.darkBorder.withAlpha(120)
            : AppColors.primaryContainer.withAlpha(120));
    final badgeFg =
        textColor ??
        (isDark ? AppColors.darkTextPrimary : AppColors.primaryLight);

    return Container(
      padding: padding,
      decoration: BoxDecoration(
        color: badgeBg,
        borderRadius: BorderRadius.circular(10),
      ),
      child: Row(
        mainAxisSize: MainAxisSize.min,
        children: [
          Icon(icon, size: iconSize, color: badgeFg),
          const SizedBox(width: 5),
          Text(
            label,
            style: TextStyle(
              fontSize: fontSize,
              fontWeight: FontWeight.w600,
              color: badgeFg,
            ),
          ),
        ],
      ),
    );
  }
}
