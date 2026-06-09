import 'package:flutter/material.dart';
import '../constants/colors.dart';

class PengaturanAksesibilitasScreen extends StatefulWidget {
  const PengaturanAksesibilitasScreen({super.key});

  @override
  State<PengaturanAksesibilitasScreen> createState() =>
      _PengaturanAksesibilitasScreenState();
}

class _PengaturanAksesibilitasScreenState
    extends State<PengaturanAksesibilitasScreen> {
  bool _largeText = true;
  bool _voiceControl = false;
  bool _assistiveTouch = true;
  int _buttonSize = 1; // 0=Standard, 1=Large, 2=Maximum
  int _spacing = 1; // 0=Compact, 1=Relaxed

  static const _buttonSizes = ['Standard', 'Large', 'Maximum'];
  static const _spacings = ['Compact', 'Relaxed'];

  @override
  Widget build(BuildContext context) {
    return Scaffold(
      backgroundColor: AppColors.background,
      appBar: AppBar(
        leading: IconButton(
          icon: const Icon(Icons.arrow_back_ios_rounded,
              color: AppColors.primary, size: 20),
          onPressed: () => Navigator.pop(context),
        ),
        title: const Text('FlexiBank'),
        bottom: PreferredSize(
          preferredSize: const Size.fromHeight(1),
          child: Container(height: 1, color: AppColors.border),
        ),
      ),
      body: SingleChildScrollView(
        physics: const BouncingScrollPhysics(),
        padding: const EdgeInsets.all(20),
        child: Column(
          crossAxisAlignment: CrossAxisAlignment.start,
          children: [
            const SizedBox(height: 4),
            const Text(
              'Accessibility',
              style: TextStyle(
                fontSize: 24,
                fontWeight: FontWeight.w700,
                color: AppColors.textPrimary,
              ),
            ),
            const SizedBox(height: 6),
            const Text(
              'Adjust your experience for maximum\nclarity and comfort.',
              style: TextStyle(
                fontSize: 14,
                color: AppColors.textSecondary,
                height: 1.5,
              ),
            ),
            const SizedBox(height: 20),

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
                    value: _largeText,
                    onChanged: (v) => setState(() => _largeText = v),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _toggleItem(
                    icon: Icons.mic_none_rounded,
                    title: 'Voice Control',
                    subtitle: 'Navigate and transact using voice commands',
                    value: _voiceControl,
                    onChanged: (v) => setState(() => _voiceControl = v),
                  ),
                  const Divider(height: 1, color: AppColors.divider),
                  _toggleItem(
                    icon: Icons.touch_app_rounded,
                    title: 'Assistive Touch',
                    subtitle: 'Enables on-screen floating action menu',
                    value: _assistiveTouch,
                    onChanged: (v) => setState(() => _assistiveTouch = v),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 20),

            // Button Sizing card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.fullscreen_rounded,
                          color: AppColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Button Sizing',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Increases the tap area of all interactive elements.',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  _segmentedControl(
                    options: _buttonSizes,
                    selected: _buttonSize,
                    onSelect: (i) => setState(() => _buttonSize = i),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 16),

            // Element Spacing card
            Container(
              padding: const EdgeInsets.all(16),
              decoration: BoxDecoration(
                color: Colors.white,
                borderRadius: BorderRadius.circular(16),
                border: Border.all(color: AppColors.border),
              ),
              child: Column(
                crossAxisAlignment: CrossAxisAlignment.start,
                children: [
                  Row(
                    children: const [
                      Icon(Icons.space_bar_rounded,
                          color: AppColors.primary, size: 20),
                      SizedBox(width: 8),
                      Text(
                        'Element Spacing',
                        style: TextStyle(
                          fontSize: 16,
                          fontWeight: FontWeight.w700,
                          color: AppColors.textPrimary,
                        ),
                      ),
                    ],
                  ),
                  const SizedBox(height: 6),
                  const Text(
                    'Adds more space between items to prevent accidental taps.',
                    style: TextStyle(
                        fontSize: 13, color: AppColors.textSecondary, height: 1.4),
                  ),
                  const SizedBox(height: 14),
                  _segmentedControl(
                    options: _spacings,
                    selected: _spacing,
                    onSelect: (i) => setState(() => _spacing = i),
                  ),
                ],
              ),
            ),
            const SizedBox(height: 32),

            // Save button
            SizedBox(
              width: double.infinity,
              height: 56,
              child: ElevatedButton(
                onPressed: () => Navigator.pop(context),
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
                        fontSize: 12, color: AppColors.textSecondary, height: 1.4),
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
  }) {
    return Container(
      height: 48,
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
