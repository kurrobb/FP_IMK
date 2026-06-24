import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/accessibility_provider.dart';
import '../utils/accessibility_constants.dart';

class QuickAccessButton extends StatelessWidget {
  final IconData icon;
  final String label;
  final VoidCallback? onTap;

  const QuickAccessButton({
    super.key,
    required this.icon,
    required this.label,
    this.onTap,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibilityProvider, _) {
        final buttonScale = accessibilityProvider.getButtonSizeMultiplier();
        final spacingScale = accessibilityProvider.getSpacingMultiplier();

        // Scale dimensions
        final scaledHeight = AccessibilityConstants.getButtonHeight(buttonScale);
        final scaledIconSize = AccessibilityConstants.getIconSize(buttonScale);
        final scaledPadding = AccessibilityConstants.getPadding(spacingScale);
        final scaledRadius = AccessibilityConstants.getButtonRadius(buttonScale);

        return Semantics(
          label: label,
          button: true,
          child: Material(
            color: Colors.transparent,
            child: InkWell(
              onTap: onTap,
              borderRadius: BorderRadius.circular(scaledRadius),
              child: Container(
                height: scaledHeight,
                decoration: BoxDecoration(
                  color: AppColors.cardBackground,
                  borderRadius: BorderRadius.circular(scaledRadius),
                  border: Border.all(color: AppColors.border, width: 1),
                  boxShadow: [
                    BoxShadow(
                      color: Colors.black.withValues(alpha: 0.04),
                      blurRadius: 6,
                      offset: const Offset(0, 2),
                    ),
                  ],
                ),
                padding: EdgeInsets.symmetric(vertical: scaledPadding * 0.5),
                child: Column(
                  mainAxisAlignment: MainAxisAlignment.center,
                  children: [
                    Icon(icon, color: AppColors.primary, size: scaledIconSize),
                    SizedBox(height: 8 * spacingScale),
                    Text(
                      label,
                      style: TextStyle(
                        fontSize: 14 * spacingScale,
                        fontWeight: FontWeight.w600,
                        color: AppColors.primary,
                      ),
                      textAlign: TextAlign.center,
                    ),
                  ],
                ),
              ),
            ),
          ),
        );
      },
    );
  }
}
