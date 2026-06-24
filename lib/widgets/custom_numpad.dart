import 'package:flutter/material.dart';
import 'package:provider/provider.dart';
import '../constants/colors.dart';
import '../services/accessibility_provider.dart';
import '../utils/accessibility_constants.dart';

class CustomNumpad extends StatelessWidget {
  final Function(String) onKeyPressed;
  final bool showMic;

  const CustomNumpad({
    super.key,
    required this.onKeyPressed,
    this.showMic = true,
  });

  @override
  Widget build(BuildContext context) {
    return Consumer<AccessibilityProvider>(
      builder: (context, accessibilityProvider, _) {
        final buttonScale = accessibilityProvider.getButtonSizeMultiplier();
        final spacingScale = accessibilityProvider.getSpacingMultiplier();

        // Scale dimensions for numpad
        final scaledPadding = AccessibilityConstants.getPadding(spacingScale);
        final keyPadding = scaledPadding * 0.25;
        final scaledKeyTextSize = 26.0 * buttonScale;
        final scaledIconSize = 24.0 * buttonScale;
        final scaledRadius = AccessibilityConstants.getButtonRadius(buttonScale);

        final keys = [
          ['1', '2', '3'],
          ['4', '5', '6'],
          ['7', '8', '9'],
          [showMic ? 'mic' : '', '0', 'backspace'],
        ];

        return Column(
          children: keys.map((row) {
            return Expanded(
              child: Row(
                children: row.map((key) {
                  if (key.isEmpty && !showMic) {
                    return const Expanded(child: SizedBox());
                  }

                  return Expanded(
                    child: Padding(
                      padding: EdgeInsets.all(keyPadding),
                      child: Semantics(
                        label: key == 'backspace'
                            ? 'Delete'
                            : key == 'mic'
                                ? 'Voice input'
                                : key,
                        button: true,
                        child: Material(
                          color: Colors.white,
                          borderRadius: BorderRadius.circular(scaledRadius),
                          child: InkWell(
                            onTap: () => onKeyPressed(key),
                            borderRadius: BorderRadius.circular(scaledRadius),
                            child: Container(
                              decoration: BoxDecoration(
                                borderRadius: BorderRadius.circular(scaledRadius),
                                border: Border.all(color: AppColors.border),
                              ),
                              child: Center(child: _keyContent(key, scaledKeyTextSize, scaledIconSize)),
                            ),
                          ),
                        ),
                      ),
                    ),
                  );
                }).toList(),
              ),
            );
          }).toList(),
        );
      },
    );
  }

  Widget _keyContent(String key, double textSize, double iconSize) {
    if (key == 'backspace') {
      return Icon(Icons.backspace_outlined,
          color: AppColors.textPrimary, size: iconSize);
    }
    if (key == 'mic') {
      return Icon(Icons.mic_none_rounded,
          color: AppColors.textSecondary, size: iconSize + 2);
    }
    return Text(
      key,
      style: TextStyle(
        fontSize: textSize,
        fontWeight: FontWeight.w500,
        color: AppColors.textPrimary,
      ),
    );
  }
}
