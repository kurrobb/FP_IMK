import 'package:flutter/foundation.dart';
import 'accessibility_service.dart';

class AccessibilityProvider extends ChangeNotifier {
  late AccessibilityService _service;
  late AccessibilitySettings _settings;

  AccessibilitySettings get settings => _settings;

  /// Initialize the provider
  Future<void> init() async {
    _service = AccessibilityService();
    await _service.init();
    _settings = _service.settings;
  }

  /// Update large text setting
  Future<void> setLargeText(bool value) async {
    await _service.setLargeText(value);
    _settings = _service.settings;
    notifyListeners();
  }

  /// Update voice control setting
  Future<void> setVoiceControl(bool value) async {
    await _service.setVoiceControl(value);
    _settings = _service.settings;
    notifyListeners();
  }

  /// Update assistive touch setting
  Future<void> setAssistiveTouch(bool value) async {
    await _service.setAssistiveTouch(value);
    _settings = _service.settings;
    notifyListeners();
  }

  /// Update button size setting
  Future<void> setButtonSize(int value) async {
    await _service.setButtonSize(value);
    _settings = _service.settings;
    notifyListeners();
  }

  /// Update spacing setting
  Future<void> setSpacing(int value) async {
    await _service.setSpacing(value);
    _settings = _service.settings;
    notifyListeners();
  }

  /// Get text scale factor
  double getTextScaleFactor() => _service.getTextScaleFactor();

  /// Get button size multiplier
  double getButtonSizeMultiplier() => _service.getButtonSizeMultiplier();

  /// Get spacing multiplier
  double getSpacingMultiplier() => _service.getSpacingMultiplier();

  /// Reset to default settings
  Future<void> resetToDefaults() async {
    await _service.resetToDefaults();
    _settings = _service.settings;
    notifyListeners();
  }
}
