import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/accessibility_provider.dart';
import '../utils/accessibility_constants.dart';

class PengaturanAksesibilitasScreen extends StatefulWidget {
  final VoidCallback? onNavTap;

  const PengaturanAksesibilitasScreen({super.key, this.onNavTap});

  @override
  State<PengaturanAksesibilitasScreen> createState() =>
      _PengaturanAksesibilitasScreenState();
}

class _PengaturanAksesibilitasScreenState
    extends State<PengaturanAksesibilitasScreen> {
  static const _buttonSizes = ['Standard', 'Large', 'Maximum'];
  static const _spacings = ['Compact', 'Relaxed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        title: const Text('Pengaturan'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: Consumer<AccessibilityProvider>(
        builder: (context, accessibilityProvider, _) {
          final settings = accessibilityProvider.settings;
          final spacingMultiplier = accessibilityProvider.getSpacingMultiplier();

          return SingleChildScrollView(
            physics: const BouncingScrollPhysics(),
            padding: EdgeInsets.all(
              AccessibilityConstants.getPadding(spacingMultiplier),
            ),
            child: Column(
              crossAxisAlignment: CrossAxisAlignment.start,
              children: [
                SizedBox(height: 4 * spacingMultiplier),
                const Text(
                  'Accessibility',
                  style: TextStyle(
                    fontSize: 24,
                    fontWeight: FontWeight.w700,
                    color: AppColors.textPrimary,
                  ),
                ),
                SizedBox(height: 6 * spacingMultiplier),
                const Text(
                  'Adjust your experience for maximum\nclarity and comfort.',
                  style: TextStyle(
                    fontSize: 14,
                    color: AppColors.textSecondary,
                    height: 1.5,
                  ),
                ),
                SizedBox(height: 20 * spacingMultiplier),

                // Toggle settings card
                Container(
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    children: [
                      _toggleItem(
                        icon: Icons.text_fields_rounded,
                        title: 'Large Text Size',
                        subtitle: 'Magnifies all app text for readability',
                        value: settings.largeText,
                        onChanged: (v) =>
                            accessibilityProvider.setLargeText(v),
                      ),
                      const Divider(height: 1, color: AppColors.divider),
                      _toggleItem(
                        icon: Icons.mic_none_rounded,
                        title: 'Voice Control',
                        subtitle: 'Navigate and transact using voice commands',
                        value: settings.voiceControl,
                        onChanged: (v) =>
                            accessibilityProvider.setVoiceControl(v),
                      ),
                      const Divider(height: 1, color: AppColors.divider),
                      _toggleItem(
                        icon: Icons.touch_app_rounded,
                        title: 'Assistive Touch',
                        subtitle: 'Enables on-screen floating action menu',
                        value: settings.assistiveTouch,
                        onChanged: (v) =>
                            accessibilityProvider.setAssistiveTouch(v),
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 20 * spacingMultiplier),

                // Button Sizing card
                Container(
                  padding: EdgeInsets.all(16 * spacingMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.fullscreen_rounded,
                              color: AppColors.primary,
                              size: 20 * spacingMultiplier),
                          SizedBox(width: 8 * spacingMultiplier),
                          const Text(
                            'Button Sizing',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6 * spacingMultiplier),
                      const Text(
                        'Increases the tap area of all interactive elements.',
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4),
                      ),
                      SizedBox(height: 14 * spacingMultiplier),
                      _segmentedControl(
                        options: _buttonSizes,
                        selected: settings.buttonSize,
                        onSelect: (i) =>
                            accessibilityProvider.setButtonSize(i),
                        spacingMultiplier: spacingMultiplier,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 16 * spacingMultiplier),

                // Element Spacing card
                Container(
                  padding: EdgeInsets.all(16 * spacingMultiplier),
                  decoration: BoxDecoration(
                    color: Colors.white,
                    borderRadius: BorderRadius.circular(16),
                    border: Border.all(color: AppColors.border),
                  ),
                  child: Column(
                    crossAxisAlignment: CrossAxisAlignment.start,
                    children: [
                      Row(
                        children: [
                          Icon(Icons.space_bar_rounded,
                              color: AppColors.primary,
                              size: 20 * spacingMultiplier),
                          SizedBox(width: 8 * spacingMultiplier),
                          const Text(
                            'Element Spacing',
                            style: TextStyle(
                              fontSize: 16,
                              fontWeight: FontWeight.w700,
                              color: AppColors.textPrimary,
                            ),
                          ),
                        ],
                      ),
                      SizedBox(height: 6 * spacingMultiplier),
                      const Text(
                        'Adds more space between items to prevent accidental taps.',
                        style: TextStyle(
                            fontSize: 13,
                            color: AppColors.textSecondary,
                            height: 1.4),
                      ),
                      SizedBox(height: 14 * spacingMultiplier),
                      _segmentedControl(
                        options: _spacings,
                        selected: settings.spacing,
                        onSelect: (i) =>
                            accessibilityProvider.setSpacing(i),
                        spacingMultiplier: spacingMultiplier,
                      ),
                    ],
                  ),
                ),
                SizedBox(height: 32 * spacingMultiplier),

                // Save button
                SizedBox(
                  width: double.infinity,
                  height: 56 *
                      accessibilityProvider.getButtonSizeMultiplier(),
                  child: ElevatedButton(
                    onPressed: () {
                      // Navigate to home screen after saving
                      if (widget.onNavTap != null) {
                        widget.onNavTap!.call();
                      }
                    },
                    style: ElevatedButton.styleFrom(
                      backgroundColor: AppColors.primary,
                      elevation: 0,
                      shape: RoundedRectangleBorder(
                          borderRadius: BorderRadius.circular(14)),
                    ),
                    child: const Text(
                      'Save Settings',
                      style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w600,
                          color: Colors.white),
                    ),
                  ),
                ),
              ],
            ),
          );
        },
      ),
    );
  }

  Widget _toggleItem({
    required IconData icon,
    required String title,
    required String subtitle,
    required bool value,
    required ValueChanged<bool> onChanged,
  }) {
    return Semantics(
      label: '$title: ${value ? 'enabled' : 'disabled'}',
      toggled: value,
      child: Padding(
        padding: const EdgeInsets.symmetric(horizontal: 16, vertical: 14),
        child: Row(
          children: [
            Container(
              width: 44,
              height: 44,
              decoration: BoxDecoration(
                color: AppColors.surfaceGray,
                borderRadius: BorderRadius.circular(12),
              ),
              child: Icon(icon, color: AppColors.primary, size: 22),
            ),
            const SizedBox(width: 14),
            Expanded(
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Text(
                    title,
                    style: const TextStyle(
                      fontSize: 15,
                      fontWeight: FontWeight.w600,
                      color: AppColors.textPrimary,
                    ),
                  ),
                  const SizedBox(height: 2),
                  Text(
                    subtitle,
                    style: const TextStyle(
                        fontSize: 12,
                        color: AppColors.textSecondary,
                        height: 1.4),
                  ),
                ],
              ),
            ),
            Switch(
              value: value,
              onChanged: onChanged,
              activeThumbColor: AppColors.primary,
            ),
          ],
        ),
      ),
    );
  }

  Widget _segmentedControl({
    required List<String> options,
    required int selected,
    required ValueChanged<int> onSelect,
    required double spacingMultiplier,
  }) {
    return Container(
      height: 48 * spacingMultiplier,
      decoration: BoxDecoration(
        color: AppColors.surfaceGray,
        borderRadius: BorderRadius.circular(12),
      ),
      child: Row(
        children: options.asMap().entries.map((e) {
          final isSelected = e.key == selected;
          return Expanded(
            child: Semantics(
              label: e.value,
              button: true,
              selected: isSelected,
              child: GestureDetector(
                onTap: () => onSelect(e.key),
                child: AnimatedContainer(
                  duration: const Duration(milliseconds: 180),
                  margin: const EdgeInsets.all(4),
                  decoration: BoxDecoration(
                    color: isSelected ? AppColors.primary : Colors.transparent,
                    borderRadius: BorderRadius.circular(8),
                  ),
                  child: Center(
                    child: Text(
                      e.value,
                      style: TextStyle(
                        fontSize: 13,
                        fontWeight: FontWeight.w600,
                        color: isSelected
                            ? Colors.white
                            : AppColors.textSecondary,
                      ),
                    ),
                  ),
                ),
              ),
            ),
          );
        }).toList(),
      ),
    );
  }
}
