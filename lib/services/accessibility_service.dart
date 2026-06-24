import 'package:shared_preferences/shared_preferences.dart';

class AccessibilitySettings {
  final bool largeText;
  final bool voiceControl;
  final bool assistiveTouch;
  final int buttonSize; // 0=Standard, 1=Large, 2=Maximum
  final int spacing; // 0=Compact, 1=Relaxed

  AccessibilitySettings({
    this.largeText = true,
    this.voiceControl = false,
    this.assistiveTouch = true,
    this.buttonSize = 0,  // default: Standard (56dp)
    this.spacing = 1,
  });

  /// Create a copy with modified fields
  AccessibilitySettings copyWith({
    bool? largeText,
    bool? voiceControl,
    bool? assistiveTouch,
    int? buttonSize,
    int? spacing,
  }) {
    return AccessibilitySettings(
      largeText: largeText ?? this.largeText,
      voiceControl: voiceControl ?? this.voiceControl,
      assistiveTouch: assistiveTouch ?? this.assistiveTouch,
      buttonSize: buttonSize ?? this.buttonSize,
      spacing: spacing ?? this.spacing,
    );
  }

  /// Convert to map for SharedPreferences
  Map<String, dynamic> toMap() {
    return {
      'largeText': largeText,
      'voiceControl': voiceControl,
      'assistiveTouch': assistiveTouch,
      'buttonSize': buttonSize,
      'spacing': spacing,
    };
  }

  /// Create from map
  static AccessibilitySettings fromMap(Map<String, dynamic> map) {
    return AccessibilitySettings(
      largeText: map['largeText'] ?? true,
      voiceControl: map['voiceControl'] ?? false,
      assistiveTouch: map['assistiveTouch'] ?? true,
      buttonSize: map['buttonSize'] ?? 0,
      spacing: map['spacing'] ?? 1,
    );
  }
}

class AccessibilityService {
  static const String _prefsKey = 'accessibility_settings';
  static final AccessibilityService _instance = AccessibilityService._internal();

  late SharedPreferences _prefs;
  late AccessibilitySettings _settings;

  AccessibilityService._internal();

  factory AccessibilityService() {
    return _instance;
  }

  /// Initialize the service with SharedPreferences
  Future<void> init() async {
    _prefs = await SharedPreferences.getInstance();
    await _loadSettings();
  }

  /// Load settings from SharedPreferences
  Future<void> _loadSettings() async {
    final String? jsonString = _prefs.getString(_prefsKey);
    if (jsonString != null) {
      try {
        final Map<String, dynamic> map = _parseJson(jsonString);
        _settings = AccessibilitySettings.fromMap(map);
      } catch (e) {
        _settings = AccessibilitySettings();
      }
    } else {
      _settings = AccessibilitySettings();
    }
  }

  /// Save settings to SharedPreferences
  Future<void> _saveSettings() async {
    final String jsonString = _encodeJson(_settings.toMap());
    await _prefs.setString(_prefsKey, jsonString);
  }

  /// Get current settings
  AccessibilitySettings get settings => _settings;

  /// Update large text setting
  Future<void> setLargeText(bool value) async {
    _settings = _settings.copyWith(largeText: value);
    await _saveSettings();
  }

  /// Update voice control setting
  Future<void> setVoiceControl(bool value) async {
    _settings = _settings.copyWith(voiceControl: value);
    await _saveSettings();
  }

  /// Update assistive touch setting
  Future<void> setAssistiveTouch(bool value) async {
    _settings = _settings.copyWith(assistiveTouch: value);
    await _saveSettings();
  }

  /// Update button size setting
  Future<void> setButtonSize(int value) async {
    _settings = _settings.copyWith(buttonSize: value);
    await _saveSettings();
  }

  /// Update spacing setting
  Future<void> setSpacing(int value) async {
    _settings = _settings.copyWith(spacing: value);
    await _saveSettings();
  }

  /// Get text scale factor based on large text setting
  double getTextScaleFactor() {
    return _settings.largeText ? 1.2 : 1.0;
  }

  /// Get button size multiplier
  /// Based on WCAG 2.1 SC 2.5.5 touch target guidelines:
  ///   Standard = 56dp (Material Design default, above 44dp WCAG min)
  ///   Large    = 68dp (~21% larger)
  ///   Maximum  = 80dp (~43% larger, for users with motor impairment)
  double getButtonSizeMultiplier() {
    switch (_settings.buttonSize) {
      case 0:
        return 1.0;      // Standard: 56dp
      case 1:
        return 1.2143;   // Large: 68dp
      case 2:
        return 1.4286;   // Maximum: 80dp
      default:
        return 1.0;
    }
  }

  /// Get spacing multiplier
  double getSpacingMultiplier() {
    return _settings.spacing == 0 ? 0.8 : 1.2; // Compact vs Relaxed
  }

  /// Simple JSON encoding/decoding
  static Map<String, dynamic> _parseJson(String json) {
    final map = <String, dynamic>{};
    final parts = json
        .replaceAll('{', '')
        .replaceAll('}', '')
        .split(',')
        .map((s) => s.trim());
    for (var part in parts) {
      if (part.isEmpty) continue;
      final keyValue = part.split(':');
      if (keyValue.length == 2) {
        final key = keyValue[0].replaceAll('"', '').trim();
        final value = keyValue[1].trim();
        if (value == 'true') {
          map[key] = true;
        } else if (value == 'false') {
          map[key] = false;
        } else if (int.tryParse(value) != null) {
          map[key] = int.parse(value);
        }
      }
    }
    return map;
  }

  static String _encodeJson(Map<String, dynamic> map) {
    final entries = map.entries.map((e) => '"${e.key}":${e.value}').join(',');
    return '{$entries}';
  }

  /// Reset to default settings
  Future<void> resetToDefaults() async {
    _settings = AccessibilitySettings();
    await _saveSettings();
  }
}
