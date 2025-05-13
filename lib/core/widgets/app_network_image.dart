import 'package:flutter/material.dart';
import 'package:flutter_svg/flutter_svg.dart';
import '../../app/theme/app_colors.dart';

class AppNetworkImage extends StatelessWidget {
  final String imageUrl;
  final double? width;
  final double? height;
  final BoxFit fit;
  final BorderRadius? borderRadius;
  final IconData fallbackIcon;
  final Color? placeholderColor;

  const AppNetworkImage({
    super.key,
    required this.imageUrl,
    this.width,
    this.height,
    this.fit = BoxFit.cover,
    this.borderRadius,
    this.fallbackIcon = Icons.fitness_center_rounded,
    this.placeholderColor,
  });

  @override
  Widget build(BuildContext context) {
    Widget child;

    final trimmed = imageUrl.trim();

    if (trimmed.isEmpty) {
      child = _buildPlaceholder(context);
    } else if (trimmed.endsWith('.svg')) {
      child = SvgPicture.asset(
        trimmed,
        width: width,
        height: height,
        fit: fit,
        placeholderBuilder: (ctx) => _buildPlaceholder(context),
      );
    } else if (trimmed.startsWith('assets/')) {
      child = Image.asset(
        trimmed,
        width: width,
        height: height,
        fit: fit,
        errorBuilder: (ctx, err, stack) => _buildPlaceholder(context),
      );
    } else {
      child = Image.network(
        trimmed,
        width: width,
        height: height,
        fit: fit,
        loadingBuilder: (ctx, widget, progress) {
          if (progress == null) return widget;
          return _buildLoading(context);
        },
        errorBuilder: (ctx, error, stackTrace) => _buildPlaceholder(context),
      );
    }

    if (borderRadius != null) {
      return ClipRRect(borderRadius: borderRadius!, child: child);
    }

    return child;
  }

  Widget _buildLoading(BuildContext context) {
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        color:
            placeholderColor ??
            (Theme.of(context).brightness == Brightness.dark
                ? AppColors.darkCard
                : AppColors.primaryContainer.withAlpha(80)),
      ),
      child: const Center(
        child: SizedBox(
          width: 20,
          height: 20,
          child: CircularProgressIndicator(
            strokeWidth: 2,
            valueColor: AlwaysStoppedAnimation<Color>(AppColors.accent),
          ),
        ),
      ),
    );
  }

  Widget _buildPlaceholder(BuildContext context) {
    final isDark = Theme.of(context).brightness == Brightness.dark;
    return Container(
      width: width,
      height: height,
      decoration: BoxDecoration(
        gradient: LinearGradient(
          colors: isDark
              ? [const Color(0xFF1B2820), const Color(0xFF111A15)]
              : [const Color(0xFFE2EBE5), const Color(0xFFD4E0D8)],
          begin: Alignment.topLeft,
          end: Alignment.bottomRight,
        ),
      ),
      child: Center(
        child: Icon(
          fallbackIcon,
          size: (height != null && height! < 50) ? 20 : 32,
          color: isDark ? AppColors.darkTextMuted : AppColors.lightTextMuted,
        ),
      ),
    );
  }
}
