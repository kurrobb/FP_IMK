import 'package:flutter/material.dart';
import '../constants/colors.dart';
import '../utils/accessibility_constants.dart';
import '../utils/context_extensions.dart';

/// Accessible Elevated Button that scales with accessibility settings
class AccessibleElevatedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;
  final bool iconTrailing;

  const AccessibleElevatedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.iconTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonScale = context.buttonScale;
    final spacingScale = context.spacingScale;
    final scaledHeight = AccessibilityConstants.getButtonHeight(buttonScale);
    final scaledRadius = AccessibilityConstants.getButtonRadius(buttonScale);
    final scaledIconSize = AccessibilityConstants.getIconSize(buttonScale);

    return SizedBox(
      width: double.infinity,
      height: scaledHeight,
      child: ElevatedButton.icon(
        onPressed: onPressed,
        icon: icon != null && !iconTrailing
            ? Icon(icon, size: scaledIconSize)
            : const SizedBox.shrink(),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && !iconTrailing)
              SizedBox(width: 8 * spacingScale),
            child,
            if (icon != null && iconTrailing) ...[
              SizedBox(width: 8 * spacingScale),
              Icon(icon, size: scaledIconSize),
            ],
          ],
        ),
        style: ElevatedButton.styleFrom(
          backgroundColor: AppColors.primary,
          foregroundColor: Colors.white,
          elevation: 0,
          minimumSize: Size(double.infinity, scaledHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scaledRadius),
          ),
        ),
      ),
    );
  }
}

/// Accessible Outlined Button that scales with accessibility settings
class AccessibleOutlinedButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;
  final bool iconTrailing;

  const AccessibleOutlinedButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
    this.iconTrailing = false,
  });

  @override
  Widget build(BuildContext context) {
    final buttonScale = context.buttonScale;
    final spacingScale = context.spacingScale;
    final scaledHeight = AccessibilityConstants.getButtonHeight(buttonScale);
    final scaledRadius = AccessibilityConstants.getButtonRadius(buttonScale);
    final scaledIconSize = AccessibilityConstants.getIconSize(buttonScale);

    return SizedBox(
      width: double.infinity,
      height: scaledHeight,
      child: OutlinedButton.icon(
        onPressed: onPressed,
        icon: icon != null && !iconTrailing
            ? Icon(icon, size: scaledIconSize, color: AppColors.primary)
            : const SizedBox.shrink(),
        label: Row(
          mainAxisAlignment: MainAxisAlignment.center,
          children: [
            if (icon != null && !iconTrailing)
              SizedBox(width: 8 * spacingScale),
            child,
            if (icon != null && iconTrailing) ...[
              SizedBox(width: 8 * spacingScale),
              Icon(icon, size: scaledIconSize, color: AppColors.primary),
            ],
          ],
        ),
        style: OutlinedButton.styleFrom(
          foregroundColor: AppColors.primary,
          side: const BorderSide(color: AppColors.border, width: 1.5),
          minimumSize: Size(double.infinity, scaledHeight),
          shape: RoundedRectangleBorder(
            borderRadius: BorderRadius.circular(scaledRadius),
          ),
        ),
      ),
    );
  }
}

/// Accessible Text Button that scales with accessibility settings
class AccessibleTextButton extends StatelessWidget {
  final VoidCallback? onPressed;
  final Widget child;
  final IconData? icon;

  const AccessibleTextButton({
    super.key,
    required this.onPressed,
    required this.child,
    this.icon,
  });

  @override
  Widget build(BuildContext context) {
    final buttonScale = context.buttonScale;
    final scaledHeight = AccessibilityConstants.getButtonHeight(buttonScale);
    final scaledIconSize = AccessibilityConstants.getIconSize(buttonScale);

    return SizedBox(
      height: scaledHeight,
      child: TextButton.icon(
        onPressed: onPressed,
        icon: icon != null
            ? Icon(icon, size: scaledIconSize, color: AppColors.primary)
            : const SizedBox.shrink(),
        label: child,
        style: TextButton.styleFrom(
          foregroundColor: AppColors.primary,
          minimumSize: Size(0, scaledHeight),
        ),
      ),
    );
  }
}

/// Wrapper to scale any pressable widget's touch target
class AccessiblePressable extends StatelessWidget {
  final Widget child;
  final VoidCallback? onTap;
  final VoidCallback? onLongPress;
  final Color? backgroundColor;
  final double? borderRadius;
  final EdgeInsets? padding;

  const AccessiblePressable({
    super.key,
    required this.child,
    this.onTap,
    this.onLongPress,
    this.backgroundColor,
    this.borderRadius,
    this.padding,
  });

  @override
  Widget build(BuildContext context) {
    final buttonScale = context.buttonScale;
    final scaledRadius = borderRadius != null
        ? borderRadius! * buttonScale
        : AccessibilityConstants.baseButtonRadius * buttonScale;

    return Semantics(
      button: true,
      child: Material(
        color: backgroundColor ?? Colors.transparent,
        borderRadius: BorderRadius.circular(scaledRadius),
        child: InkWell(
          onTap: onTap,
          onLongPress: onLongPress,
          borderRadius: BorderRadius.circular(scaledRadius),
          child: Container(
            padding: padding,
            child: child,
          ),
        ),
      ),
    );
  }
}
