import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../services/accessibility_provider.dart';
import 'accessibility_constants.dart';

/// Extension on BuildContext for easy access to accessibility settings
extension ResponsiveContext on BuildContext {
  /// Get the AccessibilityProvider from the context
  AccessibilityProvider get access => watch<AccessibilityProvider>();

  /// Get the button size multiplier (1.0 = Standard, 1.15 = Large, 1.3 = Maximum)
  double get buttonScale => access.getButtonSizeMultiplier();

  /// Get the spacing multiplier (0.8 = Compact, 1.2 = Relaxed)
  double get spacingScale => access.getSpacingMultiplier();

  /// Scale a button height using the button size multiplier
  double scaleButtonHeight([double baseHeight = AccessibilityConstants.baseButtonHeight]) {
    return AccessibilityConstants.getButtonHeight(buttonScale);
  }

  /// Scale a button radius using the button size multiplier
  double scaleButtonRadius([double baseRadius = AccessibilityConstants.baseButtonRadius]) {
    return AccessibilityConstants.getButtonRadius(buttonScale);
  }

  /// Scale padding using the spacing multiplier
  double scalePadding([double basePadding = AccessibilityConstants.basePadding]) {
    return AccessibilityConstants.getPadding(spacingScale);
  }

  /// Scale spacing using the spacing multiplier
  double scaleSpacing(double baseSpacing) {
    return AccessibilityConstants.getSpacing(baseSpacing, spacingScale);
  }

  /// Scale icon size using the button size multiplier
  double scaleIconSize([double baseSize = 20.0]) {
    return AccessibilityConstants.getIconSize(buttonScale);
  }
}
