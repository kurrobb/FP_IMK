// Accessibility constants and multipliers
class AccessibilityConstants {
  // Text scale factors
  static const double textScaleNormal = 1.0;
  static const double textScaleLarge = 1.2;

  // Button size multipliers
  static const double buttonSizeStandard = 1.0;
  static const double buttonSizeLarge = 1.15;
  static const double buttonSizeMaximum = 1.3;

  // Spacing multipliers
  static const double spacingCompact = 0.8;
  static const double spacingRelaxed = 1.2;

  // WCAG 2.5.5 Target Size compliance - minimum 44x44 CSS pixels
  // https://www.w3.org/WAI/WCAG21/Understanding/target-size.html
  static const double wcagMinTapTarget = 44.0;

  // Base sizes
  static const double baseButtonHeight = 56.0;
  static const double baseButtonRadius = 14.0;
  static const double basePadding = 20.0;
  static const double baseIconSize = 20.0;

  // Calculated sizes based on settings
  static double getButtonHeight(double multiplier) {
    return baseButtonHeight * multiplier;
  }

  static double getButtonRadius(double multiplier) {
    return baseButtonRadius * (multiplier * 0.5 + 0.5);
  }

  static double getPadding(double multiplier) {
    return basePadding * multiplier;
  }

  static double getIconSize(double multiplier) {
    return baseIconSize * (1.0 + (multiplier - 1.0) * 0.3);
  }

  static double getSpacing(double baseSpacing, double multiplier) {
    return baseSpacing * multiplier;
  }
}
