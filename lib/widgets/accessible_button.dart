import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/accessibility_provider.dart';
import '../utils/accessibility_constants.dart';
import '../constants/colors.dart';

/// Tombol ElevatedButton yang otomatis menyesuaikan tinggi
/// berdasarkan pengaturan Button Sizing di Accessibility.
class AccessibleButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color backgroundColor;
  final Color foregroundColor;
  final double borderRadius;
  final double baseFontSize;
  final bool isLoading;

  const AccessibleButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.backgroundColor = AppColors.primary,
    this.foregroundColor = Colors.white,
    this.borderRadius = 14,
    this.baseFontSize = 16,
    this.isLoading = false,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, ap, _) {
        final btnH =
            AccessibilityConstants.getButtonHeight(ap.getButtonSizeMultiplier());
        final shape = RoundedRectangleBorder(
          borderRadius: BorderRadius.circular(borderRadius),
        );

        Widget labelWidget = isLoading
            ? SizedBox(
                width: 22,
                height: 22,
                child: CircularProgressIndicator(
                  strokeWidth: 2.5,
                  color: foregroundColor,
                ),
              )
            : Row(
                mainAxisSize: MainAxisSize.min,
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: baseFontSize + 4, color: foregroundColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: baseFontSize,
                      fontWeight: FontWeight.w600,
                      color: foregroundColor,
                    ),
                  ),
                ],
              );

        return SizedBox(
          width: double.infinity,
          height: btnH,
          child: Semantics(
            button: true,
            label: label,
            child: ElevatedButton(
              onPressed: isLoading ? null : onPressed,
              style: ElevatedButton.styleFrom(
                backgroundColor: onPressed == null && !isLoading
                    ? AppColors.surfaceDark
                    : backgroundColor,
                foregroundColor: foregroundColor,
                elevation: 0,
                shape: shape,
              ),
              child: labelWidget,
            ),
          ),
        );
      },
    );
  }
}

/// Tombol OutlinedButton yang otomatis menyesuaikan tinggi.
class AccessibleOutlinedButton extends StatelessWidget {
  final String label;
  final VoidCallback? onPressed;
  final IconData? icon;
  final Color borderColor;
  final Color foregroundColor;
  final double borderRadius;

  const AccessibleOutlinedButton({
    super.key,
    required this.label,
    this.onPressed,
    this.icon,
    this.borderColor = AppColors.border,
    this.foregroundColor = AppColors.primary,
    this.borderRadius = 14,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, ap, _) {
        final btnH =
            AccessibilityConstants.getButtonHeight(ap.getButtonSizeMultiplier());
        return SizedBox(
          width: double.infinity,
          height: btnH,
          child: Semantics(
            button: true,
            label: label,
            child: OutlinedButton(
              onPressed: onPressed,
              style: OutlinedButton.styleFrom(
                foregroundColor: foregroundColor,
                side: BorderSide(color: borderColor, width: 1.5),
                shape: RoundedRectangleBorder(
                  borderRadius: BorderRadius.circular(borderRadius),
                ),
              ),
              child: Row(
                mainAxisAlignment: MainAxisAlignment.center,
                children: [
                  if (icon != null) ...[
                    Icon(icon, size: 20, color: foregroundColor),
                    const SizedBox(width: 8),
                  ],
                  Text(
                    label,
                    style: TextStyle(
                      fontSize: 16,
                      fontWeight: FontWeight.w600,
                      color: foregroundColor,
                    ),
                  ),
                ],
              ),
            ),
          ),
        );
      },
    );
  }
}
